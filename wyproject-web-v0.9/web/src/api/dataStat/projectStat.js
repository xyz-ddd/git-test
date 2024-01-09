import request from '@/utils/request'

// 项目月报列表
export function getProjectMonth(params) {
  return request({
    url: "/project/dataStat/month",
    method: "get",
    params
  })
}

//项目月报详情
export function getProjectMonthDeatil(params) {
    return request({
      url: '/project/dataStat/month/detail',
      method: 'get',
      params
    })
  }



//月报详情记录导出

export function getStatExport(params) {
  return request({
    url:'/project/dataStat/month/export',
    method:'get',
    params
  })
}

//日报列表
export function getProjectDay(params) {
  return request({
    url:'/project/dataStat/daily',
    method:'get',
    params
  })
}

//日报详情
export function getProjectDayDetail(params) {
  return request({
    url:'/project/dataStat/daily/detail',
    method:'get',
    params
  })
}

//我的统计（填报率）
export function getMyDataStat(params) {
  return request({
    url:'//mh/hour/dataStat',
    method:'get',
    params
  })
}
