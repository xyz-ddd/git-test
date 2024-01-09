import request from '@/utils/request'



//我的统计（填报率）
export function getMyDataStat(params) {
  return request({
    url:'/mh/hour/dataStat',
    method:'get',
    params
  })
}
