<template>
  <div class="main">
    <el-dialog title="日报详情" :visible.sync="dailyDialog" width="55%" :before-close="handleViewCannel" align="center">
      <el-row>
        <el-col :span="24">
          <el-form ref="form" label-width="80px">
            <el-form-item>
              <el-descriptions title="信息" :column="2">
                <el-descriptions-item label="日期"> {{ this.dailyDetail.fillDate }} </el-descriptions-item>
                <el-descriptions-item label="类型">
                  <el-tag v-if="!this.dailyDetail.dayType" type="success">休息日</el-tag>
                  <el-tag v-else type="danger">工作日</el-tag>
                </el-descriptions-item>

                <el-descriptions-item label="工时数">{{ this.dailyDetail.useHourTotal }}小时</el-descriptions-item>
                <el-descriptions-item label="审核状态">
                  <el-tag v-if="this.daily.reviewStatus == '1'">待审核</el-tag>
                  <el-tag v-else-if="this.daily.reviewStatus == '2'">审核通过</el-tag>
                  <el-tag v-else-if="this.daily.reviewStatus == '-1'" type="danger">已驳回</el-tag>
                  <el-tag v-else type="info">无需审核</el-tag>
                </el-descriptions-item>
                <el-descriptions-item label="提交于">{{ this.daily.createTime }}</el-descriptions-item>
              </el-descriptions>
            </el-form-item>
            <el-form-item>
              <div style="text-align: left;" class="el-descriptions__title">详情 </div>
              <el-table :data="this.dailyDetail.projectList" style="width: 100%">
                <el-table-column type="index" label="序号" width="50" align="center"> </el-table-column>
                <el-table-column prop="projectName" label="项目名称" width="260"></el-table-column>
                <el-table-column prop="useHour" label="工时" width="80 " align="center">
                  <template slot-scope="scope">
                    <span>{{ scope.row.useHour }}小时</span>
                  </template>
                </el-table-column>
                <el-table-column prop="daily" label="工作内容" align="center">
                  <template slot-scope="scope">
                    <span>{{ !scope.row.daily ? "无" : scope.row.daily }}</span>
                  </template>
                </el-table-column>
              </el-table>
            </el-form-item>
            <el-form-item>
              <div align="center">
                <el-button @click="handleViewCannel"  size="small">关闭</el-button>
                <el-button @click="handleEdit" type="primary" size="small">修改</el-button>
              </div>
            </el-form-item>
          </el-form>
        </el-col>
      </el-row>
    </el-dialog>


    <el-dialog :title="'修改工时  ' + fillDate" :visible.sync="centerDialogVisible" width="31%" @close="beforeClose"
      :close-on-click-modal='false'>
      <div class="infoOne">
        <el-form :inline="false" label-width="300px" style="max-height: 400px; overflow-y: scroll;">
          <div  style="float: right;text-align: right;">
          <span class="tips" style="margin-right: 10px;">{{ submitTips }}</span>
          <el-input v-model.number="useHourTotal" :max="24" autocomplete="off" :disabled="true"
              style="width:18%"></el-input><span style="margin:0 10px">小时</span>
          </div>
          <el-form-item v-for="(item, index) in projectList" :key="index" prop="item.projectName">
            <el-card class="box-card" shadow="never">
              <div slot="header" class="clearfix">
                <span class="projectLabel">{{ item.projectName }} </span>
              </div>
              <div style="display: flex;justify-content: flex-end;">
                <el-select v-model="item.workTypeId" placeholder="请选择工作类型" style="margin-right:auto; width: auto;">
                  <el-option v-for="i in workTypeSelect" :key="i.id" :label="i.name" :value="i.id">
                  </el-option>
                </el-select>
                <el-input-number v-model.number="item.useHour" type="number" :max="24" maxlength="2" placeholder="工时"
                  style="width:50%" @input="lookinput(item.useHour)"
                  :precision="2"></el-input-number><span style="margin:0 10px">小时</span>
              </div>
              <hr />
              <el-input style="margin-top:5px;width:100%" v-model="item.daily" type="textarea" :rows="2" maxlength="200"
                show-word-limit :autosize="{ minRows: 2, maxRows: 3 }" placeholder="请填写日志">
              </el-input>
            </el-card>
          </el-form-item>
        </el-form>
        <!-- <div class="footer-btn item"> -->
        <div class="footer-btn item">
             <el-button @click="handleCannel">取消</el-button>
             <el-button :disabled="sunmitflag" type="primary" @click="handleDetailHour">提交</el-button>
        </div>
       
      </div>
      <div class="infoTwo"></div>
    </el-dialog>

  </div>
</template>

<script>
import { getMyHourDetailt, getWorkTypeSelect, updateHour } from "@/api/system/project";
import { geApptConfig } from "@/api/manage/appsSett";
import { getDailyDetail } from "@/api/dataStat/review";

export default {
  data() {
    return {
      //弹窗数据
      dailyDialog: false,
      daily: {},
      dailyDetail: {
        projectList: [],
        fillDate: null,
        useHourTotal: 0,
        createTime: null,
        hourId: 0,
        dayType: 0,
      },
      hoursum: 0,
      centerDialogVisible: false,
      projectList: [],
      id: null,
      fillDate: null,
      settiingsdata: {},
      useHourTotal: 0,
      hourId: 0,
      sunmitflag: false,
      submitTips: "",
      workTypeSelect: [],
      index: 0
    };
  },
  created() {
    this.setTings();
  },
  methods: {
    open(row) {
      if (this.id == null) {
        this.$message.error("没有填报信息，请重新选择");
        return;
      }
      this.daily = row;
      this.dailyDialog = true;
      getDailyDetail(this.id).then(res => {
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

    handleEdit() {
      //this.dailyDialog = false;
      this.edit();
    },

    edit() {
      if (this.id == null) {
        this.$message.error("没有填报信息，请重新选择");
        // this.$router.go(-1);
        this.centerDialogVisible = false;
        return;
      }
      this.getmyhourdetail(this.id);
      getWorkTypeSelect().then(res => {
        if (res.code == 200) {
          this.workTypeSelect = res.data
        }
      });
      this.centerDialogVisible = true;
    },
    setTings() {
      geApptConfig().then(res => {
        if (res.code == 200) {
          this.settiingsdata = res.data;
        }
      });
    },
    beforeClose() {
      this.useHourTotal = 0;
      this.dailyDetail.useHourTotal = 0;
    },
    handleCannel() {
      this.dailyDetail.useHourTotal = 0;
      this.useHourTotal = 0;
      this.projectList = [];
      this.centerDialogVisible = false;
      // this.$router.go(-1);
    },

    handleViewCannel() {
      this.useHourTotal = 0;
      this.dailyDetail.useHourTotal = 0;
      this.projectList = [];
      this.dailyDialog = false;
    },


    getmyhourdetail(id) {
      getMyHourDetailt(id).then(res => {
        if (res.code == 200) {
          this.submitTips = "可以提交";
          if (res.data == []) {
            this.hourId = 0;
          } else {
            this.hourId = res.data[0].hourId;
          }
          this.projectList = res.data;
          this.projectList.forEach(el => {
            //console.log("el:",el)
            this.useHourTotal += el.useHour;
            if (!el.hasOwnProperty('workTypeHourList')) {
              // console.log("对worktypeid进行重新赋值")
              el.workTypeId = 1;
              el.useHour = 0;
            } else if (el.workTypeHourList == null) {
              //console.log("对worktypeid进行重新赋值")
              el.workTypeId = 1;
              el.useHour = 0;
            } else {
              el.workTypeId = el.workTypeHourList[0].workTypeId;
            }

            //console.log("el:",el)

          });
        }
        if (res.code == 500) return;
      }

      );
    },
    lookinput(value) {
      //console.log(value);
      let hoursum = 0;
      this.projectList.forEach(el => (hoursum += el.useHour + 0));
      this. useHourTotal = hoursum;
      if (value === "") {

        this.sunmitflag = true;
        this.submitTips = "工时不能为空";
      } else if (value === 0 && hoursum <= this.settiingsdata.workTime) {
        this.submitTips = "可以提交!";
        this.sunmitflag = false;
      } else {
        //console.log("到了", hoursum);
        if (this.settiingsdata.overtimeAllow && hoursum <= 24) {
          this.sunmitflag = false;
          this.submitTips = "可以提交!（加班）";
        } else {
          if (hoursum > 24) {
            this.sunmitflag = true;
            this.submitTips = `工时最大范围为0-24小时!`;
          } else if (hoursum > this.settiingsdata.workTime) {
            this.sunmitflag = true;
            this.submitTips = `工时范围为0-${this.settiingsdata.workTime}小时!`;
          } else if (hoursum <= this.settiingsdata.workTime) {
            this.sunmitflag = false;
            this.submitTips = "可以提交！";
          }
        }
      }
    },
    handleDetailHour() {
      // console.log("修改工时");
      let _this = this;
      let data = {
        hourId: this.hourId,
        projectHours: [],

      };
      this.useHourTotal = 0;
      this.projectList.forEach(el => {
        this.useHourTotal += el.useHour;
        // console.log(el);
        workTypeHourList: []
        let temp = {
          detailId: el.id,
          hour: el.useHour,
          projectId: el.projectId,
          daily: el.daily,
          workTypeHourList: [
            {
              workTypeId: el.workTypeId, hour: el.useHour
            }
          ]
        };
        data.projectHours.push(temp);
      });
      // console.log(data);
      if (this.settiingsdata.overtimeAllow) {
        updateHour(data).then(res => {
          // console.log(res);
          if (res.code == 200) {
            this.$message.success(res.msg);
            // _this.$router.go(-1);
            this.centerDialogVisible = false;
            // this.$router.push({path:"/workingHours/myWorkingHours"})
          } else {
            this.$message.danger(res.msg);
          }
        });
      } else if (this.useHourTotal > this.settiingsdata.workTime) {
        alert(`总计不可超过${this.settiingsdata.workTime}小时`);
      } else {
        // alert('用了工时'+ this.useHourTotal)
        updateHour(data).then(res => {
          // console.log(res);
          if (res.code == 200) {
            this.$message.success(res.msg);
            // _this.$router.go(-1);
            this.useHourTotal = 0;
            this.dailyDetail.useHourTotal = 0;
            this.centerDialogVisible = false;
            this.dailyDialog = false;
            // this.$router.push({path:"/workingHours/myWorkingHours"})
          } else {
            this.$message.danger(res.msg);
          }
        });
      }
    }
  }
};
</script>

<style scoped lang="scss">
.main {
  width: 95%;
  margin: 0 auto;
  margin-top: 12px;
}

.text {
  font-size: 14px;
}

.item {
  // margin-bottom: 18px;
  display: flex;
  justify-content: center;
  align-items: center;
}

.footer-btn.item {
  margin-bottom: 0;
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
  margin: 0 0 2px 0;
}

.tableOne {
  width: 30%;
}

.tabletwo {
  width: 30%;
}

.tablethree {
  width: 30%;
}

.tips {
  // text-align: center;
  color: red;
  font-size: 12px;
  margin: 0 auto;
}

::v-deep .el-dialog {
  margin-bottom: 15vh;
}

::v-deep .el-dialog__body {
  padding-bottom: 0 !important;
}

::v-deep .el-form-item {
  margin-bottom: 28px;
}

::v-deep .el-form-item__label {
  text-align: left;
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
}

::v-deep .el-form-item__content {
  margin-left: 0 !important;
}
</style>
