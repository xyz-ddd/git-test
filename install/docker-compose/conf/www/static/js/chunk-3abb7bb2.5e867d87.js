(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-3abb7bb2"],{"255d":function(e,t,r){"use strict";r.r(t);var a=function(){var e=this,t=e.$createElement,r=e._self._c||t;return r("div",{staticClass:"main"},[r("el-dialog",{attrs:{title:"添加人员",visible:e.centerDialogVisible,width:"50%",center:""},on:{"update:visible":function(t){e.centerDialogVisible=t},close:e.beforeClose}},[[r("el-table",{ref:"multipleTable",staticStyle:{width:"100%"},attrs:{data:e.transferData.filter((function(t){return!e.search||t.nickName.toLowerCase().includes(e.search.toLowerCase())}))},on:{"selection-change":e.handleSelectionChange,"row-click":e.toggleSelection}},[r("el-table-column",{attrs:{type:"index",label:"序号",align:"center"}}),r("el-table-column",{attrs:{label:"ID",prop:"userId",width:"60px",align:"center"}}),r("el-table-column",{attrs:{label:"姓名",prop:"nickName"},scopedSlots:e._u([{key:"default",fn:function(t){return[r("div",[r("p",[e._v(e._s(t.row.nickName))])])]}}])}),r("el-table-column",{attrs:{prop:"postName"}},[r("template",{slot:"header"},[r("el-input",{attrs:{size:"mini",clearable:"",placeholder:"输入姓名搜索"},model:{value:e.search,callback:function(t){e.search=t},expression:"search"}})],1)],2),r("el-table-column",{attrs:{type:"selection",align:"center"}})],1)],r("span",{staticClass:"dialog-footer",attrs:{slot:"footer"},slot:"footer"},[r("el-button",{on:{click:e.handleclose}},[e._v("取 消")]),r("el-button",{attrs:{type:"primary"},on:{click:e.handleclick}},[e._v("确 定")])],1)],2)],1)},o=[],n=(r("d3b7"),r("159b"),r("14d9"),r("c5d2")),i={data:function(){this.$createElement;return{centerDialogVisible:!1,projectId:"",transferData:[],search:"",multipleSelection:[],checked:[],renderFunc:function(e,t){return e("span",[t.key," - ",t.label])},filterMethod:function(e,t){return t.nickName.indexOf(e)>-1},options:[{value:!0,label:"从项目创建"},{value:!1,label:"从加入时间"}]}},created:function(){},methods:{clickspan:function(e){var t=[];return e.forEach((function(e){return t.push(e.key)})),t},open:function(){var e=this;setTimeout((function(){e.settransfer(),e.getObject(),e.centerDialogVisible=!0}),100)},getObject:function(){var e=this;Object(n["i"])(this.projectId).then((function(t){if(200==t.code){for(var r=t.data,a=[],o=0;o<r.length;o++)a.push({key:r[o].userId,nickName:r[o].nickName,email:r[o].email,postName:r[o].postName,userId:r[o].userId,ruleDesc:r[o].ruleDesc});e.transferData=a,console.log(e.transferData)}}))},settransfer:function(){},handleChange:function(e,t,r){},beforeClose:function(){this.multipleSelection=[]},handleclose:function(){this.centerDialogVisible=!1,this.multipleSelection=[]},handleclick:function(){var e=this,t={projectId:this.projectId,users:this.multipleSelection};Object(n["a"])(t).then((function(t){200==t.code&&(e.$parent.init(),e.$parent.showCard=2,e.multipleSelection=[],e.centerDialogVisible=!1)}))},handleSelectionChange:function(e){this.multipleSelection=this.clickspan(e)},toggleSelection:function(e){e&&this.$refs.multipleTable.toggleRowSelection(e)}}},l=i,s=(r("633e"),r("2877")),c=Object(s["a"])(l,a,o,!1,null,"30a453d4",null);t["default"]=c.exports},"633e":function(e,t,r){"use strict";r("b48f")},"79d4":function(e,t,r){"use strict";r.d(t,"y",(function(){return o})),r.d(t,"c",(function(){return n})),r.d(t,"A",(function(){return i})),r.d(t,"d",(function(){return l})),r.d(t,"f",(function(){return s})),r.d(t,"g",(function(){return c})),r.d(t,"v",(function(){return u})),r.d(t,"H",(function(){return d})),r.d(t,"e",(function(){return p})),r.d(t,"n",(function(){return m})),r.d(t,"q",(function(){return f})),r.d(t,"l",(function(){return h})),r.d(t,"m",(function(){return b})),r.d(t,"j",(function(){return j})),r.d(t,"b",(function(){return v})),r.d(t,"z",(function(){return y})),r.d(t,"a",(function(){return g})),r.d(t,"k",(function(){return k})),r.d(t,"I",(function(){return _})),r.d(t,"h",(function(){return w})),r.d(t,"i",(function(){return F})),r.d(t,"D",(function(){return O})),r.d(t,"F",(function(){return C})),r.d(t,"E",(function(){return I})),r.d(t,"B",(function(){return D})),r.d(t,"C",(function(){return x})),r.d(t,"G",(function(){return N})),r.d(t,"t",(function(){return S})),r.d(t,"u",(function(){return T})),r.d(t,"s",(function(){return P})),r.d(t,"w",(function(){return $})),r.d(t,"r",(function(){return V})),r.d(t,"x",(function(){return H})),r.d(t,"o",(function(){return M})),r.d(t,"p",(function(){return E}));r("99af");var a=r("b775");function o(){return Object(a["a"])({url:"/system/project/work/list",method:"get"})}function n(e){return Object(a["a"])({url:"/system/project/create",method:"post",data:e})}function i(e){return Object(a["a"])({url:"/system/project/list",method:"get",params:e})}function l(e){return Object(a["a"])({url:"/system/project/remove?projectId="+e,method:"delete"})}function s(){return Object(a["a"])({url:"/system/user/box",method:"get"})}function c(e){return Object(a["a"])({url:"/system/dict/data/type/"+e,method:"get"})}function u(e){return Object(a["a"])({url:"/system/project/list?projectStatus="+e,method:"get"})}function d(e,t){var r={projectId:e,projectStatus:t};return Object(a["a"])({url:"/system/project/status",method:"put",params:r})}function p(e){return Object(a["a"])({type:"form",url:"/system/project/enable",method:"put",data:e})}function m(){return Object(a["a"])({url:"/system/project/user/my/project/all",method:"get"})}function f(e){return Object(a["a"])({url:"/system/project/user/my/project/all?projectStatus="+e,method:"get"})}function h(e,t){return Object(a["a"])({url:"/mh/hour/list?endDate=".concat(e,"&startDate=").concat(t),method:"get"})}function b(e){return Object(a["a"])({url:"/mh/hour/list/miss",method:"get",params:e})}function j(e){return Object(a["a"])({url:"/system/project/user/my/project?date="+e,method:"get"})}function v(e){return Object(a["a"])({url:"/mh/hour/create",method:"post",data:e})}function y(e,t){return Object(a["a"])({url:"/mh/hour/leave?leaveDate="+e+"&leaveType="+t,method:"post"})}function g(e){return Object(a["a"])({url:"/mh/hour/unLeave?id="+e,method:"post"})}function k(e){return Object(a["a"])({url:"/mh/hour/detail?hourId="+e,method:"get"})}function _(e){return Object(a["a"])({url:"/mh/hour/edit",method:"put",data:e})}function w(e){return Object(a["a"])({url:"/mh/hour/stat?date="+e,method:"get"})}function F(e){return Object(a["a"])({url:"/mh/hour/stat/detail",method:"get",params:e})}function O(e){return Object(a["a"])({url:"/system/project/hour/stat",method:"get",params:e})}function C(e){return Object(a["a"])({url:"/system/project/hour/stat",method:"get",params:e})}function I(e){return Object(a["a"])({url:"/system/project/hour/stat/fill/detail?date=".concat(e.date,"&projectId=").concat(e.projectId),method:"get"})}function D(e){return Object(a["a"])({url:"/system/project/hour/stat/hour/month?projectId="+e,method:"get"})}function x(e){return Object(a["a"])({url:"/system/project/hour/stat/hour/month/detail",method:"get",params:e})}function N(e){return Object(a["a"])({url:"/system/project/hour/stat/hour/user?projectId=".concat(e),method:"get"})}function S(e){return Object(a["a"])({url:"/system/project/hour/daily/calendar",method:"get",params:e})}function T(e){return Object(a["a"])({url:"/system/project/hour/daily/calendar/detail",method:"get",params:e})}function P(e){return Object(a["a"])({url:"/system/project/hour/daily/list",method:"get",params:e})}function $(e){return Object(a["a"])({url:"/mh/hour/stat/export",method:"get",params:e})}function V(e){return Object(a["a"])({url:"/mh/hour/calendar?date="+e,method:"get"})}function H(e){return Object(a["a"])({url:"/mh/hour/stat/project?date="+e,method:"get"})}function M(e){return Object(a["a"])({url:"/system/project/user/my/project/list",method:"get",params:e})}function E(e){return Object(a["a"])({url:"/system/project/user/my/project/list?projectStatus="+e,method:"get"})}},"9fbe":function(e,t,r){"use strict";r("e963")},"9fc1":function(e,t,r){"use strict";r.r(t);var a=function(){var e=this,t=e.$createElement,a=e._self._c||t;return a("div",{staticClass:"main"},[a("el-form",{staticClass:"demo-form-inline"},[a("el-form-item",[a("el-row",[a("el-button",{directives:[{name:"hasPermi",rawName:"v-hasPermi",value:["system:project:query"],expression:"['system:project:query']"}],attrs:{type:"primary"},on:{click:function(t){e.showCard=1}}},[e._v("项目概要")]),a("el-button",{directives:[{name:"hasPermi",rawName:"v-hasPermi",value:["mh:project:user:list"],expression:"['mh:project:user:list']"}],attrs:{type:"primary"},on:{click:function(t){e.showCard=2}}},[e._v("人员管理")]),a("el-button",{directives:[{name:"hasPermi",rawName:"v-hasPermi",value:["system:project:edit"],expression:"['system:project:edit']"}],attrs:{type:"primary"},on:{click:function(t){e.showCard=3}}},[e._v("工时设置")]),a("el-button",{directives:[{name:"hasPermi",rawName:"v-hasPermi",value:["system:project:hour:edit"],expression:"['system:project:hour:edit']"}],attrs:{type:"primary"},on:{click:function(t){e.showCard=4}}},[e._v("项目管理")])],1)],1),a("el-form-item",["1"==e.showCard?a("el-card",{staticClass:"box-card cardone"},[a("div",{staticClass:"clearfix",attrs:{slot:"header"},slot:"header"},[a("span",{staticStyle:{"font-size":"22px"}},[e._v(e._s(e.projectProfile.projectName))]),a("el-button",{directives:[{name:"hasPermi",rawName:"v-hasPermi",value:["system:project:edit"],expression:"['system:project:edit']"}],staticStyle:{float:"right"},attrs:{type:"primary"},on:{click:e.editprojectdetail}},[e._v("编辑")])],1),a("div",{staticClass:"text item"},[a("div",{staticClass:"content"},["进行中"==e.projectProfile.projectStatusName?a("span",[e._v("项目阶段: "),a("el-tag",[e._v(e._s(e.projectProfile.projectStatusName))])],1):e._e(),"归档"==e.projectProfile.projectStatusName?a("span",[e._v("项目阶段: "),a("el-tag",{attrs:{type:"success"}},[e._v(e._s(e.projectProfile.projectStatusName))])],1):e._e(),"运维"==e.projectProfile.projectStatusName?a("span",[e._v("项目阶段: "),a("el-tag",{attrs:{type:"warning"}},[e._v(e._s(e.projectProfile.projectStatusName))])],1):e._e()]),a("div",{staticClass:"content"},[e.projectProfile.enable?a("span",[e._v("项目状态: "),a("el-tag",{attrs:{type:"success"}},[e._v("启动状态")])],1):a("span",[e._v("项目状态: "),a("el-tag",{attrs:{type:"info"}},[e._v("暂停状态")])],1)]),a("div",{staticClass:"content"},[a("span",[e._v("项目简介:")]),a("span",[e._v(e._s(e.projectProfile.remark))])]),a("div",{staticClass:"content"},[a("span",[e._v("项目经理:"+e._s(e.projectProfile.projectManagerName))])]),a("div",{staticClass:"content"},[a("span",[e._v("开始时间:"+e._s(e.projectProfile.startDate))])]),a("div",{staticClass:"content"},[a("span",[e._v("结束时间:"+e._s(e.projectProfile.endDate))])]),a("div",{staticClass:"content"},[a("span",[e._v("创建时间:"+e._s(e.projectProfile.createTime))])])])]):"2"==e.showCard?a("el-card",{staticClass:"box-card cardtwo"},[a("div",{staticClass:"clearfix",attrs:{slot:"header"},slot:"header"},[a("span",{staticStyle:{"font-size":"22px"}},[a("el-descriptions",{attrs:{title:"项目成员信息"}},[a("template",{slot:"extra"},[a("el-button",{directives:[{name:"hasPermi",rawName:"v-hasPermi",value:["mh:project:user:add"],expression:"['mh:project:user:add']"}],staticStyle:{float:"right"},attrs:{type:"primary"},on:{click:e.addpeople}},[e._v("添加人员")])],1),a("el-descriptions-item",{attrs:{label:"项目成员"}},[e._v(e._s(e.peopleTotal)+"人")]),e._l(e.peopleTotalInfo,(function(t,r){return a("el-descriptions-item",{key:r,attrs:{label:t.postName}},[e._v(e._s(t.value)+"人")])}))],2)],1)]),a("div",{staticClass:"text item"},[[a("el-table",{staticStyle:{width:"100%"},attrs:{data:e.tableData}},[a("el-table-column",{attrs:{fixed:"",type:"index",prop:"date",label:"序号",width:"60px",align:"center"}}),a("el-table-column",{attrs:{prop:"avatar",label:"头像",width:"119",align:"center"},scopedSlots:e._u([{key:"default",fn:function(e){return[a("div",{staticClass:"userImg"},[a("div",{staticClass:"demo-image"},[""!=e.row.avatar?a("div",{staticClass:"block"},[a("el-image",{attrs:{src:e.row.avatar}})],1):a("div",{staticClass:"block"},[a("el-image",{attrs:{src:r("4b94")}})],1)])])]}}])}),a("el-table-column",{attrs:{prop:"userId",label:"ID",align:"center",width:"80"}}),a("el-table-column",{attrs:{prop:"nickName",label:"姓名",align:"center"}}),a("el-table-column",{attrs:{prop:"postName",label:"职位",align:"center",width:"128"},scopedSlots:e._u([{key:"default",fn:function(t){return[a("div",[a("el-tag",[e._v(e._s(t.row.postName))])],1)]}}])}),a("el-table-column",{attrs:{prop:"joinTime",label:"加入时间",align:"center",width:"100"}}),a("el-table-column",{attrs:{prop:"",label:"开始填报",align:"center"},scopedSlots:e._u([{key:"default",fn:function(t){return[a("div",[t.row.joinWithProject?a("el-tag",[e._v("从项目创建开始")]):a("el-tag",[e._v("从加入时间开始")])],1)]}}])}),a("el-table-column",{attrs:{label:"上报类型",align:"center"},scopedSlots:e._u([{key:"default",fn:function(t){return[a("div",{},[a("el-switch",{staticStyle:{display:"block"},attrs:{"active-color":"#13ce66","inactive-color":"#ff4949","active-text":"每日","inactive-text":"临时"},on:{change:function(r){return e.editEvery(t.row)}},model:{value:t.row.everyday,callback:function(r){e.$set(t.row,"everyday",r)},expression:"scope.row.everyday"}})],1)]}}])}),a("el-table-column",{attrs:{fixed:"right",label:"操作",width:"120",align:"center"},scopedSlots:e._u([{key:"default",fn:function(t){return[a("el-button",{attrs:{type:"text",size:"small"},on:{click:function(r){return e.joinType(t.row)}}},[e._v(" 设置开始时间 ")]),a("el-button",{directives:[{name:"hasPermi",rawName:"v-hasPermi",value:["mh:project:user:remove"],expression:"['mh:project:user:remove']"}],attrs:{type:"text",size:"small"},nativeOn:{click:function(r){return r.preventDefault(),e.deleteRow(t.$index,e.tableData,t.row)}}},[e._v(" 移除 ")])]}}])})],1)]],2)]):"3"==e.showCard?a("el-card",{staticClass:"box-card cardthree"},[a("div",{staticClass:"clearfix",attrs:{slot:"header"},slot:"header"},[a("span",{staticStyle:{"font-size":"22px"}},[e._v("预计投入工时："+e._s(e.manHour)+"小时")]),a("el-button",{staticStyle:{float:"right"},attrs:{type:"primary"},on:{click:e.eaitManHour}},[e._v("编辑")])],1)]):"4"==e.showCard?a("el-card",{staticClass:"box-card cardfour"},[a("div",{staticClass:"text item"},[a("el-row",[a("el-collapse",{on:{change:e.handleChange},model:{value:e.activeNames,callback:function(t){e.activeNames=t},expression:"activeNames"}},[a("el-collapse-item",{attrs:{title:"当前阶段：",name:"1"}},[a("div",[a("el-select",{staticStyle:{"margin-right":"20px"},attrs:{clearable:"",placeholder:"请选择阶段"},model:{value:e.phasevalue,callback:function(t){e.phasevalue=t},expression:"phasevalue"}},e._l(e.phaseoptions,(function(e){return a("el-option",{key:e.value,attrs:{label:e.label,value:e.value}})})),1),a("el-button",{attrs:{type:"primary"},on:{click:e.handlearchive}},[e._v("修改")])],1)]),a("el-collapse-item",{attrs:{title:"项目状态管理：",name:"2"}},[a("div",[e.enableStatus?a("el-button",{attrs:{type:"info"},on:{click:function(t){return e.handleEnable("suspend")}}},[e._v("暂停项目")]):a("el-button",{attrs:{type:"primary"},on:{click:function(t){return e.handleEnable("enabl")}}},[e._v("启动项目")]),a("el-button",{attrs:{type:"danger"},on:{click:function(t){return e.handlearchive("c")}}},[e._v("结束项目")])],1)]),a("el-collapse-item",{attrs:{title:"备注：",name:"3"}},[a("div",[e._v("项目暂停后：将无法填报工时。")]),a("div",[e._v(" 项目结束后：将转为归档状态。 ")])])],1)],1)],1)]):e._e()],1)],1),a("addForm",{ref:"addPeopleForm"}),a("el-dialog",{attrs:{title:"提示",visible:e.dialogVisible,width:"30%","before-close":e.handleClose},on:{"update:visible":function(t){e.dialogVisible=t}}},[a("el-form",{ref:"numberValidateForm",staticClass:"demo-ruleForm",attrs:{model:e.numberValidateForm,"label-width":"100px"}},[a("el-form-item",{attrs:{label:"预计工时",prop:"manHour",rules:[{required:!0,message:"不能为空"},{type:"number",message:"必须为数字值"}]}},[a("el-input",{staticStyle:{width:"50%"},attrs:{type:"manHour",maxlength:"5",autocomplete:"off"},model:{value:e.numberValidateForm.manHour,callback:function(t){e.$set(e.numberValidateForm,"manHour",e._n(t))},expression:"numberValidateForm.manHour"}}),a("el-select",{staticStyle:{width:"30%","margin-left":"5%"},attrs:{placeholder:"请选择单位"},model:{value:e.hourUnit,callback:function(t){e.hourUnit=t},expression:"hourUnit"}},e._l(e.options,(function(e){return a("el-option",{key:e.value,attrs:{label:e.label,value:e.value}})})),1)],1)],1),a("span",{staticClass:"dialog-footer",attrs:{slot:"footer"},slot:"footer"},[a("el-button",{on:{click:e.cancel}},[e._v("取 消")]),a("el-button",{attrs:{type:"primary"},on:{click:function(t){return e.submitForm("numberValidateForm")}}},[e._v("确 定")])],1)],1),a("el-dialog",{attrs:{title:"开始填报时间",visible:e.joinTypeVisible,width:"30%"},on:{"update:visible":function(t){e.joinTypeVisible=t}}},[a("el-select",{staticStyle:{width:"100%"},attrs:{placeholder:"请选择"},model:{value:e.joinTypeData.joinWithProject,callback:function(t){e.$set(e.joinTypeData,"joinWithProject",t)},expression:"joinTypeData.joinWithProject"}},e._l(e.typeOptions,(function(e){return a("el-option",{key:e.value,attrs:{label:e.label,value:e.value}})})),1),a("span",{staticClass:"dialog-footer",attrs:{slot:"footer"},slot:"footer"},[a("el-button",{on:{click:e.cancelJoinType}},[e._v("取 消")]),a("el-button",{attrs:{type:"primary"},on:{click:e.submitJoinType}},[e._v("提交")])],1)],1),a("editForm",{ref:"editForm"})],1)},o=[],n=(r("14d9"),r("a434"),r("d3b7"),r("159b"),r("255d")),i=r("a7dc"),l=r("79d4"),s=r("c5d2"),c={components:{addForm:n["default"],editForm:i["default"]},data:function(){return{joinTypeVisible:!1,joinTypeData:{joinWithProject:"",id:""},typeOptions:[{value:!0,label:"从项目创建"},{value:!1,label:"从加入时间"}],tableData:[],showCard:1,dialogVisible:!1,numberValidateForm:{manHour:""},projectId:0,projectProfile:{},manHour:528,peopleTotal:"",peopleInfo:[],peopleTotalInfo:[],options:[{value:"0",label:"人天"},{value:"1",label:"人月"}],phaseoptions:[{value:"a",label:"进行中"},{value:"b",label:"运维中"},{value:"c",label:"已结束"}],phasevalue:"",hourUnit:"0",phaseInput:"",activeNames:["1","2","3"],enableStatus:!0}},created:function(){this.$route.query.projectId?(this.projectId=this.$route.query.projectId,this.init()):(this.$message.warning("请先选择项目"),this.$router.push("project"))},methods:{joinType:function(e){this.joinTypeVisible=!0,this.joinTypeData.joinWithProject=e.joinWithProject,this.joinTypeData.id=e.id},submitJoinType:function(){var e=this;if(!this.joinTypeData.id)return this.$message.error("没有用户信息，请重新打开！");Object(s["e"])(this.joinTypeData).then((function(t){200==t.code&&(e.joinTypeVisible=!1,e.$message.success("修改完成"),e.getUserList(e.projectId))}))},cancelJoinType:function(){this.joinTypeVisible=!1,this.joinTypeData.joinWithProject="",this.joinTypeData.id=0},deleteRow:function(e,t,r){t.splice(e,1);var a=[];a=r.userId;var o={projectId:this.projectId,userIds:a};Object(s["c"])(o).then((function(e){}))},addpeople:function(){this.$refs.addPeopleForm.open(),this.$refs.addPeopleForm.projectId=this.projectId},init:function(){var e=this;this.showCard=1,0==this.projectId?this.$message.warning("请先选择项目"):(Object(s["b"])(this.projectId).then((function(t){e.projectProfile=t.data,e.enableStatus=t.data.enable,e.manHour=e.projectProfile.manHour,e.phasevalue=t.data.projectStatus})),Object(s["h"])(this.projectId).then((function(t){e.tableData=t.data,e.tableData.forEach((function(e){""!=e.avatar&&(e.avatar="api"+e.avatar)})),e.peopleTotal=e.tableData.length,e.peopleInfo=e.tableData,e.peopleTotalInfo=[],e.peopleInfo.forEach((function(t){var r={postName:t.postName,value:0};e.peopleInfo.forEach((function(e){t.postName==e.postName&&(r.value+=1)})),e.peopleTotalInfo.push(r)})),e.peopleTotalInfo=e.unique(e.peopleTotalInfo)})))},getUserList:function(e){var t=this;Object(s["h"])(e).then((function(e){t.tableData=e.data,t.tableData.forEach((function(e){""!=e.avatar&&(e.avatar="api"+e.avatar)})),t.peopleTotal=t.tableData.length,t.peopleInfo=t.tableData,t.peopleTotalInfo=[],t.peopleInfo.forEach((function(e){var r={postName:e.postName,value:0};t.peopleInfo.forEach((function(t){e.postName==t.postName&&(r.value+=1)})),t.peopleTotalInfo.push(r)})),t.peopleTotalInfo=t.unique(t.peopleTotalInfo)}))},unique:function(e){for(var t=e,r={},a=[],o=0;o<t.length;o++)!r[t[o].postName]&&(r[t[o].postName]=a.push(t[o]));return a},editprojectdetail:function(){this.$refs.editForm.formdata=this.projectProfile,this.$refs.editForm.open()},handlearchive:function(e){var t=this;"c"==e&&(this.phasevalue="c"),Object(l["H"])(this.projectId,this.phasevalue).then((function(e){200==e.code&&t.init()}))},eaitManHour:function(){this.dialogVisible=!0},cancel:function(){this.dialogVisible=!1,this.resetForm("numberValidateForm")},handleClose:function(e){var t=this;this.$confirm("确认关闭？").then((function(r){t.resetForm("numberValidateForm"),e()})).catch((function(e){}))},submitForm:function(e){var t=this;this.$refs[e].validate((function(r){if(!r)return t.resetForm(e),!1;t.manHour=t.numberValidateForm.manHou;var a={manHour:t.numberValidateForm.manHour,projectId:t.projectId};0==t.hourUnit?a.manHour=a.manHour*t.$store.state.user.appconfig.workTime:1==t.hourUnit&&(a.manHour=a.manHour*t.$store.state.user.appconfig.workTime*t.$store.state.user.appconfig.workDay),Object(s["d"])(a).then((function(e){200==e.code&&(t.init(),t.showCard=3)})),t.resetForm(e),t.dialogVisible=!1}))},resetForm:function(e){this.$refs[e].resetFields()},handleChange:function(e){},editEvery:function(e){var t=this,r={everyday:e.everyday,id:e.id};Object(s["g"])(r).then((function(e){200==e.code&&t.$message.success("更改成功")}))},handleEnable:function(e){var t=this,r={projectId:this.projectId,enable:void 0};"suspend"==e&&(r.enable=!1),"enabl"==e&&(r.enable=!0),Object(l["e"])(r).then((function(e){200==e.code&&(t.$message.success("修改状态成功"),t.init())}))}}},u=c,d=(r("9fbe"),r("2877")),p=Object(d["a"])(u,a,o,!1,null,"f1eadd74",null);t["default"]=p.exports},a7dc:function(e,t,r){"use strict";r.r(t);var a=function(){var e=this,t=e.$createElement,r=e._self._c||t;return r("div",{staticClass:"main"},[r("el-dialog",{staticStyle:{width:"60%",margin:"auto",overflow:"hidden"},attrs:{title:"项目概要设置",visible:e.dialogFormVisible},on:{"update:visible":function(t){e.dialogFormVisible=t}}},[r("el-form",{ref:"ruleForm",staticClass:"demo-ruleForm",staticStyle:{width:"100%"},attrs:{model:e.ruleForm,rules:e.rules,"label-width":"80px"}},[r("el-form-item",{attrs:{label:"项目名称",prop:"projectName"}},[r("el-input",{model:{value:e.ruleForm.projectName,callback:function(t){e.$set(e.ruleForm,"projectName",t)},expression:"ruleForm.projectName"}})],1),r("el-form-item",{attrs:{label:"项目经理",prop:"projectManager"}},[r("el-select",{attrs:{clearable:"",placeholder:"请选择项目经理"},model:{value:e.ruleForm.projectManager,callback:function(t){e.$set(e.ruleForm,"projectManager",t)},expression:"ruleForm.projectManager"}},e._l(e.projectManagerArr,(function(e){return r("el-option",{key:e.id,attrs:{label:e.name,value:e.id}})})),1)],1),r("el-form-item",{attrs:{label:"项目编码",prop:"projectCode"}},[r("el-input",{model:{value:e.ruleForm.projectCode,callback:function(t){e.$set(e.ruleForm,"projectCode",t)},expression:"ruleForm.projectCode"}})],1),r("el-form-item",{attrs:{label:"开始时间",prop:"startDate"}},[r("div",{staticClass:"block"},[r("el-date-picker",{attrs:{type:"date","value-format":"yyyy-MM-dd",placeholder:"开始日期"},model:{value:e.ruleForm.startDate,callback:function(t){e.$set(e.ruleForm,"startDate",t)},expression:"ruleForm.startDate"}})],1)]),r("el-form-item",{attrs:{label:"结束时间"}},[r("div",{staticClass:"block"},[r("el-date-picker",{attrs:{type:"date","value-format":"yyyy-MM-dd",placeholder:"结束日期"},model:{value:e.ruleForm.endDate,callback:function(t){e.$set(e.ruleForm,"endDate",t)},expression:"ruleForm.endDate"}})],1)]),r("el-form-item",{attrs:{label:"项目描述"}},[r("el-input",{attrs:{type:"textarea"},model:{value:e.ruleForm.remark,callback:function(t){e.$set(e.ruleForm,"remark",t)},expression:"ruleForm.remark"}})],1)],1),r("div",{staticClass:"dialog-footer",attrs:{slot:"footer"},slot:"footer"},[r("el-button",{on:{click:function(t){e.dialogFormVisible=!1}}},[e._v("取 消")]),r("el-button",{attrs:{type:"primary"},on:{click:function(t){return e.submitForm("ruleForm")}}},[e._v("确 定")])],1)],1)],1)},o=[],n=r("79d4"),i=r("c5d2"),l={data:function(){return{dialogFormVisible:!1,formdata:{},ruleForm:{projectName:"",projectManager:"",projectCode:"",startDate:"",endDate:"",remark:""},startDate:"",endDate:"",rules:{projectName:[{required:!0,message:"请输入项目名称",trigger:"blur"},{min:0,max:64,message:"长度在 0 到 64 个字符",trigger:"blur"}],projectManager:[{required:!0,message:"请选择项目经理",trigger:"change"}],projectCode:[{required:!0,message:"请选择项目编码",trigger:"change"}],startDate:[{type:"string",required:!0,message:"请选择日期",trigger:"change"}]},projectManagerArr:[]}},methods:{showdates:function(){},open:function(){this.getprojectManager(),this.ruleForm.projectId=this.formdata.projectId,this.ruleForm.projectName=this.formdata.projectName,this.ruleForm.projectManager=this.formdata.projectManager,this.ruleForm.projectCode=this.formdata.projectCode,this.ruleForm.startDate=this.formdata.startDate,this.ruleForm.endDate=this.formdata.endDate,this.ruleForm.remark=this.formdata.remark,this.dialogFormVisible=!0},submitForm:function(e){var t=this;this.$refs[e].validate((function(e){if(!e)return!1;var r=t.ruleForm;Object(i["f"])(r).then((function(e){200==e.code&&(t.dialogFormVisible=!1,t.$parent.init())}))}))},resetForm:function(e){this.$refs[e].resetFields()},getprojectManager:function(){var e=this;Object(n["f"])().then((function(t){200==t.code&&(e.projectManagerArr=t.data)}))}}},s=l,c=r("2877"),u=Object(c["a"])(s,a,o,!1,null,null,null);t["default"]=u.exports},b48f:function(e,t,r){},c5d2:function(e,t,r){"use strict";r.d(t,"b",(function(){return o})),r.d(t,"h",(function(){return n})),r.d(t,"i",(function(){return i})),r.d(t,"d",(function(){return l})),r.d(t,"f",(function(){return s})),r.d(t,"g",(function(){return c})),r.d(t,"a",(function(){return u})),r.d(t,"c",(function(){return d})),r.d(t,"e",(function(){return p}));var a=r("b775");function o(e){return Object(a["a"])({url:"/system/project/"+e,method:"get"})}function n(e){return Object(a["a"])({url:"/system/project/user/list?projectId="+e,method:"get"})}function i(e){return Object(a["a"])({url:"/system/project/user/select?projectId="+e,method:"get"})}function l(e){return Object(a["a"])({url:"/system/project/hour/edit",method:"put",params:e})}function s(e){return Object(a["a"])({url:"/system/project/modify",method:"put",data:e})}function c(e){return Object(a["a"])({type:"form",url:"/system/project/user/everyday",method:"put",data:e})}function u(e){return Object(a["a"])({url:"/system/project/user/create",method:"post",data:e})}function d(e){return Object(a["a"])({url:"/system/project/user/remove",method:"put",params:e})}function p(e){return Object(a["a"])({url:"/system/project/user/join",method:"put",params:e})}},e963:function(e,t,r){}}]);