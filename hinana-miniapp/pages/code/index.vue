<template>
  <view class="page">
    <!-- 顶部成功提示 -->
    <view class="success-header">
      <view class="success-icon">
        <text class="icon">✓</text>
      </view>
      <text class="success-text">领取成功</text>
    </view>

    <!-- 兑换码卡片 -->
    <view class="code-card">
      <view class="code-header">
        <text class="code-label">您的兑换码</text>
        <text class="code-hint">请在有效期内使用</text>
      </view>

      <view class="code-display">
        <text class="code-number">{{ code }}</text>
        <view class="copy-btn" @click="copyCode">
          <text class="copy-icon">📋</text>
          <text class="copy-text">复制</text>
        </view>
      </view>

      <!-- 倒计时 -->
      <view class="countdown-area">
        <view class="countdown-ring">
          <canvas canvas-id="countdownCanvas" class="countdown-canvas"></canvas>
          <view class="countdown-center">
            <text class="countdown-time">{{ formattedTime }}</text>
            <text class="countdown-label">剩余时间</text>
          </view>
        </view>
      </view>

      <view class="code-tip">
        <text class="tip-icon">⏰</text>
        <text class="tip-text">兑换码有效期60秒，请尽快到派样机使用</text>
      </view>
    </view>

    <!-- 用户信息 -->
    <view class="user-info-card">
      <view class="info-row">
        <text class="info-label">姓名</text>
        <text class="info-value">{{ userName }}</text>
      </view>
      <view class="info-divider"></view>
      <view class="info-row">
        <text class="info-label">手机号</text>
        <text class="info-value">{{ formatPhone }}</text>
      </view>
    </view>

    <!-- 使用说明 -->
    <view class="guide-card">
      <view class="guide-header">
        <text class="guide-title">如何使用兑换码</text>
      </view>

      <view class="guide-steps">
        <view class="guide-step">
          <view class="step-icon">
            <text class="step-num">1</text>
          </view>
          <view class="step-content">
            <text class="step-title">前往派样机</text>
            <text class="step-desc">找到最近的派样机终端</text>
          </view>
        </view>

        <view class="guide-arrow">
          <text class="arrow-down">↓</text>
        </view>

        <view class="guide-step">
          <view class="step-icon">
            <text class="step-num">2</text>
          </view>
          <view class="step-content">
            <text class="step-title">输入兑换码</text>
            <text class="step-desc">在机器上输入6位兑换码</text>
          </view>
        </view>

        <view class="guide-arrow">
          <text class="arrow-down">↓</text>
        </view>

        <view class="guide-step">
          <view class="step-icon">
            <text class="step-num">3</text>
          </view>
          <view class="step-content">
            <text class="step-title">领取礼品</text>
            <text class="step-desc">等待机器派发礼品</text>
          </view>
        </view>
      </view>
    </view>

    <!-- 底部提示 -->
    <view class="footer-tip">
      <text class="footer-text">如有疑问，请联系客服</text>
    </view>

    <!-- 过期弹窗 -->
    <view class="expired-modal" v-if="showExpired">
      <view class="modal-mask"></view>
      <view class="modal-content">
        <view class="modal-icon">
          <text class="icon">⏰</text>
        </view>
        <text class="modal-title">兑换码已过期</text>
        <text class="modal-desc">您的兑换码已过期，请重新领取</text>
        <view class="modal-btn" @click="reApply">
          <text class="btn-text">重新领取</text>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
import { formatCountdown } from '@/utils/util.js'

export default {
  data() {
    return {
      code: '',
      userName: '',
      userPhone: '',
      remainSeconds: 60, // 剩余秒数
      timer: null,
      showExpired: false,
      interval: null
    }
  },
  computed: {
    formattedTime() {
      return formatCountdown(this.remainSeconds)
    },
    formatPhone() {
      if (!this.userPhone) return ''
      return this.userPhone.replace(/(\d{3})\d{4}(\d{4})/, '$1****$2')
    }
  },
  onLoad(options) {
    // 获取URL参数
    if (options.code) {
      this.code = options.code
      // 保存到本地存储
      uni.setStorageSync('my_code', options.code)
    }
    if (options.name) {
      this.userName = decodeURIComponent(options.name)
      uni.setStorageSync('my_name', decodeURIComponent(options.name))
    }
    if (options.phone) {
      this.userPhone = options.phone
      uni.setStorageSync('my_phone', options.phone)
    }

    // 开始倒计时
    this.startCountdown()
  },
  onUnload() {
    this.stopCountdown()
  },
  onReady() {
    // 绘制倒计时圆环
    this.drawCountdownRing()
  },
  methods: {
    // 开始倒计时
    startCountdown() {
      this.timer = setInterval(() => {
        if (this.remainSeconds > 0) {
          this.remainSeconds--
          this.updateCountdownRing()
        } else {
          this.stopCountdown()
          this.showExpired = true
        }
      }, 1000)
    },

    // 停止倒计时
    stopCountdown() {
      if (this.timer) {
        clearInterval(this.timer)
        this.timer = null
      }
    },

    // 绘制倒计时圆环
    drawCountdownRing() {
      const ctx = uni.createCanvasContext('countdownCanvas')
      const size = 160
      const lineWidth = 8
      const radius = (size - lineWidth) / 2

      // 背景圆环
      ctx.beginPath()
      ctx.arc(size / 2, size / 2, radius, 0, 2 * Math.PI)
      ctx.setStrokeStyle('#e5e5e5')
      ctx.setLineWidth(lineWidth)
      ctx.stroke()

      // 进度圆环
      const progress = this.remainSeconds / 60
      ctx.beginPath()
      ctx.arc(size / 2, size / 2, radius, -Math.PI / 2, -Math.PI / 2 + (2 * Math.PI * progress), false)
      ctx.setStrokeStyle('#667eea')
      ctx.setLineWidth(lineWidth)
      ctx.stroke()

      ctx.draw()
    },

    // 更新倒计时圆环
    updateCountdownRing() {
      this.drawCountdownRing()
    },

    // 复制兑换码
    copyCode() {
      uni.setClipboardData({
        data: this.code,
        success: () => {
          uni.showToast({
            title: '复制成功',
            icon: 'success'
          })
        },
        fail: () => {
          uni.showToast({
            title: '复制失败',
            icon: 'none'
          })
        }
      })
    },

    // 重新领取
    reApply() {
      this.showExpired = false
      uni.redirectTo({
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
  padding: 30rpx;
  padding-top: env(safe-area-inset-top);
}

/* 成功提示 */
.success-header {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 40rpx 0;
}

.success-icon {
  width: 120rpx;
  height: 120rpx;
  background: #19be6b;
  border-radius: 50%;
  display: flex;
  justify-content: center;
  align-items: center;
  margin-bottom: 20rpx;
  box-shadow: 0 10rpx 30rpx rgba(25, 190, 107, 0.4);
}

.success-icon .icon {
  font-size: 60rpx;
  color: #ffffff;
  font-weight: bold;
}

.success-text {
  font-size: 40rpx;
  font-weight: bold;
  color: #ffffff;
}

/* 兑换码卡片 */
.code-card {
  background: #ffffff;
  border-radius: 24rpx;
  padding: 40rpx 30rpx;
  box-shadow: 0 10rpx 40rpx rgba(0, 0, 0, 0.15);
  margin-bottom: 30rpx;
}

.code-header {
  text-align: center;
  margin-bottom: 30rpx;
}

.code-label {
  font-size: 28rpx;
  color: #333;
  font-weight: bold;
  display: block;
}

.code-hint {
  font-size: 24rpx;
  color: #999;
  margin-top: 8rpx;
  display: block;
}

.code-display {
  display: flex;
  justify-content: center;
  align-items: center;
  margin-bottom: 30rpx;
}

.code-number {
  font-size: 72rpx;
  font-weight: bold;
  color: #667eea;
  letter-spacing: 8rpx;
  font-family: 'Courier New', monospace;
}

.copy-btn {
  display: flex;
  align-items: center;
  background: #f0f5ff;
  padding: 12rpx 20rpx;
  border-radius: 30rpx;
  margin-left: 20rpx;
}

.copy-icon {
  font-size: 28rpx;
  margin-right: 8rpx;
}

.copy-text {
  font-size: 24rpx;
  color: #667eea;
}

/* 倒计时 */
.countdown-area {
  display: flex;
  justify-content: center;
  margin-bottom: 30rpx;
}

.countdown-ring {
  width: 160rpx;
  height: 160rpx;
  position: relative;
}

.countdown-canvas {
  width: 160rpx;
  height: 160rpx;
}

.countdown-center {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  text-align: center;
}

.countdown-time {
  font-size: 36rpx;
  font-weight: bold;
  color: #667eea;
  display: block;
}

.countdown-label {
  font-size: 20rpx;
  color: #999;
  display: block;
  margin-top: 4rpx;
}

.code-tip {
  display: flex;
  align-items: center;
  justify-content: center;
  background: #fff7e6;
  padding: 16rpx 20rpx;
  border-radius: 12rpx;
}

.tip-icon {
  font-size: 28rpx;
  margin-right: 10rpx;
}

.tip-text {
  font-size: 24rpx;
  color: #ff9900;
}

/* 用户信息卡片 */
.user-info-card {
  background: #ffffff;
  border-radius: 20rpx;
  padding: 30rpx;
  box-shadow: 0 5rpx 20rpx rgba(0, 0, 0, 0.1);
  margin-bottom: 30rpx;
}

.info-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16rpx 0;
}

.info-label {
  font-size: 28rpx;
  color: #666;
}

.info-value {
  font-size: 28rpx;
  color: #333;
  font-weight: 500;
}

.info-divider {
  height: 1rpx;
  background: #f0f0f0;
}

/* 使用指南卡片 */
.guide-card {
  background: #ffffff;
  border-radius: 20rpx;
  padding: 30rpx;
  box-shadow: 0 5rpx 20rpx rgba(0, 0, 0, 0.1);
  margin-bottom: 30rpx;
}

.guide-header {
  margin-bottom: 30rpx;
}

.guide-title {
  font-size: 32rpx;
  font-weight: bold;
  color: #333;
}

.guide-steps {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.guide-step {
  display: flex;
  align-items: center;
  width: 100%;
}

.step-icon {
  width: 64rpx;
  height: 64rpx;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 50%;
  display: flex;
  justify-content: center;
  align-items: center;
  margin-right: 20rpx;
  flex-shrink: 0;
}

.step-num {
  font-size: 28rpx;
  font-weight: bold;
  color: #ffffff;
}

.step-content {
  flex: 1;
}

.step-title {
  font-size: 28rpx;
  color: #333;
  font-weight: 500;
  display: block;
}

.step-desc {
  font-size: 24rpx;
  color: #999;
  display: block;
  margin-top: 4rpx;
}

.guide-arrow {
  padding: 20rpx 0;
}

.arrow-down {
  font-size: 32rpx;
  color: #cccccc;
}

/* 底部提示 */
.footer-tip {
  text-align: center;
  padding: 20rpx 0;
}

.footer-text {
  font-size: 24rpx;
  color: rgba(255, 255, 255, 0.7);
}

/* 过期弹窗 */
.expired-modal {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  z-index: 999;
  display: flex;
  justify-content: center;
  align-items: center;
}

.modal-mask {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.6);
}

.modal-content {
  position: relative;
  background: #ffffff;
  border-radius: 24rpx;
  padding: 60rpx 40rpx;
  width: 600rpx;
  text-align: center;
  box-shadow: 0 20rpx 60rpx rgba(0, 0, 0, 0.3);
}

.modal-icon {
  width: 120rpx;
  height: 120rpx;
  background: #fff7e6;
  border-radius: 50%;
  display: flex;
  justify-content: center;
  align-items: center;
  margin: 0 auto 30rpx;
}

.modal-icon .icon {
  font-size: 60rpx;
}

.modal-title {
  font-size: 36rpx;
  font-weight: bold;
  color: #333;
  display: block;
  margin-bottom: 16rpx;
}

.modal-desc {
  font-size: 28rpx;
  color: #666;
  display: block;
  margin-bottom: 40rpx;
}

.modal-btn {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 48rpx;
  padding: 24rpx 60rpx;
  display: inline-block;
}

.modal-btn .btn-text {
  font-size: 32rpx;
  font-weight: bold;
  color: #ffffff;
}
</style>
