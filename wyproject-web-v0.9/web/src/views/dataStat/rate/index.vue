<template>
  <div class="app-container">
    <el-row :gutter="20">
      <!--部门数据-->
      <el-col :span="4" :xs="24">
        <div class="head-container">
          <el-input v-model="deptName" placeholder="请输入部门名称" clearable size="small" prefix-icon="el-icon-search"
            style="margin-bottom: 20px" />
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
          <el-form-item label="选择月份" prop="month">
            <el-date-picker v-model="queryParams.month" format="yyyy-MM" value-format="yyyy-MM" default-value default-time
              :clearable="false" :editable="false" type="month" placeholder="选择月">
            </el-date-picker>
          </el-form-item>

          <el-form-item label="用户名称" prop="userName">
            <el-input v-model="queryParams.userName" placeholder="请输入用户名" clearable size="small" style="width: 240px"
              @keyup.enter.native="handleQuery" />
          </el-form-item>
          <el-form-item label="手机号码" prop="phonenumber">
            <el-input v-model="queryParams.phonenumber" placeholder="请输入手机号码" clearable size="small" style="width: 240px"
              @keyup.enter.native="handleQuery" />
          </el-form-item>
         
          <el-form-item>
            <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
            <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
          </el-form-item>
        </el-form>
        <!--用户统计-->

        <el-row :gutter="10" class="mb8">
        </el-row>
        <el-row :gutter="10" class="mb8">
          <!-- <right-toolbar :showSearch.sync="showSearch" @queryTable="getList" :columns="columns"></right-toolbar> -->
        </el-row>
        <!--用户列表-->

        <el-table v-loading="loading" :data="userList">
          <!-- <el-table-column type="selection" width="50" align="center" /> -->
          <el-table-column label="序号" type="index" width="50" align="center" />
          <el-table-column label="月份" prop="month" width="80" align="center" />
          <el-table-column label="姓名" align="center" key="nickName" prop="nickName" v-if="columns[2].visible"
            :show-overflow-tooltip="true" />
          <el-table-column label="用户名" align="center" key="userName" prop="userName" v-if="columns[1].visible"
            :show-overflow-tooltip="true" />
          <!-- <el-table-column label="用户编号" align="center" key="userId" prop="userId" v-if="columns[0].visible" /> -->
          <el-table-column label="职位" align="center" key="postName" prop="postName" width="140"
            v-if="columns[0].visible" />
          <el-table-column prop="monthTotal" label="应报天数" align="center">
          </el-table-column>
          <el-table-column prop="fillTotal" label="实报天数" align="center">
          </el-table-column>

          <el-table-column prop="missFillTotal" label="缺报天数" align="center">
            <template slot-scope="scope">
              <p>{{ scope.row.monthTotal - scope.row.fillTotal - scope.row.leaveTotal - scope.row.paidLeaveTotal }}</p>
            </template>
          </el-table-column>

          <el-table-column prop="useHour" label="上报率" align="center">
            <template slot-scope="scope">
              <p>{{ Number(scope.row.fillTotal / scope.row.monthTotal * 100).toFixed(2) }} % </p>
            </template>

          </el-table-column>

          <el-table-column label="操作" align="center">
            <template slot-scope="scope">
              <el-button @click="handleClick(scope.row)" type="primary" size="small">查看详情</el-button>
            </template>
          </el-table-column>
        </el-table>

        <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize"
          @pagination="getList" />
      </el-col>
    </el-row>

    <!-- 添加或修改参数配置对话框 -->
    <!-- <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="用户姓名" prop="nickName">
              <el-input v-model="form.nickName" placeholder="请输入用户姓名" maxlength="30" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="归属部门" prop="deptId">
              <treeselect v-model="form.deptId" :options="deptOptions" :show-count="true" placeholder="请选择归属部门" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="手机号码" prop="phonenumber">
              <el-input v-model="form.phonenumber" placeholder="请输入手机号码" maxlength="11" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="邮箱" prop="email">
              <el-input v-model="form.email" placeholder="请输入邮箱" maxlength="50" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item v-if="form.userId == undefined" label="用户名称" prop="userName">
              <el-input v-model.trim="form.userName" @input="accountInput" placeholder="请输入用户名称" maxlength="30" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item v-if="form.userId == undefined" label="用户密码" prop="password">
              <el-input v-model="form.password" placeholder="请输入用户密码" type="password" maxlength="20" show-password />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="用户性别">
              <el-select v-model="form.sex" placeholder="请选择">
                <el-option v-for="dict in sexOptions" :key="dict.dictValue" :label="dict.dictLabel"
                  :value="dict.dictValue"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="状态">
              <el-radio-group v-model="form.status">
                <el-radio v-for="dict in statusOptions" :key="dict.dictValue" :label="dict.dictValue">{{ dict.dictLabel
                }}</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="岗位" prop="postIds">
              <el-select v-model="form.postIds" placeholder="请选择">
                <el-option v-for="item in postOptions" :key="item.postId" :label="item.postName" :value="item.postId"
                  :disabled="item.status == 1"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="角色" prop="roleIds">
              <el-select v-model="form.roleIds" placeholder="请选择">
                <el-option v-for="item in roleOptions" :key="item.roleId" :label="item.roleName" :value="item.roleId"
                  :disabled="item.status == 1"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="24">
            <el-form-item label="备注">
              <el-input v-model="form.remark" type="textarea" placeholder="请输入内容"></el-input>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog> -->

    <!-- 用户导入对话框 -->
    <!-- <el-dialog :title="upload.title" :visible.sync="upload.open" width="400px" append-to-body>
      <el-upload ref="upload" :limit="1" accept=".xlsx, .xls" :headers="upload.headers"
        :action="upload.url + '?updateSupport=' + upload.updateSupport" :disabled="upload.isUploading"
        :on-progress="handleFileUploadProgress" :on-success="handleFileSuccess" :auto-upload="false" drag>
        <i class="el-icon-upload"></i>
        <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
        <div class="text-center el-upload__tip" slot="tip">
          <div class="el-upload__tip" slot="tip">
            <el-checkbox v-model="upload.updateSupport" />
            是否更新已经存在的用户数据
          </div>
          <span>仅允许导入xls、xlsx格式文件。</span>
          <el-link type="primary" :underline="false" style="font-size:12px;vertical-align: baseline;"
            @click="importTemplate">下载模板</el-link>
        </div>
      </el-upload>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitFileForm">确 定</el-button>
        <el-button @click="upload.open = false">取 消</el-button>
      </div>
    </el-dialog> -->



    <el-dialog title="月统计详情" :visible.sync="projectDialog" width="75%" :before-close="handleClose">
      <div class="text item">
        <el-descriptions title="统计" :column="3" direction="vertical" border>

          <!-- 第一行 -->
          <el-descriptions-item label="上报总计">{{ detail.fillTotal }}天
          </el-descriptions-item>
          <el-descriptions-item label="上报-工作日天数">{{ detail.fillTotal - detail.overtimeTotal }}天
          </el-descriptions-item>
          <el-descriptions-item label="上报-加班天数">{{ detail.overtimeTotal }}天
          </el-descriptions-item>

          <!-- 第二行 -->
          <el-descriptions-item label="请假调休总计">{{ detail.leaveTotal + detail.paidLeaveTotal }}天
          </el-descriptions-item>

          <el-descriptions-item label="请假">{{ detail.leaveTotal }}天
          </el-descriptions-item>
          <el-descriptions-item label="调休">{{ detail.paidLeaveTotal }}天
          </el-descriptions-item>

          <!-- 第二行 -->
          <el-descriptions-item label="出勤小计">{{ detail.fillTotal + detail.leaveTotal + detail.paidLeaveTotal }}天
          </el-descriptions-item>


          <el-descriptions-item label="缺报">{{ detail.missFillTotal }}天
          </el-descriptions-item>

          <el-descriptions-item label="应报总数">{{ detail.monthTotal }}天
          </el-descriptions-item>
          <!-- <el-descriptions-item label="小计">{{ detail.mustFillNum  }}天（含加班）
          </el-descriptions-item> -->
        </el-descriptions>

        <div style="font-size: large;margin-top: 10px;">
          上报率:{{ Number(detail.reportRate).toFixed(2) }} % （上报总数/应报总数）


        </div>
        <hr>
      </div>

      <div class="streamline">
        <el-descriptions title="明细" :column="3" direction="vertical" border>
        </el-descriptions>
        <template>
          <el-table :data="projectList" border style="width: 100%">
            <el-table-column type="index" label="序号" align="center" width="52px">
            </el-table-column>
            <el-table-column prop="date" label="日期" align="center" width="109px">
            </el-table-column>
            <!-- <el-table-column prop="nickName" label="人员" align="center">
              </el-table-column> -->
            <!-- <el-table-column prop="postName" label="岗位" align="center">
              </el-table-column> -->
            <el-table-column prop="status" label="状态" align="center" width="109px">
              <template slot-scope="scope">
                <div>
                  <el-tag v-if="scope.row.status == 1"><i class="el-icon-check"></i> 已填报
                  </el-tag>
                  <el-tag type="danger" v-else-if="scope.row.status == 2"><i class="el-icon-close"></i> 缺报
                  </el-tag>
                  <el-tag type="info" v-else-if="scope.row.status == 3"><i class="el-icon-minus"></i> 无需填报
                  </el-tag>
                  <el-tag type="success" v-else-if="scope.row.status == 4"><i class="el-icon-magic-stick"></i> 节假日
                  </el-tag>
                  <el-tag type="warning" v-else-if="scope.row.status == 5"><i class="el-icon-close-notification"></i>
                    请假
                  </el-tag>
                  <el-tag type="warning" v-else-if="scope.row.status == 6"><i class="el-icon-refresh"></i> 调休
                  </el-tag>
                </div>
              </template>
            </el-table-column>
            <el-table-column prop="totalHour" label="上报工时" align="center" width="80">
            </el-table-column>
            <el-table-column prop="useHour" label="详情" align="center" min-width="200">
              <template slot-scope="scope" class="table-item">
                <div>
                  <el-table :data="scope.row.projectHours" style="width: 100%" :border="false" :show-header="false">
                    <el-table-column prop="projectName" label="项目" align="center">
                    </el-table-column>
                    <el-table-column prop="useHour" label="工时" align="center">
                      <template slot-scope="scope">
                        <span>{{ scope.row.useHour }}小时</span>
                      </template>
                    </el-table-column>
                    <el-table-column prop="daily" label="日志" align="center">
                    </el-table-column>
                  </el-table>
                </div>
              </template>
            </el-table-column>

            <el-table-column prop="fillTime" label="上报时间" width="80" align="center">
            </el-table-column>
            <!-- <el-table-column prop="address" label="地址"> </el-table-column> -->
          </el-table>
        </template>
      </div>


      <span slot="footer" class="dialog-footer">
        <!-- <el-button @click="closeForm">取 消</el-button>
        <el-button type="primary" @click="closeForm">确 定</el-button> -->
      </span>


    </el-dialog>

  </div>
</template>

<script>

import { getRate } from "@/api/dataStat/rate";
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




export default {
  name: "dataRate",
  components: { Treeselect },
  data() {
    return {
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
      // 用户导入参数
      upload: {
        // 是否显示弹出层（用户导入）
        open: false,
        // 弹出层标题（用户导入）
        title: "",
        // 是否禁用上传
        isUploading: false,
        // 是否更新已经存在的用户数据
        updateSupport: 0,
        // 设置上传的请求头部
        headers: { Authorization: "Bearer " + getToken() },
        // 上传的地址
        url: process.env.VUE_APP_BASE_API + "/system/user/importData"
      },
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        userName: undefined,
        phonenumber: undefined,
        status: undefined,
        deptId: undefined,
        month:undefined,
      },

        //弹窗数据

      projectDialog: false,
      detail: {
        month: "",
        monthTotal: 0,
        fillTotal: 0,
        missFillTotal: 0,
        overtimeTotal: 0,
        leaveTotal: 0,
        paidLeaveTotal: 0,
        reportRate: 0,
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
        userName: [
          { required: true, message: "用户名称不能为空", trigger: "blur" },
          {
            min: 2,
            max: 20,
            message: "用户名称长度必须介于 2 和 20 之间",
            trigger: "blur"
          }
        ],
        nickName: [
          { required: true, message: "用户姓名不能为空", trigger: "blur" }
        ],
        password: [
          { required: true, message: "用户密码不能为空", trigger: "blur" },
          {
            min: 5,
            max: 20,
            message: "用户密码长度必须介于 5 和 20 之间",
            trigger: "blur"
          }
        ],
        email: [
          {
            type: "email",
            message: "'请输入正确的邮箱地址",
            trigger: ["blur", "change"]
          }
        ],
        phonenumber: [
          {
            pattern: /^1[3|4|5|6|7|8|9][0-9]\d{8}$/,
            message: "请输入正确的手机号码",
            trigger: "blur"
          }
        ],
        postIds: [{ required: true, message: "岗位不能为空", trigger: "blur" }],
        roleIds: [{ required: true, message: "角色不能为空", trigger: "blur" }],
        deptId: [{ required: true, message: "归属部门不能为空", trigger: "blur" }]
      }
    };
  },
  watch: {
    // 根据名称筛选部门树
    deptName(val) {
      this.$refs.tree.filter(val);
    }
  },
  created() {
    // this.getRateList();
    this.getList();
    this.getTreeselect();
    // this.getDicts("sys_normal_disable").then(response => {
    //   this.statusOptions = response.data;
    // });
    // this.getDicts("sys_user_sex").then(response => {
    //   this.sexOptions = response.data;
    // });
    // this.getConfigKey("sys.user.initPassword").then(response => {
    //   this.initPassword = response.msg;
    // });
  },
  methods: {
    // 查询填报率列表
    getRateList() {
      getRate().then(res => {
        // console.log("userlist", res);
        //peopleTotalInfo
        this.rateList = [];
        res.rows.forEach(el => {
          let data = { postName: el.postName, value: 0 };
          res.rows.forEach(elt => {
            if (el.postName == elt.postName) {
              data.value += 1;
            }
          });
          this.rateList.push(data);
        });

        //this.rateList = this.unique(this.rateList);

      })
    },



    /** 查询填报率列表 */

    getList() {
      this.loading = true;
      // getRate().then(res => {
      //   // console.log("userlist", res);
      //   //peopleTotalInfo
      //   this.peopleTotalInfo = [];
      //   res.rows.forEach(el => {
      //     let data = { postName: el.postName, value: 0 };
      //     res.rows.forEach(elt => {
      //       if (el.postName == elt.postName) {
      //         data.value += 1;
      //       }
      //     });
      //     this.peopleTotalInfo.push(data);
      //     console.log("data:",this.peopleTotalInfo)
      //   });


      //   //this.peopleTotalInfo = this.unique(this.peopleTotalInfo);

      // });


      getRate(this.queryParams).then(
        response => {
          if (response.code == 200) {
            this.userList = response.rows;
            this.webtotal = 0;
            this.TSTtotal = 0;
            // this.userList.forEach(el => {
            //   if (el.postIds[0] == 5) {
            //     this.webtotal++;
            //   }
            //   if (el.postIds[0] == 7) {
            //     this.webtotal++;
            //   }
            //   if (el.postIds[0] == 10) {
            //     this.TSTtotal++;
            //   }
            // });

            //console.log("data:", response)
            this.total = response.total;

            this.loading = false;
          }
        }
      );
    },
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
    // 用户状态修改
    handleStatusChange(row) {
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


    handleClick(row) {
      this.projectDialog = true
      this.detail.month = row.month
      this.detail.monthTotal = row.monthTotal
      this.detail.fillTotal = row.fillTotal
      this.detail.leaveTotal = row.leaveTotal
      this.detail.paidLeaveTotal = row.paidLeaveTotal

      //计算内容
      this.detail.missFillTotal = row.monthTotal - row.fillTotal - row.leaveTotal - row.paidLeaveTotal
      this.detail.reportRate = row.fillTotal / row.monthTotal * 100


      this.getDataDetail();
    },

    
    closeForm() {
      this.projectDialog = false
    },

    handleClose() {
      // this.detail= ""
      this.projectDialog = false
    },

    getDataDetail() {

let date = this.detail.month + "-01"
getHourStat(date).then(res => {
  // console.log(res);
  if (res.code == 200) {
    this.stat = res.data;
    //console.log("this.stat", this.stat);
    this.projectList = res.data;
    // this.peopleday = res.data.projectHours.length;
    // console.log(this.projectList);
    this.projectList.forEach(el => {
      el.totalHour = 0;
      if (el.projectHours != null) {
        el.projectHours.forEach(fl => {
          el.totalHour += fl.useHour;
        });
      }
    });
    // console.log("project", this.projectList);
  }
});
}


    /** 新增按钮操作 */
    // handleAdd() {
    //   this.reset();
    //   this.getTreeselect();
    //   getUser().then(response => {
    //     this.postOptions = response.posts;
    //     this.roleOptions = response.roles;
    //     this.open = true;
    //     this.title = "添加用户";
    //     this.form.password = this.initPassword;
    //   });
    // },

    /** 修改按钮操作 */
    // handleUpdate(row) {
    //   this.$nextTick(() => {
    //     this.reset();
    //     this.getTreeselect();
    //     const userId = row.userId || this.ids;
    //     getUser(userId).then(response => {
    //       this.form = response.data;
    //       this.postOptions = response.posts;
    //       this.roleOptions = response.roles;
    //       this.form.postIds = response.postIds[0];
    //       this.form.roleIds = response.roleIds[0];
    //       this.open = true;
    //       this.title = "修改用户";
    //       this.form.password = "";
    //     });
    //   });
    // },

    /** 重置密码按钮操作 */
    // handleResetPwd(row) {
    //   this.$prompt('请输入"' + row.userName + '"的新密码', "提示", {
    //     confirmButtonText: "确定",
    //     cancelButtonText: "取消",
    //     closeOnClickModal: false,
    //     inputPattern: /^.{5,20}$/,
    //     inputErrorMessage: "用户密码长度必须介于 5 和 20 之间"
    //   })
    //     .then(({ value }) => {
    //       resetUserPwd(row.userId, value).then(response => {
    //         this.msgSuccess("修改成功，新密码是：" + value);
    //       });
    //     })
    //     .catch(() => { });
    // },


    /** 分配角色操作 */
    // handleAuthRole: function (row) {
    //   const userId = row.userId;
    //   this.$router.push("/system/user-auth/role/" + userId);
    // },



    /** 提交按钮 */
    // submitForm: function () {
    //   this.$refs["form"].validate(valid => {
    //     if (!Array.isArray(this.form.postIds)) {
    //       let temppostIds = this.form.postIds;

    //       this.form.postIds = [];

    //       this.form.postIds.push(temppostIds);
    //     }
    //     if (!Array.isArray(this.form.roleIds)) {
    //       let temproleIds = this.form.roleIds;

    //       this.form.roleIds = [];

    //       this.form.roleIds.push(temproleIds);
    //     }
    //     if (valid) {
    //       if (this.form.userId != undefined) {
    //         updateUser(this.form).then(response => {
    //           this.msgSuccess("修改成功");
    //           this.open = false;
    //           this.getList();
    //         });
    //       } else {
    //         addUser(this.form).then(response => {
    //           this.msgSuccess("新增成功");
    //           this.open = false;
    //           this.getList();
    //         });
    //       }
    //     }
    //   });
    // },

    /** 删除按钮操作 */
    // handleDelete(row) {
    //   const userIds = row.userId || this.ids;
    //   this.$confirm(
    //     '是否确认删除用户编号为"' + userIds + '"的数据项?',
    //     "警告",
    //     {
    //       confirmButtonText: "确定",
    //       cancelButtonText: "取消",
    //       type: "warning"
    //     }
    //   )
    //     .then(function () {
    //       return delUser(userIds);
    //     })
    //     .then(() => {
    //       this.getList();
    //       this.msgSuccess("删除成功");
    //     })
    //     .catch(() => { });
    // },

    /** 导出按钮操作 */
    // handleExport() {
    //   const queryParams = this.queryParams;
    //   this.$confirm("是否确认导出所有用户数据项?", "警告", {
    //     confirmButtonText: "确定",
    //     cancelButtonText: "取消",
    //     type: "warning"
    //   })
    //     .then(() => {
    //       this.exportLoading = true;
    //       return exportUser(queryParams);
    //     })
    //     .then(response => {
    //       console.log("res:",response)
    //       this.download(response.msg);
    //       this.exportLoading = false;
    //     })
    //     .catch(() => { });
    // },

    /** 导入按钮操作 */
    // handleImport() {
    //   this.upload.title = "用户导入";
    //   this.upload.open = true;
    // },
    /** 下载模板操作 */
    // importTemplate() {
    //   importTemplate().then(response => {
    //     this.download(response.msg);
    //   });
    // },

    // 文件上传中处理
    // handleFileUploadProgress(event, file, fileList) {
    //   this.upload.isUploading = true;
    // },

    // 文件上传成功处理
    // handleFileSuccess(response, file, fileList) {
    //   this.upload.open = false;
    //   this.upload.isUploading = false;
    //   this.$refs.upload.clearFiles();
    //   this.$alert(response.msg, "导入结果", { dangerouslyUseHTMLString: true });
    //   this.getList();
    // },


    // 提交上传文件
    // submitFileForm() {
    //   this.$refs.upload.submit();
    // },

    //账号的实时输入
    // accountInput(val) {
    //   
    //   // console.log(val);
    //   let codeReg = new RegExp("[A-Za-z0-9]+"), //正则 英文+数字；
    //     len = val.length,
    //     str = "";
    //   for (var i = 0; i < len; i++) {
    //     if (codeReg.test(val[i])) {
    //       str += val[i];
    //     }
    //   }
    //   this.form.userName = str;
    // }
  }
};
</script>
<style scoped lang="scss">
.collapse-content {
  span {
    margin-right: 8px;
  }
}
</style>
