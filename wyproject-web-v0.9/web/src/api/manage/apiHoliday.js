import request from '@/utils/request'


// 查询工作日列表
export function getHolidayList(query) {
  return request({
    url: "/system/holiday/page",
    method: "get",
    params: query
  })
}


export function getHolidayTemplate() {
  return request({
    url: "/system/holiday/download",
    method: "get",
  })
}



export function editHolidayById(data) {
  return request({
    url: "/system/holiday/join",
    method: "put",
    params: data
  })
}


//上传日期文件
export function updateFile(data) {
  return request({
    url: "/system/holiday/importData",
    method: "post",
    params: data
  })
}


//删除某天的类型
export function delHoliday(id) {
  return request({
    url: "/system/holiday/remove/"+id,
    method: "delete",
  })
}

