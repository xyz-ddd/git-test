(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-44dccc8c"],{"14ce":function(e,t,i){},"20c0":function(e,t,i){"use strict";i("14ce")},"5f35":function(e,t,i){"use strict";i.r(t);var a=function(){var e=this,t=e.$createElement,i=e._self._c||t;return i("div",{staticClass:"main"},[i("el-row",{staticClass:"mb8",attrs:{gutter:10}},[i("el-col",{attrs:{span:1.5}},[i("el-button",{directives:[{name:"hasPermi",rawName:"v-hasPermi",value:["system:role:add"],expression:"['system:role:add']"}],attrs:{type:"primary",plain:"",icon:"el-icon-plus",size:"mini"},on:{click:function(t){e.addDialogVisible=!0}}},[e._v("新增")])],1)],1),i("el-card",{staticClass:"box-card"},[i("el-table",{attrs:{data:e.typeList}},[i("el-table-column",{attrs:{label:"ID",prop:"id",width:"60px"}}),i("el-table-column",{attrs:{label:"工作类型",prop:"name","show-overflow-tooltip":!0,width:"150px"}}),i("el-table-column",{attrs:{label:"创建时间",align:"center",prop:"createTime"},scopedSlots:e._u([{key:"default",fn:function(t){return[i("span",[e._v(e._s(e.parseTime(t.row.createTime)))])]}}])}),i("el-table-column",{attrs:{label:"操作",align:"center","class-name":"small-padding fixed-width"},scopedSlots:e._u([{key:"default",fn:function(t){return 1!==t.row.id?[i("el-button",{directives:[{name:"hasPermi",rawName:"v-hasPermi",value:["system:role:edit"],expression:"['system:role:edit']"}],attrs:{size:"mini",type:"text",icon:"el-icon-edit"},on:{click:function(i){return e.showEditDialog(t.row.id)}}},[e._v("修改")]),i("el-button",{directives:[{name:"hasPermi",rawName:"v-hasPermi",value:["system:role:remove"],expression:"['system:role:remove']"}],attrs:{size:"mini",type:"text",icon:"el-icon-delete"},on:{click:function(i){return e.handleDelete(t.row.id)}}},[e._v("删除")])]:void 0}}],null,!0)})],1),i("el-pagination",{attrs:{"current-page":e.queryInfo.newSize,"page-sizes":[1,10,50,100],"page-size":e.queryInfo.newPage,layout:"total, sizes, prev, pager, next, jumper",total:e.typeTotal},on:{"size-change":e.handleSizeChange,"current-change":e.handleCurrentChange}})],1),i("el-dialog",{attrs:{title:"添加工作类型",visible:e.addDialogVisible,width:"50%","close-on-click-modal":!1},on:{"update:visible":function(t){e.addDialogVisible=t},close:e.addDialogClosed}},[i("el-form",{ref:"addFormRef",attrs:{model:e.addForm,rules:e.addFormRules,"label-width":"90px"},nativeOn:{keyup:function(t){return!t.type.indexOf("key")&&e._k(t.keyCode,"enter",13,t.key,"Enter")?null:e.addType(t)}}},[i("el-form-item",{attrs:{label:"工作类型",prop:"name"}},[i("el-input",{model:{value:e.addForm.name,callback:function(t){e.$set(e.addForm,"name",t)},expression:"addForm.name"}})],1)],1),i("span",{staticClass:"dialog-footer",attrs:{slot:"footer"},slot:"footer"},[i("el-button",{on:{click:function(t){e.addDialogVisible=!1}}},[e._v("取 消")]),i("el-button",{attrs:{type:"primary"},on:{click:e.addType}},[e._v("确 定")])],1)],1),i("el-dialog",{attrs:{title:"修改工作类型",visible:e.editDialogVisible,width:"50%","close-on-click-modal":!1},on:{"update:visible":function(t){e.editDialogVisible=t},close:e.editDialogClosed}},[i("el-form",{ref:"editFormRef",attrs:{model:e.editForm,rules:e.addFormRules,"label-width":"90px"},nativeOn:{keyup:function(t){return!t.type.indexOf("key")&&e._k(t.keyCode,"enter",13,t.key,"Enter")?null:e.editType(t)}}},[i("el-form-item",{attrs:{label:"工作类型",prop:"name"}},[i("el-input",{model:{value:e.editForm.name,callback:function(t){e.$set(e.editForm,"name",t)},expression:"editForm.name"}})],1)],1),i("span",{staticClass:"dialog-footer",attrs:{slot:"footer"},slot:"footer"},[i("el-button",{on:{click:function(t){e.editDialogVisible=!1}}},[e._v("取 消")]),i("el-button",{attrs:{type:"primary"},on:{click:e.editType}},[e._v("确 定")])],1)],1)],1)},o=[],n=i("c7eb"),r=i("1da1"),l=i("b775");function s(e){return Object(l["a"])({url:"/system/project/work/query",method:"get",params:e})}function d(e){return Object(l["a"])({url:"/system/project/work/get/"+e,method:"get"})}function c(e){return Object(l["a"])({url:"/system/project/work/create",method:"post",data:e})}function u(e){return Object(l["a"])({type:"put",url:"/system/project/work/edit",method:"put",data:e})}function m(e){return Object(l["a"])({url:"/system/project/work/remove/"+e,method:"delete"})}var p={data:function(){return{addFormRules:{name:[{required:!0,message:"请输入工作类型名称",trigger:"blur"},{min:1,max:10,message:"长度在 1到 10 个字符",trigger:"blur"}]},addDialogVisible:!1,addForm:{name:""},editDialogVisible:!1,editForm:{name:""},typeList:[],typeTotal:0,queryInfo:{type:3,pageNum:1,pageSize:10},loading:!0,exportLoading:!1,ids:[],single:!0,multiple:!0,showSearch:!0,total:0,roleList:[],title:"",open:!1,openDataScope:!1,menuExpand:!1,menuNodeAll:!1,deptExpand:!0,deptNodeAll:!1,dateRange:[],statusOptions:[],dataScopeOptions:[{value:"1",label:"全部数据权限"},{value:"2",label:"自定数据权限"},{value:"3",label:"本部门数据权限"},{value:"4",label:"本部门及以下数据权限"},{value:"5",label:"仅本人数据权限"}],menuOptions:[],deptOptions:[],queryParams:{pageNum:1,pageSize:10,roleName:void 0,roleKey:void 0,status:void 0},form:{},defaultProps:{children:"children",label:"label"},rules:{roleName:[{required:!0,message:"角色名称不能为空",trigger:"blur"}],roleKey:[{required:!0,message:"权限字符不能为空",trigger:"blur"}],roleSort:[{required:!0,message:"角色顺序不能为空",trigger:"blur"}]}}},components:{},created:function(){this.getList()},methods:{addType:function(){var e=this;this.$refs.addFormRef.validate((function(t){t&&c(e.addForm).then((function(t){e.msgSuccess("新增成功"),e.addDialogVisible=!1,e.getList()}))}))},editType:function(){var e=this;this.$refs.editFormRef.validate((function(t){t&&u(e.editForm).then((function(t){e.msgSuccess("修改成功"),e.editDialogVisible=!1,e.getList()}))}))},addDialogClosed:function(){this.$refs.addFormRef.resetFields()},editDialogClosed:function(){this.$refs.editFormRef.resetFields()},showEditDialog:function(e){var t=this;d(e).then((function(e){t.editForm=e.data,t.loading=!1})),this.editDialogVisible=!0},handleDelete:function(e){var t=this;return Object(r["a"])(Object(n["a"])().mark((function i(){var a;return Object(n["a"])().wrap((function(i){while(1)switch(i.prev=i.next){case 0:return i.next=2,t.$confirm("此操作将删除该类型并且不可恢复, 是否继续?","提示",{confirmButtonText:"确认删除",cancelButtonText:"取消",type:"warning"}).catch((function(e){return e}));case 2:if(a=i.sent,"confirm"===a){i.next=5;break}return i.abrupt("return",t.msgInfo("已经取消删除"));case 5:m(e).then((function(e){t.getList()}));case 6:case"end":return i.stop()}}),i)})))()},getList:function(){var e=this;this.loading=!0,s(this.queryInfo).then((function(t){e.typeList=t.rows,e.typeTotal=t.total}))},handleSizeChange:function(e){this.queryInfo.pageSize=e,this.getList()},handleCurrentChange:function(e){this.queryInfo.pageNum=e,this.getList()}}},f=p,g=(i("20c0"),i("2877")),b=Object(g["a"])(f,a,o,!1,null,"07b4c6ec",null);t["default"]=b.exports}}]);