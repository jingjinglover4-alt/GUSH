/**
 * 工具函数
 */

/**
 * 验证手机号格式
 * @param {string} phone - 手机号
 * @returns {boolean}
 */
export function validatePhone(phone) {
  const reg = /^1[3-9]\d{9}$/
  return reg.test(phone)
}

/**
 * 生成6位随机数字码
 * @returns {string}
 */
export function generateRandomCode() {
  return Math.random().toString().slice(2, 8).padStart(6, '0')
}

/**
 * 格式化倒计时
 * @param {number} seconds - 秒数
 * @returns {string}
 */
export function formatCountdown(seconds) {
  const min = Math.floor(seconds / 60)
  const sec = seconds % 60
  return `${String(min).padStart(2, '0')}:${String(sec).padStart(2, '0')}`
}

/**
 * 深拷贝
 * @param {any} obj
 * @returns {any}
 */
export function deepClone(obj) {
  if (obj === null || typeof obj !== 'object') return obj
  if (obj instanceof Date) return new Date(obj)
  if (obj instanceof Array) return obj.map(item => deepClone(item))
  if (obj instanceof Object) {
    const clonedObj = {}
    for (const key in obj) {
      if (obj.hasOwnProperty(key)) {
        clonedObj[key] = deepClone(obj[key])
      }
    }
    return clonedObj
  }
}

export default {
  validatePhone,
  generateRandomCode,
  formatCountdown,
  deepClone
}
