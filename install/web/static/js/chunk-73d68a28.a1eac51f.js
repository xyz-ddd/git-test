(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-73d68a28"],{"79d4":function(t,e,r){"use strict";r.d(e,"z",(function(){return o})),r.d(e,"c",(function(){return a})),r.d(e,"B",(function(){return n})),r.d(e,"d",(function(){return s})),r.d(e,"f",(function(){return u})),r.d(e,"g",(function(){return l})),r.d(e,"w",(function(){return c})),r.d(e,"I",(function(){return d})),r.d(e,"e",(function(){return h})),r.d(e,"n",(function(){return m})),r.d(e,"r",(function(){return p})),r.d(e,"l",(function(){return f})),r.d(e,"m",(function(){return y})),r.d(e,"j",(function(){return b})),r.d(e,"b",(function(){return g})),r.d(e,"A",(function(){return j})),r.d(e,"a",(function(){return w})),r.d(e,"k",(function(){return v})),r.d(e,"J",(function(){return T})),r.d(e,"h",(function(){return O})),r.d(e,"i",(function(){return k})),r.d(e,"E",(function(){return H})),r.d(e,"G",(function(){return D})),r.d(e,"F",(function(){return _})),r.d(e,"C",(function(){return I})),r.d(e,"D",(function(){return x})),r.d(e,"H",(function(){return S})),r.d(e,"u",(function(){return L})),r.d(e,"v",(function(){return C})),r.d(e,"t",(function(){return V})),r.d(e,"x",(function(){return $})),r.d(e,"s",(function(){return E})),r.d(e,"y",(function(){return z})),r.d(e,"o",(function(){return J})),r.d(e,"p",(function(){return A})),r.d(e,"q",(function(){return N}));r("99af");var i=r("b775");function o(){return Object(i["a"])({url:"/system/project/work/list",method:"get"})}function a(t){return Object(i["a"])({url:"/system/project/create",method:"post",data:t})}function n(t){return Object(i["a"])({url:"/system/project/list",method:"get",params:t})}function s(t){return Object(i["a"])({url:"/system/project/remove?projectId="+t,method:"delete"})}function u(){return Object(i["a"])({url:"/system/user/box",method:"get"})}function l(t){return Object(i["a"])({url:"/system/dict/data/type/"+t,method:"get"})}function c(t){return Object(i["a"])({url:"/system/project/list?projectStatus="+t,method:"get"})}function d(t,e){var r={projectId:t,projectStatus:e};return Object(i["a"])({url:"/system/project/status",method:"put",params:r})}function h(t){return Object(i["a"])({type:"form",url:"/system/project/enable",method:"put",data:t})}function m(){return Object(i["a"])({url:"/system/project/user/my/project/all",method:"get"})}function p(t){return Object(i["a"])({url:"/system/project/user/my/project/all?projectStatus="+t,method:"get"})}function f(t,e){return Object(i["a"])({url:"/mh/hour/list?endDate=".concat(t,"&startDate=").concat(e),method:"get"})}function y(t){return Object(i["a"])({url:"/mh/hour/list/miss",method:"get",params:t})}function b(t){return Object(i["a"])({url:"/system/project/user/my/project?date="+t,method:"get"})}function g(t){return Object(i["a"])({url:"/mh/hour/create",method:"post",data:t})}function j(t,e){return Object(i["a"])({url:"/mh/hour/leave?leaveDate="+t+"&leaveType="+e,method:"post"})}function w(t){return Object(i["a"])({url:"/mh/hour/unLeave?id="+t,method:"post"})}function v(t){return Object(i["a"])({url:"/mh/hour/detail?hourId="+t,method:"get"})}function T(t){return Object(i["a"])({url:"/mh/hour/edit",method:"put",data:t})}function O(t){return Object(i["a"])({url:"/mh/hour/stat?date="+t,method:"get"})}function k(t){return Object(i["a"])({url:"/mh/hour/stat/detail",method:"get",params:t})}function H(t){return Object(i["a"])({url:"/system/project/hour/stat",method:"get",params:t})}function D(t){return Object(i["a"])({url:"/system/project/hour/stat",method:"get",params:t})}function _(t){return Object(i["a"])({url:"/system/project/hour/stat/fill/detail?date=".concat(t.date,"&projectId=").concat(t.projectId),method:"get"})}function I(t){return Object(i["a"])({url:"/system/project/hour/stat/hour/month?projectId="+t,method:"get"})}function x(t){return Object(i["a"])({url:"/system/project/hour/stat/hour/month/detail",method:"get",params:t})}function S(t){return Object(i["a"])({url:"/system/project/hour/stat/hour/user?projectId=".concat(t),method:"get"})}function L(t){return Object(i["a"])({url:"/system/project/hour/daily/calendar",method:"get",params:t})}function C(t){return Object(i["a"])({url:"/system/project/hour/daily/calendar/detail",method:"get",params:t})}function V(t){return Object(i["a"])({url:"/system/project/hour/daily/list",method:"get",params:t})}function $(t){return Object(i["a"])({url:"/mh/hour/stat/export",method:"get",params:t})}function E(t){return Object(i["a"])({url:"/mh/hour/calendar?date="+t,method:"get"})}function z(t){return Object(i["a"])({url:"/mh/hour/stat/project?date="+t,method:"get"})}function J(t){return Object(i["a"])({url:"/system/project/user/my/project/list",method:"get",params:t})}function A(t){return Object(i["a"])({url:"/system/project/user/my/project/list?projectStatus="+t,method:"get"})}function N(){return Object(i["a"])({url:"/system/project/user/pm/projectList",method:"get"})}},"7aed":function(t,e,r){"use strict";r.d(e,"b",(function(){return o})),r.d(e,"a",(function(){return a})),r.d(e,"c",(function(){return n}));var i=r("b775");function o(t){return Object(i["a"])({url:"/mh/review/list",method:"get",params:t})}function a(t){return Object(i["a"])({url:"/mh/review/queryDailyDetail?hourId="+t,method:"get"})}function n(t){return Object(i["a"])({url:"/mh/review/audit",method:"post",data:t})}},"7d08":function(t,e,r){},d062:function(t,e,r){"use strict";r.r(e);var i=function(){var t=this,e=t.$createElement,r=t._self._c||e;return r("div",{staticClass:"main"},[r("el-dialog",{attrs:{title:"日报详情",visible:t.dailyDialog,width:"55%","before-close":t.handleViewCannel,align:"center"},on:{"update:visible":function(e){t.dailyDialog=e}}},[r("el-row",[r("el-col",{attrs:{span:24}},[r("el-form",{ref:"form",attrs:{"label-width":"80px"}},[r("el-form-item",[r("el-descriptions",{attrs:{title:"信息",column:2}},[r("el-descriptions-item",{attrs:{label:"日期"}},[t._v(" "+t._s(this.dailyDetail.fillDate)+" ")]),r("el-descriptions-item",{attrs:{label:"类型"}},[this.dailyDetail.dayType?r("el-tag",{attrs:{type:"danger"}},[t._v("工作日")]):r("el-tag",{attrs:{type:"success"}},[t._v("休息日")])],1),r("el-descriptions-item",{attrs:{label:"工时数"}},[t._v(t._s(this.dailyDetail.useHourTotal)+"小时")]),r("el-descriptions-item",{attrs:{label:"审核状态"}},["1"==this.daily.reviewStatus?r("el-tag",[t._v("待审核")]):"2"==this.daily.reviewStatus?r("el-tag",[t._v("审核通过")]):"-1"==this.daily.reviewStatus?r("el-tag",{attrs:{type:"danger"}},[t._v("已驳回")]):r("el-tag",{attrs:{type:"info"}},[t._v("无需审核")])],1),r("el-descriptions-item",{attrs:{label:"提交于"}},[t._v(t._s(this.daily.createTime))])],1)],1),r("el-form-item",[r("div",{staticClass:"el-descriptions__title",staticStyle:{"text-align":"left"}},[t._v("详情 ")]),r("el-table",{staticStyle:{width:"100%"},attrs:{data:this.dailyDetail.projectList}},[r("el-table-column",{attrs:{type:"index",label:"序号",width:"50",align:"center"}}),r("el-table-column",{attrs:{prop:"projectName",label:"项目名称",width:"260"}}),r("el-table-column",{attrs:{prop:"useHour",label:"工时",width:"80 ",align:"center"},scopedSlots:t._u([{key:"default",fn:function(e){return[r("span",[t._v(t._s(e.row.useHour)+"小时")])]}}])}),r("el-table-column",{attrs:{prop:"daily",label:"工作内容",align:"center"},scopedSlots:t._u([{key:"default",fn:function(e){return[r("span",[t._v(t._s(e.row.daily?e.row.daily:"无"))])]}}])})],1)],1),r("el-form-item",[r("div",{attrs:{align:"center"}},[r("el-button",{attrs:{size:"small"},on:{click:t.handleViewCannel}},[t._v("关闭")]),r("el-button",{attrs:{type:"primary",size:"small"},on:{click:t.handleEdit}},[t._v("修改")])],1)])],1)],1)],1)],1),r("el-dialog",{attrs:{title:"修改工时  "+t.fillDate,visible:t.centerDialogVisible,width:"31%","close-on-click-modal":!1},on:{"update:visible":function(e){t.centerDialogVisible=e},close:t.beforeClose}},[r("div",{staticClass:"infoOne"},[r("el-form",{staticStyle:{"max-height":"400px","overflow-y":"scroll"},attrs:{inline:!1,"label-width":"300px"}},[r("div",{staticStyle:{float:"right","text-align":"right"}},[r("span",{staticClass:"tips",staticStyle:{"margin-right":"10px"}},[t._v(t._s(t.submitTips))]),r("el-input",{staticStyle:{width:"18%"},attrs:{max:24,autocomplete:"off",disabled:!0},model:{value:t.useHourTotal,callback:function(e){t.useHourTotal=t._n(e)},expression:"useHourTotal"}}),r("span",{staticStyle:{margin:"0 10px"}},[t._v("小时")])],1),t._l(t.projectList,(function(e,i){return r("el-form-item",{key:i,attrs:{prop:"item.projectName"}},[r("el-card",{staticClass:"box-card",attrs:{shadow:"never"}},[r("div",{staticClass:"clearfix",attrs:{slot:"header"},slot:"header"},[r("span",{staticClass:"projectLabel"},[t._v(t._s(e.projectName)+" ")])]),r("div",{staticStyle:{display:"flex","justify-content":"flex-end"}},[r("el-select",{staticStyle:{"margin-right":"auto",width:"auto"},attrs:{placeholder:"请选择工作类型"},model:{value:e.workTypeId,callback:function(r){t.$set(e,"workTypeId",r)},expression:"item.workTypeId"}},t._l(t.workTypeSelect,(function(t){return r("el-option",{key:t.id,attrs:{label:t.name,value:t.id}})})),1),r("el-input-number",{staticStyle:{width:"50%"},attrs:{type:"number",max:24,maxlength:"2",placeholder:"工时",precision:2},on:{input:function(r){return t.lookinput(e.useHour)}},model:{value:e.useHour,callback:function(r){t.$set(e,"useHour",t._n(r))},expression:"item.useHour"}}),r("span",{staticStyle:{margin:"0 10px"}},[t._v("小时")])],1),r("hr"),r("el-input",{staticStyle:{"margin-top":"5px",width:"100%"},attrs:{type:"textarea",rows:2,maxlength:"200","show-word-limit":"",autosize:{minRows:2,maxRows:3},placeholder:"请填写日志"},model:{value:e.daily,callback:function(r){t.$set(e,"daily",r)},expression:"item.daily"}})],1)],1)}))],2),r("div",{staticClass:"footer-btn item"},[r("el-button",{on:{click:t.handleCannel}},[t._v("取消")]),r("el-button",{attrs:{disabled:t.sunmitflag,type:"primary"},on:{click:t.handleDetailHour}},[t._v("提交")])],1)],1),r("div",{staticClass:"infoTwo"})])],1)},o=[],a=(r("d3b7"),r("159b"),r("14d9"),r("79d4")),n=r("6994"),s=r("7aed"),u={data:function(){return{dailyDialog:!1,daily:{},dailyDetail:{projectList:[],fillDate:null,useHourTotal:0,createTime:null,hourId:0,dayType:0},hoursum:0,centerDialogVisible:!1,projectList:[],id:null,fillDate:null,settiingsdata:{},useHourTotal:0,hourId:0,sunmitflag:!1,submitTips:"",workTypeSelect:[],index:0}},created:function(){this.setTings()},methods:{open:function(t){var e=this;null!=this.id?(this.daily=t,this.dailyDialog=!0,Object(s["a"])(this.id).then((function(t){200==t.code&&(t.data==[]?e.dailyDetail=0:(e.dailyDetail.hourId=t.data[0].hourId,e.dailyDetail.fillDate=t.data[0].fillDate),e.dailyDetail.projectList=t.data,e.dailyDetail.projectList.forEach((function(t){e.dailyDetail.useHourTotal+=t.useHour,t.workTypeId=t.workTypeHourList[0].workTypeId}))),t.code}))):this.$message.error("没有填报信息，请重新选择")},handleEdit:function(){this.edit()},edit:function(){var t=this;if(null==this.id)return this.$message.error("没有填报信息，请重新选择"),void(this.centerDialogVisible=!1);this.getmyhourdetail(this.id),Object(a["z"])().then((function(e){200==e.code&&(t.workTypeSelect=e.data)})),this.centerDialogVisible=!0},setTings:function(){var t=this;Object(n["b"])().then((function(e){200==e.code&&(t.settiingsdata=e.data)}))},beforeClose:function(){this.useHourTotal=0,this.dailyDetail.useHourTotal=0},handleCannel:function(){this.dailyDetail.useHourTotal=0,this.useHourTotal=0,this.projectList=[],this.centerDialogVisible=!1},handleViewCannel:function(){this.useHourTotal=0,this.dailyDetail.useHourTotal=0,this.projectList=[],this.dailyDialog=!1},getmyhourdetail:function(t){var e=this;Object(a["k"])(t).then((function(t){200==t.code&&(e.submitTips="可以提交",t.data==[]?e.hourId=0:e.hourId=t.data[0].hourId,e.projectList=t.data,e.projectList.forEach((function(t){e.useHourTotal+=t.useHour,t.hasOwnProperty("workTypeHourList")?null==t.workTypeHourList?(t.workTypeId=1,t.useHour=0):t.workTypeId=t.workTypeHourList[0].workTypeId:(t.workTypeId=1,t.useHour=0)}))),t.code}))},lookinput:function(t){var e=0;this.projectList.forEach((function(t){return e+=t.useHour+0})),this.useHourTotal=e,""===t?(this.sunmitflag=!0,this.submitTips="工时不能为空"):0===t&&e<=this.settiingsdata.workTime?(this.submitTips="可以提交!",this.sunmitflag=!1):this.settiingsdata.overtimeAllow&&e<=24?(this.sunmitflag=!1,this.submitTips="可以提交!（加班）"):e>24?(this.sunmitflag=!0,this.submitTips="工时最大范围为0-24小时!"):e>this.settiingsdata.workTime?(this.sunmitflag=!0,this.submitTips="工时范围为0-".concat(this.settiingsdata.workTime,"小时!")):e<=this.settiingsdata.workTime&&(this.sunmitflag=!1,this.submitTips="可以提交！")},handleDetailHour:function(){var t=this,e={hourId:this.hourId,projectHours:[]};this.useHourTotal=0,this.projectList.forEach((function(r){t.useHourTotal+=r.useHour;var i={detailId:r.id,hour:r.useHour,projectId:r.projectId,daily:r.daily,workTypeHourList:[{workTypeId:r.workTypeId,hour:r.useHour}]};e.projectHours.push(i)})),this.settiingsdata.overtimeAllow?Object(a["J"])(e).then((function(e){200==e.code?(t.$message.success(e.msg),t.centerDialogVisible=!1):t.$message.danger(e.msg)})):this.useHourTotal>this.settiingsdata.workTime?alert("总计不可超过".concat(this.settiingsdata.workTime,"小时")):Object(a["J"])(e).then((function(e){200==e.code?(t.$message.success(e.msg),t.useHourTotal=0,t.dailyDetail.useHourTotal=0,t.centerDialogVisible=!1,t.dailyDialog=!1):t.$message.danger(e.msg)}))}}},l=u,c=(r("ebff"),r("2877")),d=Object(c["a"])(l,i,o,!1,null,"e3875000",null);e["default"]=d.exports},ebff:function(t,e,r){"use strict";r("7d08")}}]);