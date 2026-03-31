<template>
  <view class="page">
    <!-- 顶部装饰 -->
    <view class="top-decoration">
      <view class="decoration-circle circle1"></view>
      <view class="decoration-circle circle2"></view>
    </view>

    <!-- 主内容卡片 -->
    <view class="main-card">
      <!-- 用户信息 -->
      <view class="user-info">
        <text class="user-name">{{ name || '用户' }}</text>
        <text class="user-phone">{{ formatPhone(phone) }}</text>
      </view>

      <!-- 状态标签 -->
      <view class="status-badge" :class="statusClass">
        <text class="status-text">{{ statusText }}</text>
      </view>

      <!-- 兑换码展示 -->
      <view class="code-display" :class="{ 'code-used': status !== 'valid' }">
        <text class="code-label">您的兑换码</text>
        <text class="code-number">{{ code }}</text>
        <text class="code-hint" v-if="status === 'valid'">{{ tip || '请在有效期内到派样机输入兑换' }}</text>
        <text class="code-hint expired-hint" v-else>{{ tip || '该兑换码已失效' }}</text>
      </view>

      <!-- 有效时长提示 -->
      <view class="validity-info" v-if="status === 'valid'">
        <view class="clock-icon">
          <text>⏰</text>
        </view>
        <text class="validity-text">兑换码 {{ validityText }}</text>
      </view>
    </view>

    <!-- 使用说明 -->
    <view class="usage-guide">
      <view class="guide-header">
        <text class="guide-title">如何使用</text>
      </view>
      <view class="guide-steps">
        <view class="step-item">
          <view class="step-num">1</view>
          <text class="step-text">前往派样机终端</text>
        </view>
        <view class="step-arrow">
          <text>></text>
        </view>
        <view class="step-item">
          <view class="step-num">2</view>
          <text class="step-text">输入兑换码</text>
        </view>
        <view class="step-arrow">
          <text>></text>
        </view>
        <view class="step-item">
          <view class="step-num">3</view>
          <text class="step-text">领取礼品</text>
        </view>
      </view>
    </view>

    <!-- 底部按钮 -->
    <view class="bottom-actions">
      <button class="action-btn secondary" @click="goClaim" v-if="status !== 'valid'">
        <text>重新领取</text>
      </button>
      <button class="action-btn primary" @click="copyCode">
        <text>复制兑换码</text>
      </button>
    </view>

    <!-- 温馨提示 -->
    <view class="tips-section">
      <text class="tips-title">温馨提示</text>
      <text class="tips-text">兑换码有效期为60秒，请在有效期内使用。如有疑问请联系工作人员。</text>
    </view>
  </view>
</template>

<script>
export default {
  data() {
    return {
      code: '',
      name: '',
      phone: '',
      status: 'valid',
      tip: '',
      expireTime: ''
    }
  },
  computed: {
    statusClass() {
      return {
        'status-valid': this.status === 'valid',
        'status-used': this.status === 'used',
        'status-expired': this.status === 'expired'
      }
    },
    statusText() {
      const map = {
        'valid': '可使用',
        'used': '已使用',
        'expired': '已过期'
      }
      return map[this.status] || '未知'
    },
    validityText() {
      return '60秒内有效'
    }
  },
  onLoad(options) {
    if (options.code) this.code = options.code
    if (options.name) this.name = decodeURIComponent(options.name)
    if (options.phone) this.phone = options.phone
    if (options.status) this.status = options.status
    if (options.tip) this.tip = decodeURIComponent(options.tip)
  },
  methods: {
    formatPhone(phone) {
      if (!phone || phone.length !== 11) return phone
      return phone.replace(/(\d{3})\d{4}(\d{4})/, '$1****$2')
    },
    
    goClaim() {
      uni.redirectTo({
        url: '/pages/info/index'
      })
    },
    
    copyCode() {
      uni.setClipboardData({
        data: this.code,
        success: () => {
          uni.showToast({
            title: '复制成功',
            icon: 'success'
          })
        }
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

/* 顶部装饰 */
.top-decoration {
  position: relative;
  height: 200rpx;
}

.decoration-circle {
  position: absolute;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.1);
}

.circle1 {
  width: 300rpx;
  height: 300rpx;
  top: -100rpx;
  left: -100rpx;
}

.circle2 {
  width: 200rpx;
  height: 200rpx;
  top: -50rpx;
  right: -50rpx;
}

/* 主卡片 */
.main-card {
  margin: 0 30rpx;
  background: #ffffff;
  border-radius: 32rpx;
  padding: 50rpx 40rpx;
  box-shadow: 0 20rpx 60rpx rgba(0, 0, 0, 0.2);
  position: relative;
}

/* 用户信息 */
.user-info {
  text-align: center;
  margin-bottom: 30rpx;
}

.user-name {
  font-size: 36rpx;
  font-weight: bold;
  color: #333;
  margin-right: 16rpx;
}

.user-phone {
  font-size: 28rpx;
  color: #999;
}

/* 状态标签 */
.status-badge {
  display: flex;
  justify-content: center;
  margin-bottom: 40rpx;
}

.status-badge text {
  padding: 10rpx 30rpx;
  border-radius: 30rpx;
  font-size: 24rpx;
  font-weight: 500;
}

.status-valid text {
  background: #e8f5e9;
  color: #4caf50;
}

.status-used text {
  background: #f5f5f5;
  color: #999;
}

.status-expired text {
  background: #ffebee;
  color: #f44336;
}

/* 兑换码展示 */
.code-display {
  text-align: center;
  padding: 50rpx 0;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 24rpx;
  margin-bottom: 30rpx;
}

.code-display.code-used {
  background: #f5f5f5;
}

.code-label {
  font-size: 26rpx;
  color: rgba(255, 255, 255, 0.8);
  display: block;
  margin-bottom: 16rpx;
}

.code-used .code-label {
  color: #999;
}

.code-number {
  font-size: 96rpx;
  font-weight: bold;
  color: #ffffff;
  letter-spacing: 12rpx;
  display: block;
  font-family: 'Courier New', monospace;
}

.code-used .code-number {
  color: #999;
}

.code-hint {
  font-size: 24rpx;
  color: rgba(255, 255, 255, 0.7);
  display: block;
  margin-top: 20rpx;
}

.code-hint.expired-hint {
  color: #f44336;
}

/* 有效时长 */
.validity-info {
  display: flex;
  align-items: center;
  justify-content: center;
}

.clock-icon text {
  font-size: 32rpx;
  margin-right: 10rpx;
}

.validity-text {
  font-size: 26rpx;
  color: #666;
}

/* 使用说明 */
.usage-guide {
  margin: 40rpx 30rpx;
  background: rgba(255, 255, 255, 0.95);
  border-radius: 24rpx;
  padding: 30rpx;
}

.guide-header {
  margin-bottom: 24rpx;
}

.guide-title {
  font-size: 28rpx;
  font-weight: bold;
  color: #333;
}

.guide-steps {
  display: flex;
  align-items: center;
  justify-content: center;
}

.step-item {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.step-num {
  width: 56rpx;
  height: 56rpx;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: #ffffff;
  border-radius: 50%;
  font-size: 28rpx;
  font-weight: bold;
  display: flex;
  justify-content: center;
  align-items: center;
  margin-bottom: 10rpx;
}

.step-text {
  font-size: 24rpx;
  color: #666;
}

.step-arrow {
  padding: 0 20rpx;
  color: #ccc;
  font-size: 32rpx;
}

/* 底部按钮 */
.bottom-actions {
  display: flex;
  gap: 24rpx;
  padding: 0 30rpx;
  margin-bottom: 30rpx;
}

.action-btn {
  flex: 1;
  height: 96rpx;
  border-radius: 48rpx;
  display: flex;
  justify-content: center;
  align-items: center;
  font-size: 32rpx;
  font-weight: bold;
}

.action-btn.primary {
  background: #ffffff;
  color: #667eea;
  box-shadow: 0 10rpx 30rpx rgba(0, 0, 0, 0.15);
}

.action-btn.secondary {
  background: rgba(255, 255, 255, 0.3);
  color: #ffffff;
}

/* 温馨提示 */
.tips-section {
  padding: 0 30rpx;
  text-align: center;
}

.tips-title {
  font-size: 24rpx;
  font-weight: bold;
  color: rgba(255, 255, 255, 0.9);
  display: block;
  margin-bottom: 10rpx;
}

.tips-text {
  font-size: 22rpx;
  color: rgba(255, 255, 255, 0.6);
  display: block;
  line-height: 1.6;
}
</style>
