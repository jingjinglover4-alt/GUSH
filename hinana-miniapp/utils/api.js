/**
 * API 请求工具
 */

// API 基础地址 - 根据环境切换
// 备案通过后改为 https://cdgushai.com/api
const BASE_URL = 'http://150.158.20.232/api'

/**
 * 请求封装
 * @param {string} url - 请求地址
 * @param {object} data - 请求数据
 * @param {string} method - 请求方法
 */
function request(url, data = {}, method = 'POST') {
  return new Promise((resolve, reject) => {
    uni.showLoading({ title: '加载中...' })
    
    uni.request({
      url: BASE_URL + url,
      data: data,
      method: method,
      header: {
        'Content-Type': 'application/json'
      },
      success: (res) => {
        uni.hideLoading()
        if (res.data.code === 200 || res.data.code === 0) {
          resolve(res.data)
        } else {
          uni.showToast({
            title: res.data.message || '请求失败',
            icon: 'none'
          })
          reject(res.data)
        }
      },
      fail: (err) => {
        uni.hideLoading()
        uni.showToast({
          title: '网络请求失败',
          icon: 'none'
        })
        reject(err)
      }
    })
  })
}

/**
 * 生成兑换码
 * @param {object} params - {name, phone, machine_id}
 */
export function generateCode(params) {
  return request('/generate_code', params, 'POST')
}

/**
 * 核销兑换码
 * @param {string} code - 6位兑换码
 * @param {string} machine_id - 机器ID
 */
export function redeemCode(code, machine_id) {
  return request('/redeem_code', {
    code: code,
    machine_id: machine_id
  }, 'POST')
}

/**
 * 验证兑换码状态
 * @param {string} code - 6位兑换码
 */
export function checkCode(code) {
  return request('/check_code', { code: code }, 'POST')
}

/**
 * 获取机器信息
 * @param {string} machine_id - 机器ID
 */
export function getMachineInfo(machine_id) {
  return request('/machine_info', { machine_id: machine_id }, 'POST')
}

/**
 * 查询兑换码（用于再次访问查看）
 * @param {string} phone - 手机号
 * @returns {Promise} 返回查询结果
 */
export function queryCode(phone) {
  return new Promise((resolve, reject) => {
    uni.showLoading({ title: '查询中...' })
    
    uni.request({
      url: BASE_URL + '/query_code',
      data: { phone: phone },
      method: 'POST',
      header: { 'Content-Type': 'application/json' },
      success: (res) => {
        uni.hideLoading()
        // query_code 接口返回 404 表示今日无兑换码，也算成功
        if (res.data.code === 200 || res.data.code === 404 || res.data.code === 0) {
          resolve(res.data)
        } else {
          uni.showToast({
            title: res.data.message || '查询失败',
            icon: 'none'
          })
          reject(res.data)
        }
      },
      fail: (err) => {
        uni.hideLoading()
        uni.showToast({
          title: '网络请求失败',
          icon: 'none'
        })
        reject(err)
      }
    })
  })
}

export default {
  generateCode,
  redeemCode,
  checkCode,
  getMachineInfo,
  queryCode
}
