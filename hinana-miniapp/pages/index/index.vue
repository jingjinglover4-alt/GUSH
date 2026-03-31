<template>
  <view class="page">
    <!-- 顶部产品图区域 -->
    <view class="product-banner">
      <image class="product-img" src="/static/product-placeholder.png" mode="aspectFill"></image>
      <view class="banner-overlay">
        <view class="brand-tag">
          <text class="brand-icon">🎁</text>
          <text class="brand-name">HI拿智能派样</text>
        </view>
      </view>
    </view>

    <!-- 产品信息卡片 -->
    <view class="product-card">
      <view class="card-header">
        <text class="product-title">新品体验 限时领取</text>
        <text class="product-subtitle">填写信息即可获得专属兑换码</text>
      </view>
      
      <view class="product-features">
        <view class="feature-item">
          <text class="feature-icon">✨</text>
          <text class="feature-text">正品保障</text>
        </view>
        <view class="feature-item">
          <text class="feature-icon">🚚</text>
          <text class="feature-text">现场领取</text>
        </view>
        <view class="feature-item">
          <text class="feature-icon">⏰</text>
          <text class="feature-text">限时活动</text>
        </view>
      </view>
    </view>

    <!-- 领取入口 -->
    <view class="action-section">
      <view class="action-card" @click="goToClaim">
        <view class="action-left">
          <text class="action-icon">📦</text>
          <view class="action-info">
            <text class="action-title">还没有兑换码？</text>
            <text class="action-desc">立即领取专属礼品</text>
          </view>
        </view>
        <text class="action-arrow">></text>
      </view>
    </view>

    <!-- 手机号查询区域 -->
    <view class="query-section">
      <view class="query-card">
        <text class="query-title">找回我的兑换码</text>
        <text class="query-desc">忘记兑换码？输入手机号立即找回</text>
        
        <view class="phone-input-wrapper">
          <input
            class="phone-input"
            type="number"
            v-model="phone"
            :placeholder="localPhone ? '已保存手机号：' + localPhone : '请输入手机号'"
            placeholder-class="placeholder"
            maxlength="11"
          />
        </view>
        
        <button
          class="query-btn"
          :class="{ disabled: !canQuery }"
          @click="queryMyCode"
          :disabled="!canQuery"
        >
          <text class="btn-text">立即找回</text>
        </button>
      </view>
    </view>

    <!-- 活动说明 -->
    <view class="activity-info">
      <view class="info-header">
        <text class="info-title">活动说明</text>
      </view>
      <view class="info-list">
        <view class="info-item">
          <text class="info-num">1</text>
          <text class="info-text">填写信息获取兑换码</text>
        </view>
        <view class="info-item">
          <text class="info-num">2</text>
          <text class="info-text">前往派样机终端</text>
        </view>
        <view class="info-item">
          <text class="info-num">3</text>
          <text class="info-text">输入兑换码领取礼品</text>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
import { queryCode } from '@/utils/api.js'
import { validatePhone } from '@/utils/util.js'

export default {
  data() {
    return {
      phone: '',
      localCode: '',
      localName: '',
      localPhone: ''
    }
  },
  computed: {
    canQuery() {
      return validatePhone(this.phone)
    }
  },
  onLoad() {
    // 页面加载时检查本地存储的兑换码
    this.checkLocalCode()
  },
  onShow() {
    // 每次显示页面时检查本地存储
    this.checkLocalCode()
  },
  methods: {
    // 检查本地存储的兑换码
    checkLocalCode() {
      try {
        const savedCode = uni.getStorageSync('my_code')
        const savedPhone = uni.getStorageSync('my_phone')
        const savedName = uni.getStorageSync('my_name')
        
        if (savedCode && savedPhone) {
          this.localCode = savedCode
          this.localPhone = savedPhone
          this.localName = savedName || ''
          // 自动填充手机号到输入框
          this.phone = savedPhone
        } else {
          this.localCode = ''
          this.localPhone = ''
          this.localName = ''
          this.phone = ''
        }
      } catch (e) {
        console.log('读取本地存储失败', e)
      }
    },
    
    // 查询我的兑换码
    async queryMyCode() {
      if (!this.canQuery) return
      
      try {
        const res = await queryCode(this.phone.trim())
        
        if (res.code === 404) {
          // 今日无兑换码
          uni.showModal({
            title: '提示',
            content: '今日暂无兑换码，点击确定去领取',
            confirmText: '去领取',
            success: (modalRes) => {
              if (modalRes.confirm) {
                this.goToClaim()
              }
            }
          })
          return
        }
        
        // 有兑换码，跳转到兑换码页面
        if (res.data) {
          // 同时保存到本地
          uni.setStorageSync('my_code', res.data.code)
          uni.setStorageSync('my_phone', res.data.phone)
          uni.setStorageSync('my_name', res.data.name)
          
          uni.navigateTo({
            url: `/pages/mycode/index?code=${res.data.code}&name=${res.data.name}&phone=${res.data.phone}&status=${res.data.status}&tip=${res.data.tip || ''}`
          })
        }
      } catch (err) {
        console.log('查询失败', err)
      }
    },
    
    // 跳转到领取页面
    goToClaim() {
      uni.navigateTo({
        url: '/pages/info/index'
      })
    }
  }
}
</script>

<style scoped>
.page {
  min-height: 100vh;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  padding-bottom: 60rpx;
}

/* 产品横幅 */
.product-banner {
  position: relative;
  height: 400rpx;
  overflow: hidden;
}

.product-img {
  width: 100%;
  height: 100%;
  background: linear-gradient(135deg, #ff6b6b 0%, #ee5a5a 100%);
}

.banner-overlay {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  padding: 30rpx;
  background: linear-gradient(transparent, rgba(0,0,0,0.5));
}

.brand-tag {
  display: flex;
  align-items: center;
  background: rgba(255, 255, 255, 0.95);
  padding: 16rpx 30rpx;
  border-radius: 50rpx;
  width: fit-content;
}

.brand-icon {
  font-size: 32rpx;
  margin-right: 12rpx;
}

.brand-name {
  font-size: 28rpx;
  font-weight: bold;
  color: #333;
}

/* 产品信息卡片 */
.product-card {
  margin: -60rpx 30rpx 30rpx;
  background: #ffffff;
  border-radius: 24rpx;
  padding: 40rpx 30rpx;
  box-shadow: 0 10rpx 40rpx rgba(0, 0, 0, 0.15);
  position: relative;
  z-index: 10;
}

.card-header {
  text-align: center;
  margin-bottom: 30rpx;
}

.product-title {
  font-size: 40rpx;
  font-weight: bold;
  color: #333;
  display: block;
}

.product-subtitle {
  font-size: 26rpx;
  color: #999;
  margin-top: 12rpx;
  display: block;
}

.product-features {
  display: flex;
  justify-content: space-around;
  padding-top: 20rpx;
  border-top: 1rpx solid #f0f0f0;
}

.feature-item {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.feature-icon {
  font-size: 48rpx;
  margin-bottom: 10rpx;
}

.feature-text {
  font-size: 24rpx;
  color: #666;
}

/* 查询区域 */
.query-section {
  padding: 0 30rpx;
  margin-bottom: 30rpx;
}

.query-card {
  background: #ffffff;
  border-radius: 24rpx;
  padding: 40rpx 30rpx;
  box-shadow: 0 10rpx 40rpx rgba(0, 0, 0, 0.15);
}

.query-title {
  font-size: 32rpx;
  font-weight: bold;
  color: #333;
  display: block;
  text-align: center;
  margin-bottom: 10rpx;
}

.query-desc {
  font-size: 24rpx;
  color: #999;
  display: block;
  text-align: center;
  margin-bottom: 30rpx;
}

.phone-input-wrapper {
  margin-bottom: 24rpx;
}

.phone-input {
  width: 100%;
  height: 90rpx;
  background: #f8f9fa;
  border-radius: 16rpx;
  padding: 0 24rpx;
  font-size: 28rpx;
  color: #333;
  text-align: center;
}

.placeholder {
  color: #cccccc;
}

.query-btn {
  width: 100%;
  height: 96rpx;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 48rpx;
  display: flex;
  justify-content: center;
  align-items: center;
  box-shadow: 0 10rpx 30rpx rgba(102, 126, 234, 0.4);
}

.query-btn.disabled {
  background: linear-gradient(135deg, #cccccc 0%, #bbbbbb 100%);
  box-shadow: none;
}

.btn-text {
  font-size: 32rpx;
  font-weight: bold;
  color: #ffffff;
}

/* 领取入口 */
.action-section {
  padding: 0 30rpx;
  margin-bottom: 30rpx;
}

.action-card {
  background: #ffffff;
  border-radius: 24rpx;
  padding: 30rpx;
  display: flex;
  align-items: center;
  justify-content: space-between;
  box-shadow: 0 10rpx 40rpx rgba(0, 0, 0, 0.15);
}

.action-left {
  display: flex;
  align-items: center;
}

.action-icon {
  font-size: 56rpx;
  margin-right: 20rpx;
}

.action-title {
  font-size: 30rpx;
  font-weight: bold;
  color: #333;
  display: block;
}

.action-desc {
  font-size: 24rpx;
  color: #999;
  display: block;
  margin-top: 6rpx;
}

.action-arrow {
  font-size: 36rpx;
  color: #999;
}

/* 活动说明 */
.activity-info {
  margin: 0 30rpx;
  background: rgba(255, 255, 255, 0.9);
  border-radius: 20rpx;
  padding: 30rpx;
}

.info-header {
  margin-bottom: 20rpx;
}

.info-title {
  font-size: 28rpx;
  font-weight: bold;
  color: #333;
}

.info-list {
  display: flex;
  flex-direction: column;
}

.info-item {
  display: flex;
  align-items: center;
  margin-bottom: 16rpx;
}

.info-item:last-child {
  margin-bottom: 0;
}

.info-num {
  width: 44rpx;
  height: 44rpx;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: #ffffff;
  border-radius: 50%;
  font-size: 24rpx;
  font-weight: bold;
  display: flex;
  justify-content: center;
  align-items: center;
  margin-right: 16rpx;
  flex-shrink: 0;
}

.info-text {
  font-size: 26rpx;
  color: #666;
}
</style>
