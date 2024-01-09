import request from '@/utils/request'

//获取审核列表
export function getReview(params) {
  return request({
    url:'/mh/review/list',
    method:'get',
    params
  })
}


//获取所日志的详情
export function getDailyDetail(id) {
  return request({
    url:'/mh/review/queryDailyDetail?hourId=' + id,
    method:'get',
  })
}

// 提交审核
export function setReview(data) {
  return request({
    url: '/mh/review/audit',
    method: 'post',
    data
  })
}


// 获取单个日志的详情
