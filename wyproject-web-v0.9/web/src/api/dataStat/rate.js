import request from '@/utils/request'



//数据填报率（填报率）
export function getRate(params) {
  return request({
    url:'/stat/rate/list',
    method:'get',
    params
  })
}
