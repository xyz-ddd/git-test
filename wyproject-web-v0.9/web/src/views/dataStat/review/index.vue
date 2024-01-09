<template>
  <div class="app-container">
    <el-row :gutter="20">
      <!--部门数据-->
      <el-col :span="4" :xs="24">
        <div class="head-container">
          <el-input v-model="deptName" placeholder="请输入部门名称" clearable size="small" prefix-icon="el-icon-search" style="margin-bottom: 20px" />
        </div>
        <div class="head-container">
          <el-tree :data="deptOptions" :props="defaultProps" :expand-on-click-node="false"
            :filter-node-method="filterNode" ref="tree" default-expand-all @node-click="handleNodeClick" />
        </div>
      </el-col>
      <!--用户数据-->

      <!--用户搜索框-->
      <el-col :span="20" :xs="24">
        <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px">
          <el-form-item label="选择日期" prop="date">
            <el-date-picker v-model="queryParams.localDate" value-format="yyyy-MM-dd" default-value
              default-time :clearable="false" :editable="false" type="date" placeholder="选择日期">
            </el-date-picker>
          </el-form-item>

          <el-form-item label="用户名" prop="userName">
            <el-input v-model="queryParams.userName" placeholder="请输入用户名" clearable size="small" style="width: 240px"
              @keyup.enter.native="handleQuery" />
          </el-form-item>
          <el-form-item label="审核状态" prop="reviewStatus">
            <el-select 
                v-model="queryParams.reviewStatus" 
                placeholder="状态" 
                clearable size="small" 
                style="width: 240px">
              <el-option label="待审核" value= 1 />
              <el-option label="已通过" value= 2 />
              <el-option label="已驳回" value=-1 />
              <el-option label="全部" value="" />
            </el-select>
          </el-form-item>

          <el-form-item>
            <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
            <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
          </el-form-item>
        </el-form>

        <el-row :gutter="10" class="mb8">
        </el-row>
        <el-row :gutter="10" class="mb8">
          <!-- <right-toolbar :showSearch.sync="showSearch" @queryTable="getList" :columns="columns"></right-toolbar> -->
        </el-row>
        <!--用户列表-->
        <el-table v-loading="loading" :data="userList" :row-style="{ height: '100px' }" :cell-style="{ padding: '1px' }"  >
          <el-table-column label="ID" prop="id" width="50" align="center" />
          <el-table-column label="状态" prop="type" width="120" align="center" v-if="columns[1].visible">
            <template slot-scope="scope">
              <div>
                <el-tag v-if="scope.row.dayType == 1"><i class="el-icon-s-cooperation"></i> 工作日 </el-tag>
                <el-tag type="warning" v-else-if="scope.row.dayType == 0"><i class="el-icon-close-notification"></i>
                  节假日
                </el-tag>
              </div>
            </template>
          </el-table-column>
          <el-table-column label="日期" prop="fillDate" width="100" align="center">
          </el-table-column>
          <el-table-column label="姓名" align="center" >
            <template slot-scope="scope">
              <div>
                {{ scope.row.nickName }} /{{ scope.row.userName }}
              </div>
            </template>
          </el-table-column>

          <el-table-column label="职位" align="center" key="postName" prop="postName" width="140"
            v-if="columns[0].visible" />
          <el-table-column prop="totalHour" label="工时" align="center" width="100">
            <template slot-scope="scope">
              <span>{{ scope.row.totalHour }}小时</span>
            </template>

          </el-table-column>
          <el-table-column prop="reviewStatus" label="审核状态" align="center" width="100">
            <template slot-scope="scope">
              <div>
                <el-tag v-if="scope.row.reviewStatus == '1'" type="danger">待审核</el-tag>
                <el-tag v-else-if="scope.row.reviewStatus == '2'" type="success">审核通过</el-tag>
                <el-tag v-else-if="scope.row.reviewStatus == '-1'"  type="warning" >已驳回</el-tag>
                <el-tag v-else type="info">无需审核</el-tag>
              </div>
            </template>
          </el-table-column>

          <el-table-column label="操作" align="center">
            <template slot-scope="scope">
              <el-button @click="handleClick(scope.row,scope.$index)" type="info" size="small">查看详情</el-button>
              <el-button @click="handleReview(scope.row.id,2,scope.$index)" type="success" size="small" v-if="scope.row.reviewStatus == 1 ||scope.row.reviewStatus == -1"  v-hasPermi="['mh:review:set']"
>审核通过</el-button>
              <el-button @click="handleReview(scope.row.id,-1,scope.$index)" type="danger" size="small" v-if="scope.row.reviewStatus == 1||scope.row.reviewStatus == -1"  v-hasPermi="['mh:review:set']"
>审核驳回</el-button>
            </template>
          </el-table-column>
        </el-table>

        <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />
      </el-col>
    </el-row>

    <el-dialog title="日报详情" :visible.sync="dailyDialog" width="55%" :before-close="handleClose" align="center">
      <el-row>
        <el-col :span="24">
          <el-form ref="form" label-width="80px">
            <el-form-item>
                <el-descriptions title="信息" :column="2">
                  <el-descriptions-item label="日期"> {{ this.dailyDetail.fillDate }} </el-descriptions-item>
                  <el-descriptions-item label="类型">
                    <el-tag v-if="!this.daily.dayType" type="success">休息日</el-tag>
                    <el-tag v-else type="danger">工作日</el-tag>
                  </el-descriptions-item>
                  <el-descriptions-item label="上报人">{{ this.daily.nickName }}</el-descriptions-item>
                  <el-descriptions-item label="职位">{{ this.daily.postName }}</el-descriptions-item>
                  <el-descriptions-item label="工时数">{{ this.dailyDetail.useHourTotal }}小时</el-descriptions-item>
                  <el-descriptions-item label="审核状态">
                    <el-tag v-if="this.daily.reviewStatus == '1'" >待审核</el-tag>
                    <el-tag v-else-if="this.daily.reviewStatus == '2'">审核通过</el-tag>
                    <el-tag v-else-if="this.daily.reviewStatus == '-1'" type="danger">已驳回</el-tag>
                    <el-tag v-else type="info">无需审核</el-tag>
                  </el-descriptions-item>
                  <el-descriptions-item label="提交于">{{ this.daily.fillTime }}</el-descriptions-item>
                </el-descriptions>
            </el-form-item>
            <el-form-item>
                <div style="text-align: left;" class="el-descriptions__title">详情 </div>
               <el-table :data="this.dailyDetail.projectList" style="width: 100%" :height="tableHeight">
                    <el-table-column type="index" label="序号"   width="50" align="center"> </el-table-column>
                    <el-table-column prop="projectName" label="项目名称" width="260"  ></el-table-column>
                    <el-table-column prop="useHour" label="工时"  width="60 " align="center">
                      <template slot-scope="scope">
                        <span>{{ scope.row.useHour }}小时</span>
                      </template>
                    </el-table-column>
                    <el-table-column prop="daily" label="工作内容" align="center" >
                      <template slot-scope="scope">
                        <span>{{ !scope.row.daily ? "无" : scope.row.daily }}</span>
                      </template>
                    </el-table-column>
                  </el-table>
             
            </el-form-item>
            <el-form-item>
              <div align="center">
                <el-button @click="handleClose" type="primary" size="small">关闭</el-button>
                <el-button @click="handleReview(this.dailyDetail.hourId,2)" type="success" size="small" v-if="this.daily.reviewStatus == 1 ||this.daily.reviewStatus == -1"  v-hasPermi="['mh:review:set']">审核通过</el-button>
                <el-button @click="handleReview(this.dailyDetail.hourId,-1)" type="danger" size="small" v-if="this.daily.reviewStatus == 1 ||this.daily.reviewStatus == -1"  v-hasPermi="['mh:review:set']">审核驳回</el-button>
              </div>
            </el-form-item>
          </el-form>
        </el-col>
      </el-row>
    </el-dialog>
  </div>
</template>

<script>

import { getReview, setReview, getDailyDetail } from "@/api/dataStat/review";

import { getHourStat } from "@/api/system/project";

import {
  listUser,
  getUser,
  delUser,
  addUser,
  updateUser,
  exportUser,
  resetUserPwd,
  changeUserStatus,
  importTemplate
} from "@/api/system/user";
import { getToken } from "@/utils/auth";
import { treeselect } from "@/api/system/dept";
import Treeselect from "@riophae/vue-treeselect";
import "@riophae/vue-treeselect/dist/vue-treeselect.css";
import { getMyHourDetailt } from "@/api/system/project";


export default {
  name: "mhReview",
  components: { Treeselect },
  data() {
    return {
      tableHeight: "",
      // 前端工程师数量
      webtotal: 0,
      // 测试工程师数量
      TSTtotal: 0,
      // 遮罩层
      loading: true,
      // 导出遮罩层
      exportLoading: false,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 用户表格数据
      userList: null,
      // 弹出层标题
      title: "",
      // 部门树选项
      deptOptions: undefined,
      // 是否显示弹出层
      open: false,
      // 部门名称
      deptName: undefined,
      // 默认密码
      initPassword: undefined,

      // 日期范围
      dateRange: [],
      // 状态数据字典
      statusOptions: [],
      // 性别状态字典
      sexOptions: [],
      // 岗位选项
      postOptions: [],
      // 角色选项
      roleOptions: [],
      // 表单参数
      form: {},
      defaultProps: {
        children: "children",
        label: "label"
      },

      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        userName: undefined,
        phonenumber: undefined,
        reviewStatus: "1",
        deptId: undefined,
        localDate :""
      },



      //弹窗数据

      dailyDialog: false,
      daily: {},
      dailyDetail: {
        projectList: [],
        fillDate: null,
        useHourTotal: 0,
        hourId: 0,
        dayType: 0,

      },

      projectList: [],
      // 列信息
      columns: [
        { key: 0, label: `用户编号`, visible: true },
        { key: 1, label: `用户名称`, visible: true },
        { key: 2, label: `用户姓名`, visible: true },
        { key: 3, label: `部门`, visible: true },
        { key: 4, label: `手机号码`, visible: true },
        { key: 5, label: `状态`, visible: true },
        { key: 6, label: `创建时间`, visible: true }
      ],
      peopleTotalInfo: [],
      // 表单校验
      rules: {
      }
    };
  },
  watch: {
    // 根据名称筛选部门树
    deptName(val) {
      this.$refs.tree.filter(val);
    }
  },
  mounted() {
    //挂载window.onresize事件(动态设置table高度)
    let _this = this;
    window.onresize = () => {
      if (_this.resizeFlag) {
        clearTimeout(_this.resizeFlag);
      }
      _this.resizeFlag = setTimeout(() => {
        _this.getTableHeight();
        _this.resizeFlag = null;
      }, 100);
    };
  },
  created() {
    this.getList();
    this.getTreeselect();
    this.getTableHeight();
  },
  methods: {
    /** 查询填报率列表 */
    getList() {
      this.loading = true;
      getReview(this.queryParams).then(
        response => {
          if (response.code == 200) {
            this.userList = response.rows;
            this.webtotal = 0;
            this.TSTtotal = 0;
            this.total = response.total;

            this.loading = false;
          }
        }
      );
    },

    // 工具类
    unique(newarr) {
      let arr = newarr;
      let result = {};
      let finalResult = [];
      for (let i = 0; i < arr.length; i++) {
        //利用对象的键名无法重复的特点，cppostName是唯一区别的属性值
        result[arr[i].postName]
          ? ""
          : (result[arr[i].postName] = true && finalResult.push(arr[i]));
      }
      return finalResult;
    },

    /** 查询部门下拉树结构 */
    getTreeselect() {
      treeselect().then(response => {
        this.deptOptions = response.data;
      });
    },
    // 筛选节点
    filterNode(value, data) {
      if (!value) return true;
      return data.label.indexOf(value) !== -1;
    },
    // 节点单击事件
    handleNodeClick(data) {
      this.queryParams.deptId = data.id;
      this.getList();
    },

    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        userId: undefined,
        deptId: undefined,
        userName: undefined,
        nickName: undefined,
        password: undefined,
        phonenumber: undefined,
        email: undefined,
        sex: undefined,
        status: "0",
        remark: undefined,
        postIds: [],
        roleIds: []
      };
      this.resetForm("form");
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.dateRange = [];
      this.resetForm("queryForm");
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.userId);
      this.single = selection.length != 1;
      this.multiple = !selection.length;
    },
    // 更多操作触发
    handleCommand(command, row) {
      switch (command) {
        case "handleResetPwd":
          this.handleResetPwd(row);
          break;
        case "handleAuthRole":
          this.handleAuthRole(row);
          break;
        default:
          break;
      }
    },

    //提交审核
    handleReview(hourId,resultId,index) {
      let data1 = { hourId: hourId, resultId: resultId };
      setReview(data1).then(res => {
        if (res.code == 200) {
          this.$message.success("审核完毕");
          this.userList[index].reviewStatus = resultId;
        }
      })
    },

    handleClick(row,index) {
      this.daily = row;
      this.dailyDialog = true;
      getDailyDetail(row.id).then(res => {
        // console.log("getMyHourDetailt", res);
        if (res.code == 200) {
          if (res.data == []) {
            this.dailyDetail = 0;
          } else {
            this.dailyDetail.hourId = res.data[0].hourId;
            this.dailyDetail.fillDate = res.data[0].fillDate;
          }
          this.dailyDetail.projectList = res.data;
          this.dailyDetail.projectList.forEach(el => {
            this.dailyDetail.useHourTotal += el.useHour;
            el.workTypeId = el.workTypeHourList[0].workTypeId;
          });
        }
        if (res.code == 500) return;
      })
    },

    handleClose() {
      // this.detail= ""
      this.dailyDialog = false;
      this.dailyDetail.useHourTotal = 0;
   
    }, 



    // 提交审批操作
    handleReviewChange(row) {
      let text = row.status === "0" ? "启用" : "停用";
      this.$confirm(
        '确认要"' + text + '""' + row.userName + '"用户吗?',
        "警告",
        {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }
      )
        .then(function () {
          return changeUserStatus(row.userId, row.status);
        })
        .then(() => {
          this.msgSuccess(text + "成功");
        })
        .catch(function () {
          row.status = row.status === "0" ? "1" : "0";
        });
    },

    //计算table高度(动态设置table高度)
    getTableHeight() {
      let tableH = 840; //距离页面下方的高度
      let tableHeightDetil = window.innerHeight - tableH;
      if (tableHeightDetil <= 240) {
        this.tableHeight = 240;
      } else {
        this.tableHeight = window.innerHeight - tableH;
      }
    },

  }
};
</script>
<style scoped lang="scss">
.collapse-content {
  span {
    margin-right: 8px;
  }
}


.el-tabs--card {
  height: calc(100vh - 110px);
  /* overflow-y: auto; */
}
.el-tab-pane {
  height: calc(100vh - 110px);
  overflow-y: auto;
}
</style>
