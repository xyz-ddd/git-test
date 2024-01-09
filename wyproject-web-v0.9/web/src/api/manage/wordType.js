import request from '@/utils/request'



// 查询工作类型列表接口
export function getWorkTypeList(query) {
  return request({
    url: "/system/project/work/query",
    method: "get",
    params: query
  })
}


// 查询工作类型详细
export function getWork(id) {
  return request({
    url: '/system/project/work/get/' + id,
    method: 'get'
  })
}

// 新建工作类型接口
export function creatWorkType(data) {
  return request({
    url: "/system/project/work/create",
    method: "post",
    data: data
  })
}




// 修改作类型接口
export function editWorkType(data) {
  return request({
    type:'put',
    url: "/system/project/work/edit",
    method: "put",
    data: data
  })
}



// 删除工作类型接口
export function delWorkType(id) {
  return request({
    url: "/system/project/work/remove/"+id,
    method: "delete"
  })
}
