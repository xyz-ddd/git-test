(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-24070a6f"],{"79d4":function(t,e,r){"use strict";r.d(e,"z",(function(){return n})),r.d(e,"c",(function(){return u})),r.d(e,"B",(function(){return s})),r.d(e,"d",(function(){return o})),r.d(e,"f",(function(){return l})),r.d(e,"g",(function(){return i})),r.d(e,"w",(function(){return c})),r.d(e,"I",(function(){return d})),r.d(e,"e",(function(){return p})),r.d(e,"n",(function(){return f})),r.d(e,"r",(function(){return h})),r.d(e,"l",(function(){return m})),r.d(e,"m",(function(){return y})),r.d(e,"j",(function(){return b})),r.d(e,"b",(function(){return j})),r.d(e,"A",(function(){return v})),r.d(e,"a",(function(){return g})),r.d(e,"k",(function(){return _})),r.d(e,"J",(function(){return w})),r.d(e,"h",(function(){return O})),r.d(e,"i",(function(){return k})),r.d(e,"E",(function(){return S})),r.d(e,"G",(function(){return x})),r.d(e,"F",(function(){return C})),r.d(e,"C",(function(){return F})),r.d(e,"D",(function(){return D})),r.d(e,"H",(function(){return T})),r.d(e,"u",(function(){return q})),r.d(e,"v",(function(){return H})),r.d(e,"t",(function(){return I})),r.d(e,"x",(function(){return $})),r.d(e,"s",(function(){return N})),r.d(e,"y",(function(){return M})),r.d(e,"o",(function(){return E})),r.d(e,"p",(function(){return V})),r.d(e,"q",(function(){return J}));r("99af");var a=r("b775");function n(){return Object(a["a"])({url:"/system/project/work/list",method:"get"})}function u(t){return Object(a["a"])({url:"/system/project/create",method:"post",data:t})}function s(t){return Object(a["a"])({url:"/system/project/list",method:"get",params:t})}function o(t){return Object(a["a"])({url:"/system/project/remove?projectId="+t,method:"delete"})}function l(){return Object(a["a"])({url:"/system/user/box",method:"get"})}function i(t){return Object(a["a"])({url:"/system/dict/data/type/"+t,method:"get"})}function c(t){return Object(a["a"])({url:"/system/project/list?projectStatus="+t,method:"get"})}function d(t,e){var r={projectId:t,projectStatus:e};return Object(a["a"])({url:"/system/project/status",method:"put",params:r})}function p(t){return Object(a["a"])({type:"form",url:"/system/project/enable",method:"put",data:t})}function f(){return Object(a["a"])({url:"/system/project/user/my/project/all",method:"get"})}function h(t){return Object(a["a"])({url:"/system/project/user/my/project/all?projectStatus="+t,method:"get"})}function m(t,e){return Object(a["a"])({url:"/mh/hour/list?endDate=".concat(t,"&startDate=").concat(e),method:"get"})}function y(t){return Object(a["a"])({url:"/mh/hour/list/miss",method:"get",params:t})}function b(t){return Object(a["a"])({url:"/system/project/user/my/project?date="+t,method:"get"})}function j(t){return Object(a["a"])({url:"/mh/hour/create",method:"post",data:t})}function v(t,e){return Object(a["a"])({url:"/mh/hour/leave?leaveDate="+t+"&leaveType="+e,method:"post"})}function g(t){return Object(a["a"])({url:"/mh/hour/unLeave?id="+t,method:"post"})}function _(t){return Object(a["a"])({url:"/mh/hour/detail?hourId="+t,method:"get"})}function w(t){return Object(a["a"])({url:"/mh/hour/edit",method:"put",data:t})}function O(t){return Object(a["a"])({url:"/mh/hour/stat?date="+t,method:"get"})}function k(t){return Object(a["a"])({url:"/mh/hour/stat/detail",method:"get",params:t})}function S(t){return Object(a["a"])({url:"/system/project/hour/stat",method:"get",params:t})}function x(t){return Object(a["a"])({url:"/system/project/hour/stat",method:"get",params:t})}function C(t){return Object(a["a"])({url:"/system/project/hour/stat/fill/detail?date=".concat(t.date,"&projectId=").concat(t.projectId),method:"get"})}function F(t){return Object(a["a"])({url:"/system/project/hour/stat/hour/month?projectId="+t,method:"get"})}function D(t){return Object(a["a"])({url:"/system/project/hour/stat/hour/month/detail",method:"get",params:t})}function T(t){return Object(a["a"])({url:"/system/project/hour/stat/hour/user?projectId=".concat(t),method:"get"})}function q(t){return Object(a["a"])({url:"/system/project/hour/daily/calendar",method:"get",params:t})}function H(t){return Object(a["a"])({url:"/system/project/hour/daily/calendar/detail",method:"get",params:t})}function I(t){return Object(a["a"])({url:"/system/project/hour/daily/list",method:"get",params:t})}function $(t){return Object(a["a"])({url:"/mh/hour/stat/export",method:"get",params:t})}function N(t){return Object(a["a"])({url:"/mh/hour/calendar?date="+t,method:"get"})}function M(t){return Object(a["a"])({url:"/mh/hour/stat/project?date="+t,method:"get"})}function E(t){return Object(a["a"])({url:"/system/project/user/my/project/list",method:"get",params:t})}function V(t){return Object(a["a"])({url:"/system/project/user/my/project/list?projectStatus="+t,method:"get"})}function J(){return Object(a["a"])({url:"/system/project/user/pm/projectList",method:"get"})}},"880e":function(t,e,r){},d5fa:function(t,e,r){"use strict";r("880e")},d8bc:function(t,e,r){"use strict";r.r(e);var a=function(){var t=this,e=t.$createElement,r=t._self._c||e;return r("div",{staticClass:"main"},[r("el-card",{staticClass:"box-card"},[r("div",{staticClass:"clearfix",attrs:{slot:"header"},slot:"header"},[r("div",{staticClass:"selectBtn"},[r("el-date-picker",{attrs:{format:"yyyy-MM-dd","value-format":"yyyy-MM-dd","default-value":"","default-time":"",align:"right",type:"date",placeholder:"选择日期","picker-options":t.pickerOptions},on:{change:t.setDatePicker},model:{value:t.taday,callback:function(e){t.taday=e},expression:"taday"}}),r("el-row",{staticStyle:{"margin-left":"20px"}},[r("el-button",{attrs:{type:"primary"},on:{click:t.init}},[t._v("查询")]),r("el-button",{attrs:{type:"primary"},on:{click:t.getdatetaday}},[t._v("今日")]),r("el-button",{attrs:{type:"primary"},on:{click:t.getyesterday}},[t._v("上一日")]),r("el-button",{attrs:{type:"primary"},on:{click:t.weekSearch}},[t._v("按周查询")])],1)],1)]),r("div",{staticClass:"titleInfo"},[r("el-descriptions",{attrs:{title:"统计："}},[r("el-descriptions-item",{attrs:{label:"每日填报组"}},[t._v(t._s(0+t.fillsT.length)+"/"+t._s(0+t.fillsT.length+t.unFillsT.length))]),r("el-descriptions-item",{attrs:{label:"上报人数"}},[t._v(t._s(0+t.fills.length))]),r("el-descriptions-item",{attrs:{label:"今日工时投入"}},[t._v(t._s(t.totalHour)+" 小时")])],1)],1),r("div",{},[r("div",{staticClass:"tipTitle"},[t._v(" 已上报 ")]),r("div",{},[[r("el-row",{attrs:{gutter:24}},[r("el-col",{attrs:{span:12}},[r("div",{staticClass:"grid-content bg-purple"},[r("el-card",{staticClass:"box-card",attrs:{shadow:"hover"}},[r("div",{staticClass:"clearfix",attrs:{slot:"header"},slot:"header"},[r("span",[t._v("每日上报组:"+t._s(t.fillsT.length)+"人")])]),r("div",{staticClass:"text item"},[r("el-table",{staticStyle:{width:"100%"},attrs:{data:t.fillsT,"show-header":!1}},[r("el-table-column",{attrs:{type:"index",label:"序号",width:"60"}}),r("el-table-column",{attrs:{label:"姓名",width:"120"},scopedSlots:t._u([{key:"default",fn:function(e){return[r("p",[t._v(t._s(e.row.nickName))]),r("p",[t._v(t._s(e.row.postName))])]}}])}),r("el-table-column",{attrs:{prop:"createTime",label:"时间",width:"160"}}),r("el-table-column",{attrs:{prop:"useHour",label:"工时"},scopedSlots:t._u([{key:"default",fn:function(e){return[r("p",[t._v(t._s(e.row.useHour)+"小时")])]}}])})],1)],1)])],1)]),r("el-col",{attrs:{span:12}},[r("div",{staticClass:"grid-content bg-purple-light"},[r("el-card",{staticClass:"box-card",attrs:{shadow:"hover"}},[r("div",{staticClass:"clearfix",attrs:{slot:"header"},slot:"header"},[r("span",[t._v("其他组:"+t._s(t.fillsF.length)+"人")])]),r("div",{staticClass:"text item"},[r("el-table",{staticStyle:{width:"100%"},attrs:{data:t.fillsF,"show-header":!1}},[r("el-table-column",{attrs:{type:"index",label:"序号",width:"60"}}),r("el-table-column",{attrs:{label:"姓名",width:"120"},scopedSlots:t._u([{key:"default",fn:function(e){return[r("p",[t._v(t._s(e.row.nickName))]),r("p",[t._v(t._s(e.row.postName))])]}}])}),r("el-table-column",{attrs:{prop:"createTime",label:"时间",width:"160"}}),r("el-table-column",{attrs:{prop:"useHour",label:"工时"},scopedSlots:t._u([{key:"default",fn:function(e){return[r("p",[t._v(t._s(e.row.useHour)+"小时")])]}}])})],1)],1)])],1)])],1)]],2)]),r("div",{},[r("div",{staticClass:"tipTitle"},[t._v(" 未上报 ")]),r("div",{},[[r("el-row",{attrs:{gutter:24}},[r("el-col",{attrs:{span:12}},[r("div",{staticClass:"grid-content bg-purple"},[r("el-card",{staticClass:"box-card",attrs:{shadow:"hover"}},[r("div",{staticClass:"clearfix",attrs:{slot:"header"},slot:"header"},[r("span",[t._v("每日上报组("+t._s(t.unFillsT.length)+"人)："+t._s(t.unFillsT.length-t.qjStatus)+"人未报，"+t._s(t.qjStatus)+"人请假")])]),r("div",{staticClass:"text item"},[r("el-table",{staticStyle:{width:"100%"},attrs:{data:t.unFillsT,"show-header":!1}},[r("el-table-column",{attrs:{type:"index",label:"序号",width:"60"}}),r("el-table-column",{attrs:{label:"姓名",width:"120"},scopedSlots:t._u([{key:"default",fn:function(e){return[r("p",[t._v(t._s(e.row.nickName))]),r("p",[t._v(t._s(e.row.postName))])]}}])}),r("el-table-column",{attrs:{prop:"fillStatus",label:"时间",width:"160"},scopedSlots:t._u([{key:"default",fn:function(e){return[r("div",[5==e.row.fillStatus?r("p",[r("el-tag",{attrs:{type:"warning"}},[t._v("请假")])],1):r("p",[r("el-tag",{attrs:{type:"danger"}},[t._v("未填报")])],1)])]}}])}),r("el-table-column",{attrs:{prop:"useHour",label:"工时"},scopedSlots:t._u([{key:"default",fn:function(e){return[r("p",[t._v(t._s(e.row.useHour)+"小时")])]}}])})],1)],1)])],1)]),r("el-col",{attrs:{span:12}},[r("div",{staticClass:"grid-content bg-purple-light"},[r("el-card",{staticClass:"box-card",attrs:{shadow:"hover"}},[r("div",{staticClass:"clearfix",attrs:{slot:"header"},slot:"header"},[r("span",[t._v("其他组："+t._s(t.unFillsF.length)+"人")])]),r("div",{staticClass:"text item"},[r("el-table",{staticStyle:{width:"100%"},attrs:{data:t.unFillsF,"show-header":!1}},[r("el-table-column",{attrs:{type:"index",label:"序号",width:"60"}}),r("el-table-column",{attrs:{label:"姓名",width:"120"},scopedSlots:t._u([{key:"default",fn:function(e){return[r("p",[t._v(t._s(e.row.nickName))]),r("p",[t._v(t._s(e.row.postName))])]}}])}),r("el-table-column",{attrs:{prop:"createTime",label:"时间",width:"160"}}),r("el-table-column",{attrs:{prop:"useHour",label:"工时"},scopedSlots:t._u([{key:"default",fn:function(e){return[r("p",[t._v(t._s(e.row.useHour)+"小时")])]}}])})],1)],1)])],1)])],1)]],2)])])],1)},n=[],u=(r("4de4"),r("d3b7"),r("159b"),r("14d9"),r("79d4"),r("ff48")),s={data:function(){return{date:"今日",headerInfo:{},yesterdayStep:1,tableDatafills:[],tableDataunFills:[],unFills:[],fills:[],totalHour:0,qjStatus:0,projectId:"",taday:"",queryparams:{},dayVal:1,pickerOptions:{disabledDate:function(t){return t.getTime()>Date.now()},shortcuts:[{text:"今天",onClick:function(t){t.$emit("pick",new Date)}},{text:"昨天",onClick:function(t){var e=new Date;e.setTime(e.getTime()-864e5),t.$emit("pick",e)}},{text:"一周前",onClick:function(t){var e=new Date;e.setTime(e.getTime()-6048e5),t.$emit("pick",e)}}]},value1:"",yesterday:""}},created:function(){this.queryparams.projectId=this.$route.query.projectId,this.$route.query.statDate?(this.taday=this.$route.query.statDate,this.queryparams.date=this.$route.query.statDate):this.getdatetaday(),this.init()},computed:{fillsT:function(){return this.fills.filter((function(t){return 1==t.everyday}))},fillsF:function(){return this.fills.filter((function(t){return 0==t.everyday}))},unFillsT:function(){return this.unFills.filter((function(t){return 1==t.everyday}))},unFillsF:function(){return this.unFills.filter((function(t){return 0==t.everyday}))}},methods:{init:function(){var t=this;Object(u["d"])(this.queryparams).then((function(e){200==e.code&&(null==e.data.fills&&null==e.data.unFills?(t.fills=[],t.unFills=[]):(t.fills=e.data.fills,t.unFills=e.data.unFills),t.totalHour=0,t.qjStatus=0,t.fills.forEach((function(e){null==e.useHour&&(e.useHour=0),t.totalHour+=e.useHour})),t.unFills.forEach((function(e){null==e.useHour&&(e.useHour=0),5==e.fillStatus&&t.qjStatus++})))}))},setDatePicker:function(t){this.queryparams.date=t},getdatetaday:function(){this.yesterdayStep=1,this.dayVal=1;var t=new Date,e=t.getFullYear(),r=t.getMonth()+1,a=t.getDate();r<10&&(r="0"+r),a<10&&(a="0"+a);var n=e+"-"+r+"-"+a;this.taday=n,this.queryparams.date=n,this.init()},getyesterday:function(){var t=this.setyesterday(-this.dayVal);this.queryparams.date=t,this.taday=t,this.dayVal++,this.init()},setyesterday:function(t){var e=new Date,r=t||0;e.setDate(e.getDate()+r);var a=e.getFullYear(),n=e.getMonth()+1,u=e.getDate();n=n<10?"0"+n:n,u=u<10?"0"+u:u;var s=a+"-"+n+"-"+u;return s},weekSearch:function(){var t=this.queryparams.projectId;this.$router.push({path:"/projectManagement/newWorkingHouring",query:{projectId:t}})}}},o=s,l=(r("d5fa"),r("2877")),i=Object(l["a"])(o,a,n,!1,null,"b89523cc",null);e["default"]=i.exports},ff48:function(t,e,r){"use strict";r.d(e,"c",(function(){return n})),r.d(e,"d",(function(){return u})),r.d(e,"a",(function(){return s})),r.d(e,"b",(function(){return o})),r.d(e,"e",(function(){return l}));var a=r("b775");function n(t,e){return Object(a["a"])({url:"/system/project/hour/stat/fill?localDate="+t+"&projectId="+e,method:"get"})}function u(t){return Object(a["a"])({url:"/system/project/hour/stat/fill/detail",method:"get",params:t})}function s(t){return Object(a["a"])({url:"/system/project/hour/project/posts?projectId="+t,method:"get"})}function o(t){return Object(a["a"])({url:"/system/project/hour/project/users?projectId="+t,method:"get"})}function l(t,e){return Object(a["a"])({url:"/system/project/hour/stat/calendar?localDate="+t+"&projectId="+e,method:"get"})}}}]);