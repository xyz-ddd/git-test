(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-2377759b"],{"4dfb":function(t,e,r){},"5d9f":function(t,e,r){"use strict";r("4dfb")},"79d4":function(t,e,r){"use strict";r.d(e,"y",(function(){return o})),r.d(e,"c",(function(){return a})),r.d(e,"A",(function(){return u})),r.d(e,"d",(function(){return s})),r.d(e,"f",(function(){return i})),r.d(e,"g",(function(){return l})),r.d(e,"v",(function(){return c})),r.d(e,"H",(function(){return d})),r.d(e,"e",(function(){return f})),r.d(e,"n",(function(){return m})),r.d(e,"q",(function(){return p})),r.d(e,"l",(function(){return h})),r.d(e,"m",(function(){return y})),r.d(e,"j",(function(){return b})),r.d(e,"b",(function(){return j})),r.d(e,"z",(function(){return g})),r.d(e,"a",(function(){return v})),r.d(e,"k",(function(){return D})),r.d(e,"I",(function(){return O})),r.d(e,"h",(function(){return _})),r.d(e,"i",(function(){return k})),r.d(e,"D",(function(){return w})),r.d(e,"F",(function(){return I})),r.d(e,"E",(function(){return q})),r.d(e,"B",(function(){return S})),r.d(e,"C",(function(){return x})),r.d(e,"G",(function(){return C})),r.d(e,"t",(function(){return T})),r.d(e,"u",(function(){return F})),r.d(e,"s",(function(){return N})),r.d(e,"w",(function(){return H})),r.d(e,"r",(function(){return $})),r.d(e,"x",(function(){return E})),r.d(e,"o",(function(){return L})),r.d(e,"p",(function(){return V}));r("99af");var n=r("b775");function o(){return Object(n["a"])({url:"/system/project/work/list",method:"get"})}function a(t){return Object(n["a"])({url:"/system/project/create",method:"post",data:t})}function u(t){return Object(n["a"])({url:"/system/project/list",method:"get",params:t})}function s(t){return Object(n["a"])({url:"/system/project/remove?projectId="+t,method:"delete"})}function i(){return Object(n["a"])({url:"/system/user/box",method:"get"})}function l(t){return Object(n["a"])({url:"/system/dict/data/type/"+t,method:"get"})}function c(t){return Object(n["a"])({url:"/system/project/list?projectStatus="+t,method:"get"})}function d(t,e){var r={projectId:t,projectStatus:e};return Object(n["a"])({url:"/system/project/status",method:"put",params:r})}function f(t){return Object(n["a"])({type:"form",url:"/system/project/enable",method:"put",data:t})}function m(){return Object(n["a"])({url:"/system/project/user/my/project/all",method:"get"})}function p(t){return Object(n["a"])({url:"/system/project/user/my/project/all?projectStatus="+t,method:"get"})}function h(t,e){return Object(n["a"])({url:"/mh/hour/list?endDate=".concat(t,"&startDate=").concat(e),method:"get"})}function y(t){return Object(n["a"])({url:"/mh/hour/list/miss",method:"get",params:t})}function b(t){return Object(n["a"])({url:"/system/project/user/my/project?date="+t,method:"get"})}function j(t){return Object(n["a"])({url:"/mh/hour/create",method:"post",data:t})}function g(t,e){return Object(n["a"])({url:"/mh/hour/leave?leaveDate="+t+"&leaveType="+e,method:"post"})}function v(t){return Object(n["a"])({url:"/mh/hour/unLeave?id="+t,method:"post"})}function D(t){return Object(n["a"])({url:"/mh/hour/detail?hourId="+t,method:"get"})}function O(t){return Object(n["a"])({url:"/mh/hour/edit",method:"put",data:t})}function _(t){return Object(n["a"])({url:"/mh/hour/stat?date="+t,method:"get"})}function k(t){return Object(n["a"])({url:"/mh/hour/stat/detail",method:"get",params:t})}function w(t){return Object(n["a"])({url:"/system/project/hour/stat",method:"get",params:t})}function I(t){return Object(n["a"])({url:"/system/project/hour/stat",method:"get",params:t})}function q(t){return Object(n["a"])({url:"/system/project/hour/stat/fill/detail?date=".concat(t.date,"&projectId=").concat(t.projectId),method:"get"})}function S(t){return Object(n["a"])({url:"/system/project/hour/stat/hour/month?projectId="+t,method:"get"})}function x(t){return Object(n["a"])({url:"/system/project/hour/stat/hour/month/detail",method:"get",params:t})}function C(t){return Object(n["a"])({url:"/system/project/hour/stat/hour/user?projectId=".concat(t),method:"get"})}function T(t){return Object(n["a"])({url:"/system/project/hour/daily/calendar",method:"get",params:t})}function F(t){return Object(n["a"])({url:"/system/project/hour/daily/calendar/detail",method:"get",params:t})}function N(t){return Object(n["a"])({url:"/system/project/hour/daily/list",method:"get",params:t})}function H(t){return Object(n["a"])({url:"/mh/hour/stat/export",method:"get",params:t})}function $(t){return Object(n["a"])({url:"/mh/hour/calendar?date="+t,method:"get"})}function E(t){return Object(n["a"])({url:"/mh/hour/stat/project?date="+t,method:"get"})}function L(t){return Object(n["a"])({url:"/system/project/user/my/project/list",method:"get",params:t})}function V(t){return Object(n["a"])({url:"/system/project/user/my/project/list?projectStatus="+t,method:"get"})}},c828:function(t,e,r){"use strict";r.r(e);var n=function(){var t=this,e=t.$createElement,r=t._self._c||e;return r("div",{staticClass:"main"},[r("el-dialog",{attrs:{title:"每日上报记录",visible:t.DialogVisible,width:"65%"},on:{"update:visible":function(e){t.DialogVisible=e},close:t.beforeClose}},[r("el-row",[r("el-col",{attrs:{span:24}},[r("div",{staticClass:"grid-content bg-purple-dark"},[r("el-date-picker",{attrs:{align:"right",type:"date","value-format":"yyyy-MM-dd",placeholder:"选择日期","picker-options":t.pickerOptions},on:{change:t.setqueryDate},model:{value:t.queryDate,callback:function(e){t.queryDate=e},expression:"queryDate"}}),r("span",{staticClass:"btns"},[r("el-button",{attrs:{type:"primary"},on:{click:t.toQuery}},[t._v("查询")]),r("el-button",{attrs:{type:"primary"},on:{click:t.getYesterday}},[t._v("上一日")]),r("el-button",{attrs:{type:"primary"},on:{click:t.getToday}},[t._v("今日")]),r("el-button",{attrs:{type:"primary"},on:{click:t.getLastday}},[t._v("下一日")])],1)],1)])],1),r("hr"),r("el-row",[r("el-col",{attrs:{span:24}},[r("div",{staticClass:"grid-content bg-purple-dark"},[r("div",{staticClass:"headersTitle"},[t._v(t._s(t.dailyInfo.projectName)+"-项目日报")])]),r("el-form",{ref:"form",attrs:{"label-width":"80px"}},[r("el-form-item",[r("label",{attrs:{for:""}},[t._v("时间：")]),t._v(t._s(t.headersDate)+" "),r("span",[t.dailyInfo.festivals?r("el-tag",{attrs:{type:"danger"}},[t._v("休息日")]):r("el-tag",{attrs:{type:"success"}},[t._v("工作日")])],1)]),r("el-form-item",[r("div",{staticStyle:{width:"50%"}},[r("el-descriptions",{attrs:{title:"统计",column:2}},[r("el-descriptions-item",{attrs:{label:"上报："}},[t._v(t._s(t.fillNumber)+"人")]),r("el-descriptions-item",{attrs:{label:"投入："}},[t._v(t._s(t.totalHours)+" 小时 - "+t._s((t.totalHours/t.$store.state.user.appconfig.workTime).toFixed(2))+" 人天")]),r("el-descriptions-item",{attrs:{label:"请假："}},[t._v(t._s(t.leaveNumber)+"人")]),r("el-descriptions-item",{attrs:{label:"未上报："}},[t._v(" "+t._s(t.unFillsInfo.length)+"人 ")])],1)],1)]),r("el-form-item",[r("el-descriptions",{attrs:{title:"记录",column:1}},[r("el-descriptions-item",[r("el-table",{staticStyle:{width:"100%"},attrs:{data:t.tableData,stripe:""}},[r("el-table-column",{attrs:{type:"index",label:"序号"}}),r("el-table-column",{attrs:{prop:"nickName",label:"人员"}}),r("el-table-column",{attrs:{prop:"postName",label:"职位"}}),r("el-table-column",{attrs:{prop:"everyday",label:"所属"},scopedSlots:t._u([{key:"default",fn:function(e){return[r("div",{},[e.row.everyday?r("el-tag",[t._v("每日上报")]):r("el-tag",{attrs:{type:"success"}},[t._v("临时上报")])],1)]}}])}),r("el-table-column",{attrs:{prop:"fillStatus",label:"状态"},scopedSlots:t._u([{key:"default",fn:function(e){return[r("div",{},[1==e.row.fillStatus?r("span",[t._v("上报")]):5==e.row.fillStatus?r("span",[t._v("请假")]):r("span",[t._v("调休")])])]}}])}),r("el-table-column",{attrs:{prop:"useHour",label:"工时"}}),r("el-table-column",{attrs:{prop:"daily",label:"工作内容",width:"300"}})],1)],1)],1)],1),r("el-form-item",[r("el-descriptions",{attrs:{title:"未上报(每日上报)",column:1}},[r("el-descriptions-item",t._l(t.unFillsInfo,(function(e,n){return r("el-tag",{key:n},[t._v(t._s(e.nickName))])})),1)],1)],1)],1)],1)],1)],1)],1)},o=[],a=(r("d3b7"),r("159b"),r("79d4")),u={data:function(){return{DialogVisible:!1,headersDate:"",projectId:null,lastdateval:1,yesterdateval:1,pickerOptions:{disabledDate:function(t){return t.getTime()>Date.now()},shortcuts:[{text:"今天",onClick:function(t){t.$emit("pick",new Date)}},{text:"昨天",onClick:function(t){var e=new Date;e.setTime(e.getTime()-864e5),t.$emit("pick",e)}},{text:"一周前",onClick:function(t){var e=new Date;e.setTime(e.getTime()-6048e5),t.$emit("pick",e)}}]},value1:"",queryDate:"",tableData:[],dailyInfo:{},fillsInfo:[],unFillsInfo:[]}},computed:{totalHours:function(){var t=0;return this.fillsInfo.forEach((function(e){t+=e.useHour})),t},leaveNumber:function(){var t=0;return this.fillsInfo.forEach((function(e){5==e.fillStatus&&t++})),t},fillNumber:function(){var t=0;return this.fillsInfo.forEach((function(e){1==e.fillStatus&&t++})),t}},created:function(){},methods:{open:function(){this.init(),this.DialogVisible=!0},init:function(){var t=this;console.log(this.headersDate,this.projectId),Object(a["u"])(this.setparams()).then((function(e){console.log(e),200==e.code&&(t.headersDate=t.queryDate,t.dailyInfo=e.data,t.fillsInfo=e.data.fills,t.unFillsInfo=e.data.unFills,t.tableData=t.fillsInfo)}))},setparams:function(){return{localDate:this.queryDate,projectId:this.projectId}},setqueryDate:function(){console.log(this.queryDate)},toQuery:function(){console.log("toQuery",this.setparams()),this.init()},getToday:function(){console.log("getToday",this.getday(0)),this.queryDate=this.getday(new Date,0),this.init()},getLastday:function(){new Date(this.queryDate)>=new Date?this.$message.error("未到时间，暂无数据"):(console.log("getLastday"),this.queryDate=this.getday(this.queryDate,this.yesterdateval),this.init())},beforeClose:function(){},getYesterday:function(){console.log("getYesterday",this.getday(-this.lastdateval)),this.queryDate=this.getday(this.queryDate,-this.lastdateval),this.init()},getday:function(t,e){var r=new Date(t);r.setDate(r.getDate()+e);var n=r.getFullYear(),o=r.getMonth()+1,a=r.getDate();return o=o<10?"0"+o:o,a=a<10?"0"+a:a,n+"-"+o+"-"+a}}},s=u,i=(r("5d9f"),r("2877")),l=Object(i["a"])(s,n,o,!1,null,"2ca902f6",null);e["default"]=l.exports}}]);