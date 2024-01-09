<template>
  <div class="main">
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <div class="header-title">
          我的统计
        </div>
      </div>
      <div class="text item">
      </div>
      <el-table :data="tableData" border style="width: 100%">
        <el-table-column type="index" label="序号" align="center" width="50">
        </el-table-column>
        <el-table-column prop="month" label="月份" align="center">
          <!-- <template slot-scope="scope">
              <p>{{ scope.row.month }}月</p>
            </template> -->
        </el-table-column>
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

        <el-table-column prop="" label="上报-工作日天数" align="center">
          <template slot-scope="scope">
            <p>{{ scope.row.fillTotal - scope.row.overtimeTotal }}</p>
          </template> -->
        </el-table-column>

        <el-table-column prop="overtimeTotal" label="上报-加班天数" align="center">
        </el-table-column>

        <el-table-column prop="leaveTotal" label="请假天数" align="center">
        </el-table-column>
        <el-table-column prop="paidLeaveTotal" label="调休天数" align="center">
        </el-table-column>
        <el-table-column label="操作" align="center">
          <template slot-scope="scope">
            <el-button @click="handleClick(scope.row)" type="primary" size="small">查看详情</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>



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
            <el-table-column prop="status" label="状态" align="center" width="100px">
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
            <el-table-column prop="status" label="审核" align="center" width="100px">
                <template slot-scope="scope">
                  <div>
                    <el-tag v-if="scope.row.reviewStatus == '1'"  >待审核</el-tag>
                    <el-tag v-else-if="scope.row.reviewStatus == '2'"   type="success" >审核通过</el-tag>
                    <el-tag v-else-if="scope.row.reviewStatus == '-1'"  type="danger" >已驳回</el-tag>
                    <el-tag v-else-if="scope.row.reviewStatus == '0'  &&  scope.row.id " type="info">无需审批</el-tag>
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

            <el-table-column prop="fillTime" label="上报时间" width="96" align="center">
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
import { getHourStat, getHourStatDetail, getStatProject, getProjectHourCalendar } from "@/api/system/project";
import { getMyDataStat } from "@/api/dataStat/myDataStat";

export default {
  data() {
    return {
      queryParams: {
        pageNum: 1,
        pageSize: 10,
      },

      //表格数据
      tableData: [],
      total: 0,

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
    };
  },
  created() {
    this.init();
  },
  methods: {
    init() {
      this.getList();
    },


    getList() {
      getMyDataStat(this.queryParams).then(res => {
        // console.log(res);
        if (res.code == 200) {
          //this.$message.success(res.msg);
          //console.log(res);
          this.total = res.total;
          this.tableData = res.rows;
        } else {
          this.$message.error(res.msg);
        }
      });
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



    //函数末尾

  }// method 末尾



};
</script>

<style scoped lang="scss">
.header-title {
  width: 100%;
  margin: 0 auto;
  text-align: center;
  font-weight: 600;
}

.text {
  font-size: 14px;
}

.item {
  margin-bottom: 18px;
}

.clearfix:before,
.clearfix:after {
  display: table;
  content: "";
}

.clearfix:after {
  clear: both;
}

.box-card {
  width: 100%;
}

.is-selected {
  color: #1989fa;
}

.detail {
  width: 100%;
  margin: 0 auto;
}

::v-deep .__vev_calendar-wrapper {
  height: 100%;

  .cal-wrapper {
    padding: 0 50px;

    .cal-header {
      display: flex;
      justify-content: center;

      .l,
      .r {
        display: none;
      }
    }
  }
}

// ::v-deep .events-wrapper{
//   height: 410px;
//   padding: 100px 0;
// }
::v-deep .myevents-wrapper {
  background: #fff;
}

// ::v-deep .cal-header {
//   display: flex;
// }



.header-title {
  width: 100%;
  margin: 0 auto;
  text-align: center;
  font-weight: 600;
}

.text {
  font-size: 14px;
}

.item {
  margin-bottom: 18px;
}

.item-two {
  display: flex;
  justify-content: space-between;
}

.detailInformation {
  width: 30%;

  .detailInformation-item {
    width: 100%;
    line-height: 36px;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
}

.clearfix:before,
.clearfix:after {
  display: table;
  content: "";
}

.clearfix:after {
  clear: both;
}

.box-card {
  width: 100%;
}

::v-deep .__vev_calendar-wrapper {
  height: 100%;

  .cal-wrapper {
    padding: 0 50px;

    .cal-header {
      display: flex;
      justify-content: center;

      .l,
      .r {
        display: none;
      }
    }
  }
}
</style>
