<template>
  <view class="page">
    <!-- 顶部背景 -->
    <view class="top-bg">
      <view class="brand-area">
        <view class="logo">
          <text class="logo-icon">🎁</text>
        </view>
        <view class="brand-text">
          <text class="brand-name">HI拿智能派样</text>
          <text class="brand-slogan">让领取更有趣</text>
        </view>
      </view>
    </view>

    <!-- 表单区域 -->
    <view class="form-container">
      <view class="form-card">
        <view class="card-header">
          <text class="card-title">填写领取信息</text>
          <text class="card-subtitle">完成信息填写即可获取兑换码</text>
        </view>

        <view class="form-body">
          <!-- 姓名 -->
          <view class="form-item">
            <view class="form-label">
              <text class="label-icon">👤</text>
              <text class="label-text">姓名</text>
            </view>
            <input
              class="form-input"
              type="text"
              v-model="formData.name"
              placeholder="请输入您的姓名"
              placeholder-class="placeholder"
              maxlength="20"
            />
          </view>

          <!-- 手机号 -->
          <view class="form-item">
            <view class="form-label">
              <text class="label-icon">📱</text>
              <text class="label-text">手机号</text>
            </view>
            <input
              class="form-input"
              type="number"
              v-model="formData.phone"
              placeholder="请输入手机号码"
              placeholder-class="placeholder"
              maxlength="11"
            />
          </view>

          <!-- 验证码（可选） -->
          <view class="form-item">
            <view class="form-label">
              <text class="label-icon">🔐</text>
              <text class="label-text">验证码</text>
              <text class="label-optional">（选填）</text>
            </view>
            <view class="code-input-wrapper">
              <input
                class="form-input code-input"
                type="number"
                v-model="formData.code"
                placeholder="请输入验证码"
                placeholder-class="placeholder"
                maxlength="6"
              />
              <view
                class="code-btn"
                :class="{ disabled: counting }"
                @click="sendCode"
              >
                <text v-if="!counting">获取验证码</text>
                <text v-else>{{ countDown }}s</text>
              </view>
            </view>
          </view>

          <!-- 协议勾选 -->
          <view class="agreement-area">
            <view class="checkbox-wrapper" @click="toggleAgreement">
              <view class="checkbox" :class="{ checked: agreed }">
                <text v-if="agreed" class="check-icon">✓</text>
              </view>
              <text class="agreement-text">
                我已阅读并同意
                <text class="link" @click.stop="showAgreement">《用户服务协议》</text>
                和
                <text class="link" @click.stop="showPrivacy">《隐私政策》</text>
              </text>
            </view>
          </view>

          <!-- 提交按钮 -->
          <view class="submit-btn-wrapper">
            <button
              class="submit-btn"
              :class="{ disabled: !canSubmit }"
              @click="submitForm"
              :disabled="!canSubmit"
            >
              <text class="btn-text">立即领取</text>
            </button>
          </view>
        </view>

        <view class="card-footer">
          <text class="footer-tip">* 提交后系统将自动生成6位兑换码</text>
        </view>
      </view>
    </view>

    <!-- 活动说明 -->
    <view class="activity-info">
      <view class="info-header">
        <text class="info-title">📋 活动说明</text>
      </view>
      <view class="info-list">
        <view class="info-item">
          <text class="info-num">1</text>
          <text class="info-text">填写信息获取兑换码（有效期60秒）</text>
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
import { validatePhone } from '@/utils/util.js'
import { generateCode } from '@/utils/api.js'

export default {
  data() {
    return {
      formData: {
        name: '',
        phone: '',
        code: ''
      },
      agreed: false,
      counting: false,
      countDown: 60,
      timer: null,
      machineId: '' // 从URL参数获取
    }
  },
  computed: {
    canSubmit() {
      return (
        this.formData.name.trim().length > 0 &&
        validatePhone(this.formData.phone) &&
        this.agreed
      )
    }
  },
  onLoad(options) {
    // 获取机器ID参数
    if (options.machine_id) {
      this.machineId = options.machine_id
    }
  },
  onUnload() {
    // 清除定时器
    if (this.timer) {
      clearInterval(this.timer)
    }
  },
  methods: {
    // 发送验证码
    sendCode() {
      if (this.counting) return

      if (!validatePhone(this.formData.phone)) {
        uni.showToast({
          title: '请输入正确的手机号',
          icon: 'none'
        })
        return
      }

      // TODO: 调用发送验证码API
      uni.showToast({
        title: '验证码已发送',
        icon: 'success'
      })

      // 开始倒计时
      this.counting = true
      this.countDown = 60
      this.timer = setInterval(() => {
        this.countDown--
        if (this.countDown <= 0) {
          this.counting = false
          clearInterval(this.timer)
        }
      }, 1000)
    },

    // 勾选协议
    toggleAgreement() {
      this.agreed = !this.agreed
    },

    // 显示用户协议
    showAgreement() {
      uni.showModal({
        title: '用户服务协议',
        content: '这里是用户服务协议的内容...',
        showCancel: false,
        confirmText: '我知道了'
      })
    },

    // 显示隐私政策
    showPrivacy() {
      uni.showModal({
        title: '隐私政策',
        content: '这里是隐私政策的内容...',
        showCancel: false,
        confirmText: '我知道了'
      })
    },

    // 提交表单
    async submitForm() {
      if (!this.canSubmit) return

      uni.showLoading({ title: '提交中...' })

      try {
        const res = await generateCode({
          name: this.formData.name.trim(),
          phone: this.formData.phone.trim(),
          machine_id: this.machineId || 'default'
        })

        uni.hideLoading()

        if (res.code === 200) {
          // 跳转到我的兑换码页面
          uni.redirectTo({
            url: `/pages/mycode/index?code=${res.data.code}&name=${encodeURIComponent(this.formData.name)}&phone=${this.formData.phone}&status=valid`
          })
        }
      } catch (err) {
        uni.hideLoading()
        // 模拟成功（开发阶段）
        const mockCode = Math.random().toString().slice(2, 8).padStart(6, '0')
        uni.redirectTo({
          url: `/pages/mycode/index?code=${mockCode}&name=${encodeURIComponent(this.formData.name)}&phone=${this.formData.phone}&status=valid`
        })
      }
    }
  }
}
</script>

<style scoped>
.page {
  min-height: 100vh;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  padding-bottom: 40rpx;
}

/* 顶部背景 */
.top-bg {
  padding: 60rpx 30rpx 80rpx;
  display: flex;
  justify-content: center;
}

.brand-area {
  display: flex;
  align-items: center;
  background: rgba(255, 255, 255, 0.95);
  padding: 30rpx 40rpx;
  border-radius: 20rpx;
  box-shadow: 0 10rpx 30rpx rgba(0, 0, 0, 0.15);
}

.logo {
  width: 100rpx;
  height: 100rpx;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 24rpx;
  display: flex;
  justify-content: center;
  align-items: center;
  margin-right: 24rpx;
}

.logo-icon {
  font-size: 50rpx;
}

.brand-text {
  display: flex;
  flex-direction: column;
}

.brand-name {
  font-size: 36rpx;
  font-weight: bold;
  color: #333;
}

.brand-slogan {
  font-size: 24rpx;
  color: #999;
  margin-top: 8rpx;
}

/* 表单区域 */
.form-container {
  padding: 0 30rpx;
  margin-top: -40rpx;
}

.form-card {
  background: #ffffff;
  border-radius: 24rpx;
  box-shadow: 0 10rpx 40rpx rgba(0, 0, 0, 0.15);
  overflow: hidden;
}

.card-header {
  padding: 40rpx 30rpx 20rpx;
  text-align: center;
  border-bottom: 1rpx solid #f0f0f0;
}

.card-title {
  font-size: 36rpx;
  font-weight: bold;
  color: #333;
  display: block;
}

.card-subtitle {
  font-size: 26rpx;
  color: #999;
  margin-top: 10rpx;
  display: block;
}

.form-body {
  padding: 30rpx;
}

.form-item {
  margin-bottom: 30rpx;
}

.form-label {
  display: flex;
  align-items: center;
  margin-bottom: 16rpx;
}

.label-icon {
  font-size: 32rpx;
  margin-right: 12rpx;
}

.label-text {
  font-size: 28rpx;
  color: #333;
  font-weight: 500;
}

.label-optional {
  font-size: 24rpx;
  color: #999;
  margin-left: 10rpx;
}

.form-input {
  width: 100%;
  height: 90rpx;
  background: #f8f9fa;
  border-radius: 16rpx;
  padding: 0 24rpx;
  font-size: 28rpx;
  color: #333;
}

.placeholder {
  color: #cccccc;
}

.code-input-wrapper {
  display: flex;
  align-items: center;
}

.code-input {
  flex: 1;
  margin-right: 20rpx;
}

.code-btn {
  width: 220rpx;
  height: 90rpx;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 16rpx;
  display: flex;
  justify-content: center;
  align-items: center;
  font-size: 24rpx;
  color: #ffffff;
  flex-shrink: 0;
}

.code-btn.disabled {
  background: #cccccc;
}

/* 协议 */
.agreement-area {
  margin-top: 30rpx;
  margin-bottom: 30rpx;
}

.checkbox-wrapper {
  display: flex;
  align-items: flex-start;
}

.checkbox {
  width: 40rpx;
  height: 40rpx;
  border: 2rpx solid #ddd;
  border-radius: 8rpx;
  margin-right: 16rpx;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-shrink: 0;
  margin-top: 4rpx;
}

.checkbox.checked {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-color: #667eea;
}

.check-icon {
  color: #ffffff;
  font-size: 24rpx;
  font-weight: bold;
}

.agreement-text {
  font-size: 24rpx;
  color: #666;
  line-height: 5rpx;
}

.link {
  color: #667eea;
}

/* 提交按钮 */
.submit-btn-wrapper {
  margin-top: 20rpx;
}

.submit-btn {
  width: 100%;
  height: 96rpx;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 48rpx;
  display: flex;
  justify-content: center;
  align-items: center;
  box-shadow: 0 10rpx 30rpx rgba(102, 126, 234, 0.4);
}

.submit-btn.disabled {
  background: linear-gradient(135deg, #cccccc 0%, #bbbbbb 100%);
  box-shadow: none;
}

.btn-text {
  font-size: 32rpx;
  font-weight: bold;
  color: #ffffff;
}

/* 卡片底部 */
.card-footer {
  padding: 20rpx 30rpx 30rpx;
  text-align: center;
}

.footer-tip {
  font-size: 22rpx;
  color: #999;
}

/* 活动说明 */
.activity-info {
  margin: 40rpx 30rpx 0;
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
