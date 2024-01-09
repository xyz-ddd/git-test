<template>
  <div class="main">
    <el-dialog title="项目月报详情" :visible.sync="DetailDialogVisible" width="65%" @close="beforeClose">
      <!-- <h1>{{ headersDate }}</h1> -->
      <el-row>
        <el-col :span="24">
          <div class="grid-content bg-purple-dark">
            <el-date-picker v-model="queryDate" align="right" type="month" value-format="yyyy-MM" placeholder="选择日期"
              :picker-options="pickerOptions" @change="setqueryDate">
            </el-date-picker><span class="btns">
              <el-button type="primary" @click="toQuery">查询</el-button>
              <el-button type="primary" @click="getToday">本月</el-button>
            </span>
          </div>
        </el-col>
      </el-row>
      <hr />
      <el-row>
        <el-form ref="form">
          <el-form-item>
            <el-row :gutter="10" class="mb8">
              <el-col>
                <el-collapse>
                  <el-collapse-item :title="'工时统计：' + date">
                    <div class="collapse-content">
                      <!-- <span>用户总数：{{ total }}人</span> -->
                      <el-descriptions title="">
                        <el-descriptions-item label="上报：">{{ fillNumber }}人</el-descriptions-item>
                        <el-descriptions-item label="投入：">
                          {{ totalHours }} 小时 - {{ (totalHours / $store.state.user.appconfig.workTime).toFixed(2) }}人天
                        </el-descriptions-item>
                      </el-descriptions>
                    </div>
                  </el-collapse-item>
                </el-collapse>
              </el-col>
            </el-row>
          </el-form-item>

          <el-form-item>
           
            <el-card class="box-card">
              <el-row :gutter="10" class="mb8">
              <el-col :span="1.5">
                <el-button type="warning" plain icon="el-icon-download" size="mini" :loading="exportLoading"
                  @click="handleExport">导出</el-button>
              </el-col>
            </el-row>
            <el-table :data="tableData" @selection-change="handleSelectionChange">
              <el-table-column type="selection" width="50" align="center" />
              <el-table-column type="index" label="序号" width="60">
              </el-table-column>
              <el-table-column prop="nickName" label="人员">
              </el-table-column>
              <el-table-column prop="postName" label="职位" width="120">
              </el-table-column>
              <el-table-column prop="useHour" label="总工时" width="120">
              </el-table-column>
              <el-table-column label="操作">
                <template slot-scope="scope">
                  <el-button @click="changeMonth(scope.row)" type="text" size="small">查看详情</el-button>
                  <el-button @click="exportStat(scope.row)" type="text" size="small">导出详情</el-button>
                </template>
              </el-table-column>
            </el-table>
            </el-card>
          </el-form-item>
        </el-form>
      </el-row>
    </el-dialog>
    <exportFile ref="exportFile" />

    <!-- 查看人员明细记录 -->
    <el-dialog title="项目月报明细详情" :visible.sync="ListDialogVisible" width="65%" @close="beforeCloseList">
      <el-card class="box-card">
        <template>
          <el-table :data="monthInfo" style="width: 100%">
            <el-table-column type="index" label="序号" width="60">
            </el-table-column>
            <el-table-column prop="fillDate" label="日期" width="100" align="center">
            </el-table-column>
            <el-table-column prop="nickName" label="人员" align="center"> </el-table-column>
            <el-table-column prop="postName" label="岗位" width="120" align="center"> </el-table-column>
            <el-table-column prop="everyday" label="所属工作组" width="130" align="center">
              <template slot-scope="scope">
                <p v-if="scope.row.everyday"><el-tag>每日上报</el-tag></p>
                <p v-else><el-tag type="success">临时上报</el-tag></p>
              </template>
            </el-table-column>
            <el-table-column prop="useHour" align="center" label="工时" width="80">
            </el-table-column>
            <el-table-column prop="daily" label="日报内容" width="180" align="center">
            </el-table-column>

            <el-table-column prop="createTime" label="填报时间" width="180" align="center">
            </el-table-column>
          </el-table>
          <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum"
            :limit.sync="queryParams.pageSize" @pagination="getsearch" />
        </template>
      </el-card>
    </el-dialog>



  </div>
</template>

<script>
// import { getMyProjectAll, getStatExport } from "@/api/system/project";

import { getProjectMonthDeatil, getStatExport } from "@/api/dataStat/projectStat";
import exportFile from "./exportFile.vue";

import {
  projectHourMonth,
  projectHourMonthDetail,
  projectHourUser
} from "@/api/system/project";


//import { utils ,xlsx} from "xlsx";
import XLSX from 'xlsx';
import { saveAs } from 'file-saver';



export default {
  name: "projectMonDetail",
  components: {
    exportFile
  },

  data() {
    return {
      DetailDialogVisible: false,
      ListDialogVisible: false,
      headersDate: "",
      projectId: null,
      lastdateval: 1,
      yesterdateval: 1,
      pickerOptions: {
        disabledDate(time) {
          return time.getTime() > Date.now();
        },
        shortcuts: [
          {
            text: "今天",
            onClick(picker) {
              picker.$emit("pick", new Date());
            }
          },
          {
            text: "昨天",
            onClick(picker) {
              const date = new Date();
              date.setTime(date.getTime() - 3600 * 1000 * 24);
              picker.$emit("pick", date);
            }
          },
          {
            text: "一周前",
            onClick(picker) {
              const date = new Date();
              date.setTime(date.getTime() - 3600 * 1000 * 24 * 7);
              picker.$emit("pick", date);
            }
          }
        ]
      },
      value1: "",
      queryDate: "",
      date: "",
      tableData: [],
      dailyInfo: {},
      fillsInfo: [],
      unFillsInfo: [],

      // 用户填报详情列表数据
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        projectId: "",
        date: undefined,
        userId: undefined
      },
      monthInfo: [],
      showcostDate: false,
      total: 0,

      //全部导出所需要的
      loading: true,
      // 导出遮罩层
      exportLoading: false,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      header: {
        //生成excel的字段：导出数据的字段
        date: "日期",
        projectId: '项目ID',
        projectName: "项目名称",
        nickName: "人员姓名",
        postName: "所属岗位",
        attendance:"填报情况",
        useHour: "工时数(小时)",
        daily: "工作内容",
        fillTime: "填报时间",

      },

    };
  },
  computed: {
    totalHours() {
      let totalHours = 0;
      this.fillsInfo.forEach(el => {
        totalHours += el.useHour;
      });
      return totalHours;
    },


    fillNumber() {
      let fillNumbers = 0;
      this.fillsInfo.forEach(el => {
        if (el.useHour > 1) {
          fillNumbers++;
        }
      });
      return fillNumbers;
    }
  },
  created() { },
  methods: {
    open() {
      // this.queryDate = this.$route.query.date;
      // this.headersDate = this.$route.query.date;
      // this.projectId = this.$route.query.id;
      this.init();
      this.DetailDialogVisible = true
    },




    beforeClose() {
      //console.log("关闭详情窗口")
      this.DetailDialogVisible = false;
    },

    beforeCloseList() {
      //console.log("关闭详情窗口")
      this.ListDialogVisible = false;
    },

    init() {
      //console.log("detail的参数:", this.date, this.projectId);

      getProjectMonthDeatil(this.setparams()).then(res => {
        // console.log(res);
        if (res.code == 200) {
          //this.headersDate = this.queryDate;
          this.dailyInfo = res.data;
          this.fillsInfo = res.data;
          //this.unFillsInfo = res.data.unFills;
          this.tableData = res.data;
        }
      });
    },
    setparams() {
      return {
        yearMonth: this.date,
        projectId: this.projectId
      };
    },
    setqueryDate() {
      console.log(this.queryDate);
    },
    toQuery() {
      //console.log("toQuery", this.setparams());
      this.date = this.queryDate

      this.init();
    },
    getToday() {
      this.queryDate = this.getday(new Date(), 0);
      this.date = this.queryDate
      this.init();
    },

    getLastday() {
      if (new Date(this.queryDate) >= new Date()) {
        this.$message.error("未到时间，暂无数据");
      } else {
        console.log("getLastday");
        this.queryDate = this.getday(this.queryDate, this.yesterdateval);
        this.init();
      }
      // this.yesterdateval++
    },

    getYesterday() {
      console.log("getYesterday", this.getday(-this.lastdateval));
      this.queryDate = this.getday(this.queryDate, -this.lastdateval);
      this.date = this.queryDate
      this.init();
      // this.lastdateval++
    },
    getday(mydate, count) {
      // 获取今日，昨日，明日
      //count -1:昨天  0：今天   1：明天
      let dd = new Date(mydate);
      dd.setDate(dd.getDate() + count); //获取AddDayCount天后的日期
      let y = dd.getFullYear();
      let m = dd.getMonth() + 1; //获取当前月份的日期
      let d = dd.getDate();
      m = m < 10 ? "0" + m : m;
      d = d < 10 ? "0" + d : d;
      // return y + "-" + m + "-" + d;
      return y + "-" + m
    },

    handledetail(row) {
      let projectId = row.projectId;
      this.$router.push({
        path: "/projectManagement/hourSubsidiary",
        query: { projectId }
      });
    },

    getsearch() {
      projectHourMonthDetail(this.queryParams).then(res => {
        // console.log("projectHourMonthDetail", res);
        if (res.code == 200) {
          this.monthInfo = res.rows;
          this.total = res.total;
        }
      });
    },


    changeMonth(row) {
      // console.log("切换详情", row);

      setTimeout(() => {
        this.ListDialogVisible = true;
      }, 200);
      this.nowMonth = this.date;
      this.queryParams.month = this.nowMonth;
      this.queryParams.projectId = this.projectId;
      this.queryParams.userId = row.userId


      projectHourMonthDetail(this.queryParams).then(res => {
        console.log("projectHourMonthDetail", res);
        if (res.code == 200) {
          this.monthInfo = res.rows;
          this.monthInfo.forEach(el => {
            if (el.costDate) {
              this.showcostDate = true;
            } else {
              this.showcostDate = false;
            }
          });
          this.total = res.total;
        }
      });
      this.showHoursub = false;
    },

    exportStat(row) {
      console.log("row:", row)
      this.$refs.exportFile.localDate = this.date + '-01';
      this.$refs.exportFile.projectId = this.projectId;
      this.$refs.exportFile.userId = row.userId;

      this.$refs.exportFile.open();

    },

    //多选框选中按钮
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.userId);
      this.single = selection.length != 1;
      this.multiple = !selection.length;

      console.log("ids:", this.ids)
    },


    //批量导出按钮
    handleExport() {
      if (this.ids.length <1){
        return 
      }

      const queryParams = this.queryParams;
      let params = {};
      params.localDate = this.date + '-01';
      params.projectId = this.projectId;

      console.log("params:", params)

      this.$confirm("是否确认导出所有用户数据项?", "警告", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      })
        .then(() => {
          this.exportLoading = true;
          for (let i in this.ids) {
            console.log("id:", i)
            params.userId = this.ids[i];
            let tempFileName = '';
            console.log("params:", params)

            getStatExport(params).then(res => {
              if (res.code == 200) {
                res.data.fillInfos.forEach(el => {
                  tempFileName = res.data.nickName + '-' + res.data.postName + '-' + this.date + '-工作日志.xls'
                  console.log("filename:", tempFileName)
                  el.nickName = res.data.nickName;
                  el.postName = res.data.postName;
                  el.projectId = res.data.projectId;
                  el.projectName = res.data.projectName;
                  if (el.status == 1) {
                    el.attendance = "已填报";
                  }
                  if (el.status == 2) {
                    el.attendance = "未填报";
                  }
                  if (el.status == 3) {
                    el.attendance = "无需填报";
                  }
                  if (el.status == 4) {
                    el.attendance = "节假日";
                  }
                  if (el.status == 5) {
                    el.attendance = "请假";
                  }
                  if (el.status == 6) {
                    el.attendance = "调休";
                  }
                  if (el.useHour == null) {
                    el.useHour = 0;
                  }
                  delete  el.status;
                });

                const workbook = XLSX.utils.book_new();

                res.data.fillInfos.unshift(this.header)
                //console.log("处理后的：",res.data.fillInfos)

                const worksheet = XLSX.utils.json_to_sheet(res.data.fillInfos,{
                  header:['date','projectId','projectName','nickName','postName','attendance','useHour','daily','fillTime'],
                  skipHeader: true, // 
                });

                XLSX.utils.book_append_sheet(workbook, worksheet, 'Sheet1');

                const excelBuffer = XLSX.write(workbook, { bookType: 'xls', type: 'array' });

                const data = new Blob([excelBuffer], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });

                saveAs(data, tempFileName);


                //XLSX(res.data.fillInfos,this.json_fields,tempFileName)


              }

            });

          }
          return '正在开始下载';



        })
        .then(response => {
          //this.download(response.msg);
          alert(response)
          this.exportLoading = false;
        })
        .catch(() => { });
    },

  },





};
</script>

<style lang="scss" scoped>
.el-row {
  margin-bottom: 20px;

  &:last-child {
    margin-bottom: 0;
  }
}

.el-col {
  border-radius: 4px;
}

.bg-purple {
  background: #d3dce6;
}

.bg-purple-light {
  background: #e5e9f2;
}

.grid-content {
  border-radius: 4px;
  min-height: 36px;
}

.row-bg {
  padding: 10px 0;
  background-color: #f9fafc;
}

.btns {
  padding: 0 12px;
}

hr {
  padding: 0.1px;
  background-color: gray;
}

.headersTitle {
  width: 100%;
  text-align: center;
  font-size: 16px;
  font-weight: 700;
  line-height: 52px;
}

.el-tag--medium {
  margin: auto 5px;
}

::v-deep .el-form-item__content {
  margin-left: 0 !important;
}

::v-deep .el-descriptions-item__label.has-colon::after {
  opacity: 0 !important;
}

::v-deep .el-dialog {
  margin-bottom: 15vh;
}

::v-deep .el-dialog__header {
  padding: 50px;
  padding-bottom: 0px;
}

::v-deep .el-dialog__body {
  padding: 30px 50px;
  padding-bottom: 30px !important;
}

::v-deep .el-form-item {
  margin-bottom: 0 !important;
}
</style>
