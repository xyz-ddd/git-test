(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-fedca432"],{"55d6":function(t,e,r){"use strict";r.r(e);var a,o=function(){var t=this,e=t.$createElement,r=t._self._c||e;return r("div",{staticClass:"main"},[t.showHoursub?r("el-card",{staticClass:"box-card"},[r("div",{staticClass:"clearfix",attrs:{slot:"header"},slot:"header"},[r("div",{staticClass:"header-title"},[t._v(" 项目工时明细 ")]),r("span",[t._v("累计投入："+t._s(t.totalPeople)+"人/("+t._s(t.totalHours)+"工时)")])]),r("div",{staticClass:"text item"},[r("div",{},[r("el-row",[r("el-button",{attrs:{type:"primary",size:"mini"},on:{click:t.changeShowHoursub}},[t._v("按月统计")]),r("el-button",{attrs:{type:"primary",size:"mini"},on:{click:t.changePeople}},[t._v("按人统计")])],1)],1)]),[r("el-table",{directives:[{name:"show",rawName:"v-show",value:t.showcardMonth,expression:"showcardMonth"}],staticStyle:{width:"100%"},attrs:{data:t.tableData,border:""}},[r("el-table-column",{attrs:{type:"index",label:"序号",align:"center",width:"50"}}),r("el-table-column",{attrs:{prop:"month",label:"月份",align:"center"}}),r("el-table-column",{attrs:{prop:"users",label:"投入人数",align:"center"},scopedSlots:t._u([{key:"default",fn:function(e){return[r("p",[t._v(t._s(e.row.users.length)+"人")])]}}],null,!1,705185147)}),r("el-table-column",{attrs:{prop:"totalPeople",label:"总投入人天",align:"center"},scopedSlots:t._u([{key:"default",fn:function(e){return[r("p",[t._v(t._s(e.row.totalPeople.toFixed(2))+"人天")])]}}],null,!1,2806445619)}),r("el-table-column",{attrs:{prop:"useHour",label:"总投入工时",align:"center"}}),r("el-table-column",{attrs:{label:"操作",align:"center"},scopedSlots:t._u([{key:"default",fn:function(e){return[r("el-button",{attrs:{type:"primary",size:"small"},on:{click:function(r){return t.changeMonth(e.row)}}},[t._v("查看")])]}}],null,!1,1798864180)})],1),r("el-table",{directives:[{name:"show",rawName:"v-show",value:t.showcardPeople,expression:"showcardPeople"}],staticStyle:{width:"100%"},attrs:{data:t.tableDataPeople,border:""}},[r("el-table-column",{attrs:{type:"index",label:"序号",align:"center",width:"50"}}),r("el-table-column",{attrs:{prop:"nickName",label:"名字",align:"center"}}),r("el-table-column",{attrs:{prop:"postName",label:"职位",align:"center"}}),r("el-table-column",{attrs:{prop:"useHour",label:"总投入工时",align:"center"}})],1)]],2):t._e(),r("el-card",{directives:[{name:"show",rawName:"v-show",value:t.showEvemts,expression:"showEvemts"},{name:"loading",rawName:"v-loading",value:t.showEvents,expression:"showEvents"}],staticClass:"box-card"},[r("div",{staticClass:"clearfix",attrs:{slot:"header"},slot:"header"},[r("div",{staticClass:"header-title"},[t._v(" 项目工时明细 "),r("el-button",{staticStyle:{float:"right"},attrs:{size:"mini",type:"primary"},on:{click:t.changeShowHoursub}},[t._v("返回")])],1)]),r("div",{staticClass:"text item item-two"},[r("div",{staticClass:"selectRows"},[r("el-form",{directives:[{name:"show",rawName:"v-show",value:t.showSearch,expression:"showSearch"}],ref:"queryParams",attrs:{model:t.queryParams,inline:!0}},[r("el-form-item",{attrs:{label:"",prop:"monthDate"}},[r("el-date-picker",{attrs:{"value-format":"yyyy-MM",type:"month",size:"mini",placeholder:"选择月"},on:{change:t.showmonthDate},model:{value:t.queryParams.month,callback:function(e){t.$set(t.queryParams,"month",e)},expression:"queryParams.month"}})],1),r("el-form-item",{attrs:{label:"",prop:"dateTime"}},[r("el-select",{attrs:{size:"mini",disabled:t.showDay,placeholder:"请选择日"},on:{change:t.showdateTime},model:{value:t.queryParams.date,callback:function(e){t.$set(t.queryParams,"date",e)},expression:"queryParams.date"}},t._l(t.day,(function(t){return r("el-option",{key:t.value,attrs:{label:t.label,value:t.value}})})),1)],1),r("el-form-item",{attrs:{label:"",prop:"value"}},[r("el-select",{attrs:{size:"mini",clearable:"",placeholder:"请选择阶段"},model:{value:t.queryParams.projectStatus,callback:function(e){t.$set(t.queryParams,"projectStatus",e)},expression:"queryParams.projectStatus"}},t._l(t.phase,(function(t){return r("el-option",{key:t.value,attrs:{label:t.label,value:t.value}})})),1)],1),r("el-form-item",{attrs:{label:"",prop:"personnelvalue"}},[r("el-select",{attrs:{clearable:"",size:"mini",placeholder:"请选择人员"},model:{value:t.queryParams.userId,callback:function(e){t.$set(t.queryParams,"userId",e)},expression:"queryParams.userId"}},t._l(t.personnel,(function(t){return r("el-option",{key:t.id,attrs:{label:t.name,value:t.id}})})),1)],1),r("el-form-item",{attrs:{label:"",prop:"positionvalue"}},[r("el-select",{attrs:{clearable:"",placeholder:"请选择岗位",size:"mini"},model:{value:t.queryParams.postId,callback:function(e){t.$set(t.queryParams,"postId",e)},expression:"queryParams.postId"}},t._l(t.position,(function(t){return r("el-option",{key:t.id,attrs:{label:t.name,value:t.id}})})),1)],1),r("el-form-item",[r("el-button",{attrs:{type:"primary",icon:"el-icon-search",size:"mini"},on:{click:t.toSearch}},[t._v("搜索")]),r("el-button",{attrs:{icon:"el-icon-refresh",size:"mini"},on:{click:function(e){return t.resetQuery("queryParams")}}},[t._v("重置")])],1)],1)],1)]),[r("el-table",{staticStyle:{width:"100%"},attrs:{data:t.monthInfo}},[r("el-table-column",{attrs:{type:"index",label:"序号",width:"60"}}),r("el-table-column",{attrs:{prop:"projectStatus",label:"阶段",width:"120"},scopedSlots:t._u([{key:"default",fn:function(e){return[r("div",["a"==e.row.projectStatus?r("p",[r("el-tag",{attrs:{type:"primary"}},[t._v("进行中")])],1):"b"==e.row.projectStatus?r("p",[r("el-tag",{attrs:{type:"warning"}},[t._v("运维中")])],1):"c"==e.row.projectStatus?r("p",[r("el-tag",{attrs:{type:"success"}},[t._v("已结束")])],1):t._e()])]}}])}),r("el-table-column",{attrs:{prop:"nickName",label:"人员"}}),r("el-table-column",{attrs:{prop:"postName",label:"岗位"}}),r("el-table-column",{attrs:{prop:"everyday",label:"所属工作组"},scopedSlots:t._u([{key:"default",fn:function(e){return[r("div",[e.row.everyday?r("p",[r("el-tag",[t._v("每日上报")])],1):r("p",[r("el-tag",{attrs:{type:"success"}},[t._v("临时上报")])],1)])]}}])}),r("el-table-column",{attrs:{prop:"useHour",align:"center",label:"工时",width:"120"}}),t.showcostDate?r("el-table-column",{attrs:{prop:"costDate",label:"上报时间",width:"180"}}):t._e(),r("el-table-column",{attrs:{prop:"createTime",label:"操作时间",width:"180"}})],1),r("pagination",{directives:[{name:"show",rawName:"v-show",value:t.total>0,expression:"total > 0"}],attrs:{total:t.total,page:t.queryParams.pageNum,limit:t.queryParams.pageSize},on:{"update:page":function(e){return t.$set(t.queryParams,"pageNum",e)},"update:limit":function(e){return t.$set(t.queryParams,"pageSize",e)},pagination:t.getsearch}})]],2)],1)},n=[],s=r("ade3"),u=(r("d3b7"),r("159b"),r("e9c4"),r("ac1f"),r("5319"),r("14d9"),r("79d4")),c=r("ff48"),l={data:function(){return{showcostDate:!1,showEvemts:!1,showEvents:!0,totalPeople:0,totalHours:0,showHoursub:!0,tableData:[],nowMonth:"",projectId:"",monthInfo:[],peopleInfo:[],tableDataPeople:[],showcardMonth:!0,showcardPeople:!1,demoEvents:[],total:0,tableDataSearch:[],showSearch:!0,showDay:!0,day:[],phase:[],personnel:[],personnelvalue:"",position:[],positionvalue:"",queryParams:{pageNum:1,pageSize:10,projectId:"",date:void 0,month:void 0,postId:void 0,projectStatus:void 0,userId:void 0}}},created:function(){this.projectId=this.$route.query.projectId,this.queryParams.projectId=this.$route.query.projectId,this.setDay(),this.gettaday(),this.setPhase(),this.init()},methods:(a={monthChange:function(t){},dayChange:function(t){},init:function(){var t=this;Object(u["G"])(this.projectId).then((function(e){200==e.code&&(t.tableDataPeople=e.data,t.peopleInfo=[])})),Object(u["B"])(this.projectId).then((function(e){t.totalHours=0,200==e.code&&(t.tableData=e.data,t.totalPeople=0,t.tableData.forEach((function(e){e.usersLength=e.users.length,t.totalPeople+=e.usersLength})),t.tableData.forEach((function(e){e.totalPeople=e.useHour/t.$store.state.user.appconfig.workTime,t.totalHours+=e.useHour})))}))},searchform:function(){var t=this;Object(c["b"])(this.projectId).then((function(e){200==e.code&&(t.personnel=e.data)})),Object(c["a"])(this.projectId).then((function(e){200==e.code&&(t.position=e.data)}))},handleClick:function(t){},initForm:function(){this.queryParams=Object.assign({},JSON.parse(JSON.stringify(this.queryParams)))},toSearch:function(){this.initForm(),this.getsearch()},changeMonth:function(t){var e=this;this.searchform();t.month.replace(/-/g,"/");setTimeout((function(){e.showEvents=!1,e.showEvemts=!0}),200),this.nowMonth=t.month,this.queryParams.month=t.month,Object(u["C"])(this.queryParams).then((function(t){200==t.code&&(e.monthInfo=t.rows,e.monthInfo.forEach((function(t){t.costDate?e.showcostDate=!0:e.showcostDate=!1})),e.total=t.total)})),this.showHoursub=!1},getsearch:function(){var t=this;Object(u["C"])(this.queryParams).then((function(e){200==e.code&&(t.monthInfo=e.rows,t.total=e.total)}))},gettaday:function(){var t=new Date,e=t.getFullYear(),r=t.getMonth()+1;r<10&&(r="0"+r);var a=e+"-"+r;return a},changeShowHoursub:function(){this.init(),this.showHoursub=!0,this.showcardMonth=!0,this.showcardPeople=!1,this.showEvemts=!1},changePeople:function(){var t=this;this.totalHours=0,this.totalPeople=this.tableDataPeople.length,this.tableDataPeople.forEach((function(e){return t.totalHours+=e.useHour})),this.showcardMonth=!1,this.showcardPeople=!0}},Object(s["a"])(a,"dayChange",(function(t){})),Object(s["a"])(a,"setDay",(function(){for(var t=[],e=1;e<=31;e++){var r={label:e,value:e};t.push(r)}this.day=t})),Object(s["a"])(a,"setPhase",(function(){var t=[{label:"进行中",value:"a"},{label:"运维中",value:"b"},{label:"已结束",value:"c"}];this.phase=t})),Object(s["a"])(a,"monthChange",(function(t){})),Object(s["a"])(a,"showmonthDate",(function(t){this.showDay=null==t})),Object(s["a"])(a,"showdateTime",(function(t){t<10&&(t="0"+t),this.queryParams.date=this.queryParams.month+"-"+t})),Object(s["a"])(a,"resetQuery",(function(){this.showDay=!0,this.queryParams={pageNum:1,pageSize:10,projectId:this.$route.query.projectId,date:void 0,month:void 0,postId:void 0,projectStatus:void 0,userId:void 0},this.getsearch()})),a)},i=l,h=(r("75b2"),r("2877")),d=Object(h["a"])(i,o,n,!1,null,"16ba3bea",null);e["default"]=d.exports},"5d09":function(t,e,r){},"75b2":function(t,e,r){"use strict";r("5d09")},"79d4":function(t,e,r){"use strict";r.d(e,"y",(function(){return o})),r.d(e,"c",(function(){return n})),r.d(e,"A",(function(){return s})),r.d(e,"d",(function(){return u})),r.d(e,"f",(function(){return c})),r.d(e,"g",(function(){return l})),r.d(e,"v",(function(){return i})),r.d(e,"H",(function(){return h})),r.d(e,"e",(function(){return d})),r.d(e,"n",(function(){return m})),r.d(e,"q",(function(){return p})),r.d(e,"l",(function(){return f})),r.d(e,"m",(function(){return b})),r.d(e,"j",(function(){return y})),r.d(e,"b",(function(){return j})),r.d(e,"z",(function(){return v})),r.d(e,"a",(function(){return g})),r.d(e,"k",(function(){return w})),r.d(e,"I",(function(){return O})),r.d(e,"h",(function(){return P})),r.d(e,"i",(function(){return I})),r.d(e,"D",(function(){return S})),r.d(e,"F",(function(){return q})),r.d(e,"E",(function(){return _})),r.d(e,"B",(function(){return D})),r.d(e,"C",(function(){return k})),r.d(e,"G",(function(){return x})),r.d(e,"t",(function(){return H})),r.d(e,"u",(function(){return C})),r.d(e,"s",(function(){return z})),r.d(e,"w",(function(){return E})),r.d(e,"r",(function(){return N})),r.d(e,"x",(function(){return M})),r.d(e,"o",(function(){return $})),r.d(e,"p",(function(){return T}));r("99af");var a=r("b775");function o(){return Object(a["a"])({url:"/system/project/work/list",method:"get"})}function n(t){return Object(a["a"])({url:"/system/project/create",method:"post",data:t})}function s(t){return Object(a["a"])({url:"/system/project/list",method:"get",params:t})}function u(t){return Object(a["a"])({url:"/system/project/remove?projectId="+t,method:"delete"})}function c(){return Object(a["a"])({url:"/system/user/box",method:"get"})}function l(t){return Object(a["a"])({url:"/system/dict/data/type/"+t,method:"get"})}function i(t){return Object(a["a"])({url:"/system/project/list?projectStatus="+t,method:"get"})}function h(t,e){var r={projectId:t,projectStatus:e};return Object(a["a"])({url:"/system/project/status",method:"put",params:r})}function d(t){return Object(a["a"])({type:"form",url:"/system/project/enable",method:"put",data:t})}function m(){return Object(a["a"])({url:"/system/project/user/my/project/all",method:"get"})}function p(t){return Object(a["a"])({url:"/system/project/user/my/project/all?projectStatus="+t,method:"get"})}function f(t,e){return Object(a["a"])({url:"/mh/hour/list?endDate=".concat(t,"&startDate=").concat(e),method:"get"})}function b(t){return Object(a["a"])({url:"/mh/hour/list/miss",method:"get",params:t})}function y(t){return Object(a["a"])({url:"/system/project/user/my/project?date="+t,method:"get"})}function j(t){return Object(a["a"])({url:"/mh/hour/create",method:"post",data:t})}function v(t,e){return Object(a["a"])({url:"/mh/hour/leave?leaveDate="+t+"&leaveType="+e,method:"post"})}function g(t){return Object(a["a"])({url:"/mh/hour/unLeave?id="+t,method:"post"})}function w(t){return Object(a["a"])({url:"/mh/hour/detail?hourId="+t,method:"get"})}function O(t){return Object(a["a"])({url:"/mh/hour/edit",method:"put",data:t})}function P(t){return Object(a["a"])({url:"/mh/hour/stat?date="+t,method:"get"})}function I(t){return Object(a["a"])({url:"/mh/hour/stat/detail",method:"get",params:t})}function S(t){return Object(a["a"])({url:"/system/project/hour/stat",method:"get",params:t})}function q(t){return Object(a["a"])({url:"/system/project/hour/stat",method:"get",params:t})}function _(t){return Object(a["a"])({url:"/system/project/hour/stat/fill/detail?date=".concat(t.date,"&projectId=").concat(t.projectId),method:"get"})}function D(t){return Object(a["a"])({url:"/system/project/hour/stat/hour/month?projectId="+t,method:"get"})}function k(t){return Object(a["a"])({url:"/system/project/hour/stat/hour/month/detail",method:"get",params:t})}function x(t){return Object(a["a"])({url:"/system/project/hour/stat/hour/user?projectId=".concat(t),method:"get"})}function H(t){return Object(a["a"])({url:"/system/project/hour/daily/calendar",method:"get",params:t})}function C(t){return Object(a["a"])({url:"/system/project/hour/daily/calendar/detail",method:"get",params:t})}function z(t){return Object(a["a"])({url:"/system/project/hour/daily/list",method:"get",params:t})}function E(t){return Object(a["a"])({url:"/mh/hour/stat/export",method:"get",params:t})}function N(t){return Object(a["a"])({url:"/mh/hour/calendar?date="+t,method:"get"})}function M(t){return Object(a["a"])({url:"/mh/hour/stat/project?date="+t,method:"get"})}function $(t){return Object(a["a"])({url:"/system/project/user/my/project/list",method:"get",params:t})}function T(t){return Object(a["a"])({url:"/system/project/user/my/project/list?projectStatus="+t,method:"get"})}},ff48:function(t,e,r){"use strict";r.d(e,"c",(function(){return o})),r.d(e,"d",(function(){return n})),r.d(e,"a",(function(){return s})),r.d(e,"b",(function(){return u})),r.d(e,"e",(function(){return c}));var a=r("b775");function o(t,e){return Object(a["a"])({url:"/system/project/hour/stat/fill?localDate="+t+"&projectId="+e,method:"get"})}function n(t){return Object(a["a"])({url:"/system/project/hour/stat/fill/detail",method:"get",params:t})}function s(t){return Object(a["a"])({url:"/system/project/hour/project/posts?projectId="+t,method:"get"})}function u(t){return Object(a["a"])({url:"/system/project/hour/project/users?projectId="+t,method:"get"})}function c(t,e){return Object(a["a"])({url:"/system/project/hour/stat/calendar?localDate="+t+"&projectId="+e,method:"get"})}}}]);