<template>
  <div class="main">
    <!-- <h1>应用设置</h1> -->
    <el-form ref="form" :model="form" label-width="150px">
      <el-form-item label="每日工时数">
        <el-input maxlength="2" :max="24" v-model="form.workTime" @input="limitNumber" :disabled="!isEdit"></el-input>
      </el-form-item>
      <el-form-item label="每月工作日数">
        <el-input maxlength="2" :max="31" v-model="form.workDay" @input="limitMonthNumber" :disabled="!isEdit"></el-input>
      </el-form-item>
      <el-form-item label="是否允许加班">
        <el-switch v-model="form.overtimeAllow" active-color="#13ce66" inactive-color="#ff4949" :disabled="!isEdit"></el-switch>
      </el-form-item>

      <el-form-item label="是否开启审核">
        <el-switch v-model="form.workReview" active-color="#13ce66" inactive-color="#ff4949" :disabled="!isEdit"></el-switch>
      </el-form-item>

      <el-form-item label="是否记录0工时项目">
        <el-switch v-model="form.hourZero" active-color="#13ce66" inactive-color="#ff4949" :disabled="!isEdit"></el-switch>
      </el-form-item>


      <el-form-item>
        <el-button type="primary" size="mini" @click="handleEdit"  v-if="!isEdit"  v-hasPermi="['system:app:set:edit']">编辑</el-button>
        <el-button :disabled="showsubmit" type="primary" size="mini" @click="onSubmit" v-if="isEdit" >保存</el-button>
        <el-button size="mini"  @click="handleClose"   v-if="isEdit">返回</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import { geApptConfig, editAppConfig } from "@/api/manage/appsSett";
export default {
  data() {
    return {
      isEdit : false,
      form: {
        workTime: 8,
        workDay: 22,
        overtimeAllow: false,
        workReview: false,
        hourZero: null
      },
      showsubmit: false
    };
  },
  created() {
    this.init();
  },
  methods: {
    init() {
      geApptConfig().then(res => {
        // console.log("getapp", res);
        if (res.code == 200) {
          this.form = res.data;
        }
      });
    },

    handleEdit(){
      this.isEdit = true;
    },
    handleClose(){
      this.isEdit = false;
    },
    onSubmit() {
      // console.log("submit!");
      // console.log("form", this.form);
      editAppConfig(this.form).then(res => {
        // console.log("修改", res);
        if (res.code == 200) {
          this.$message.success("修改成功！");
          this.isEdit = false;
        }
      });
    },
    limitNumber(val) {
      // console.log(val == "");
      if (val == "" || val == 0) {
        this.showsubmit = true;
      } else {
        this.showsubmit = false;
      }
      if (val > 24) {
        this.$message.error("最长工时不能超过24小时");
        // this.showsubmit = true;
        this.form.workTime = 24;
      } else if (val == 0 || val == "") {
        this.$message.error("最短工时不能小于1小时");
        // this.showsubmit = false;
      }
    },
    limitMonthNumber(val) {
      // console.log(val);
      if (val == "" || val == 0) {
        this.showsubmit = true;
      } else {
        this.showsubmit = false;
      }
      if (val > 31) {
        this.$message.error("最长工作不能超过31天");
        // this.showsubmit = true;
        this.form.workDay = 31;
      } else if (val == 0 || val == "") {
        this.$message.error("最短工作不能小于1天");
        // this.showsubmit = false;
      }
    }
  }
};
</script>

<style></style>
