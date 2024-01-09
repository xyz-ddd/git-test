<template>
  <div class="app-container">
    <el-form class="item">
      <el-form-item class="item2">
        <el-date-picker v-model="year" type="year" default-time align="right" placeholder="选择年">
        </el-date-picker>
      </el-form-item>

      <el-form-item class="item2">
        <el-date-picker popper-class="monthStyle" v-model="month" type="month" format="M月" placeholder="选择月">
        </el-date-picker>
      </el-form-item>

      <el-form-item class="item2">
        <el-button type="primary" icon="el-icon-plus" @click="submitDate">查询</el-button>
      </el-form-item>

      <el-form-item class="item2">
        <el-button type="primary" plain icon="el-icon-plus" @click="addDialogVisible = true">导入日期文件</el-button>
      </el-form-item>


    </el-form>

    <el-card>

      <el-table v-loading="loading" :data="dateList">
        <el-table-column label="序号" type="index" width="120" />
        <el-table-column label="日期" prop="date" :show-overflow-tooltip="true" width="150" />
        <el-table-column label="星期" align="center">
          <template slot-scope="scope">
            {{ scope.row.date | tranfDate }}
          </template>
        </el-table-column>

        <el-table-column label="是否节假日" align="center" width="100">
          <template slot-scope="scope">
            <el-tag v-if="scope.row.holiday === true" type="warning">节假日</el-tag>
            <el-tag v-else type="info">否</el-tag>

          </template>
        </el-table-column>

        <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
          <template slot-scope="scope" v-if="scope.row.roleId !== 1">
            <el-button size="mini" type="text" icon="el-icon-edit" @click="editHoliday(scope.row)"
              v-hasPermi="['system:role:edit']">设置/取消节假日</el-button>

            <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row.id)"
              v-hasPermi="['system:role:remove']">删除</el-button>
          </template>
        </el-table-column>


      </el-table>
      <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange"
        :current-page="queryParams.pageNum" :page-sizes="[5, 10, 15]" :page-size="queryParams.pageSize"
        layout="total, sizes, prev, pager, next, jumper" :total="total">
      </el-pagination>
    </el-card>


    <!--    上传节假日模板-->
    <el-dialog title="上传日期文件" :visible.sync="addDialogVisible" width="50%">
      <!-- 内容主题区 -->
      <el-form :model="addForm" ref="addFormRef" :rules="addFormRules" label-width="90px" >
        <el-form-item label="年份" prop="year">
          <el-select v-model="addForm.year" placeholder="请选择年份" style="margin-bottom:10px; width: auto;" >
            <el-option v-for="i in yearlist" :key="i.id" :label="i + '年'" :value="i">
            </el-option>
          </el-select>
        </el-form-item>

        <el-form-item label="选取文件" prop="fileList"  >
          <el-upload
            class="upload-demo"
            ref="uploadZip"
            :limit="1"
            :data="addForm"
            :headers="Headers"
            :action="fileUrl"
            :before-upload="handleBeforeZip"
            :on-success="handleSuccess"
            :file-list="fileListZIP"
            :auto-upload="false"
          >
            <el-button
              style="padding:6px"
              slot="trigger"
              size="small"
              type="primary"
              >选取文件</el-button>
              <div slot="tip" class="el-upload__tip">
              文件格式仅限包含xls,xlsx，并且只能上传一个。
              导入文件后将清空本年度的历史数据，请在新上传的文件中包含本年度所有节假日信息。
            </div>
          </el-upload>

        </el-form-item>

        <el-form-item label="模板下载">
          <el-link @click="importTemplate">下载模板文件</el-link>
        </el-form-item>
      </el-form>

      <span slot="footer" style="text-align: center;" class="dialog-footer">
        <div class="centered ">
          <el-button style="margin-right: 10px;" size="small" @click="close">取消</el-button>
          <el-button style="margin-right: 10px;" size="small" type="success" @click="submitUpload">提交</el-button>
        </div>
      </span>
    </el-dialog>
  </div>
</template>


<script>

import { updateFile, getHolidayList, getHolidayTemplate, editHolidayById, delHoliday } from "@/api/manage/apiHoliday";
import { getToken } from "@/utils/auth";

export default {
  name: "holiday",
  created() {
    this.getList()
  },
  data() {
    return {
      addFormRules: {
        year: [
          { required: true, message: '请选择年份', trigger: 'blur' },
        ],
      },
     
      //导入日期文件表单
      //添加工作类型表单
      downUrl: `./template.xlsx`,
      loading: true,
      dateList: [],
      total: 0,
      year: '',
      month: '',
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        year: '',
        month: ''
      },
      addDialogVisible: false,
      yearlist: [2023, 2024, 2025, 2026, 2027, 2028, 2029],

      //构建上传文件内容
      addForm: {
        year: 2023
      },
      Headers: {
        Authorization: "Bearer " + getToken()
      },
      fileListZIP: [],
      fileUrl: process.env.VUE_APP_BASE_API + "/system/holiday/importData" ,

    }
  },
  methods: {

    submitUpload() {
      console.log(this.addForm)
      console.log(this.addForm.year)
      
      this.$refs.uploadZip.submit();

    },
    close() {
      this.addDialogVisible = false;
      this.fileListZIP = [];
      // this.$parent.init();
    },

    importTemplate() {
      window.location.href = '/template.xlsx'
    },


    handleBeforeZip(file) {
      var FileExt = file.name.replace(/.+\./, "");
      if (
        [
          "xls",
          "xlsx",
        ].indexOf(FileExt.toLowerCase()) === -1
      ) {
        this.$message({
          type: "warning",
          message:
            "需求文档请上传后缀名为[xls,xlsx]的文件！"
        });
        return false;
      }

      if (!file) {
        this.$message({
          type: "warning",
          message:
            "请选择文件后上传！"
        });
        return false;
      }

    },

    handleSuccess(res, file) {
      // console.log("handleSuccess", res);
      if (res.code == 200) {
        this.$message.success("上传成功");
        // this.init();
        // this.$parent.init();
        this.close();
        this.getList()
      }
    },


    submitDate() {
      if (this.month) {
        this.queryParams.month = this.dataFormatMon(this.month)
      }
      if (this.year) {
        this.queryParams.year = this.dataFormatYear(this.year)

      }
      this.getList()
    },

    handleSizeChange(newSize) {
      this.queryParams.pageSize = newSize
      this.getList()
    },
    handleCurrentChange(newPage) {
      this.queryParams.pageNum = newPage
      this.getList()
    },


    handleSelectionChange(value) {
    },
    editHoliday(row) {
      // const pub_data = {id:row.id,holiday:!row.holiday}
      // console.log(pub_data);
      editHolidayById({ id: row.id, holiday: !row.holiday }).then(res => {
        if (res.code == 200) {
          this.$message.success(res.msg);
          this.getList()
        }
      })
    },

    async handleDelete(id) {
      const confirmResult = await this.$confirm('此操作将清空该日期并且不可恢复, 是否继续?', '提示', {
        confirmButtonText: '确认删除',
        cancelButtonText: '取消',
        type: 'warning'
      }).catch(err => err)

      if (confirmResult !== 'confirm') {
        return this.msgInfo('已经取消删除')
      }
      delHoliday(id).then(response => {
        this.getList();
      })
    },


    getList() {
      getHolidayList(this.queryParams).then(respone => {
        // console.log(respone);
        this.dateList = respone.rows;
        this.total = respone.total;
        this.loading = false;
      })
    },
    dataFormatYear(date) {
      const dt = new Date(date)
      const y = dt.getFullYear()
      const m = (dt.getMonth() + 1 + '').padStart(2, '0')
      const d = (dt.getDate() + '').padStart(2, '0')
      const hh = (dt.getHours() + '').padStart(2, '0')
      const mm = (dt.getMinutes() + '').padStart(2, '0')
      const ss = (dt.getSeconds() + '').padStart(2, '0')
      return y
    },
    dataFormatMon(date) {
      const dt = new Date(date)
      const y = dt.getFullYear()
      const m = (dt.getMonth() + 1 + '').padStart(2, '0')
      const d = (dt.getDate() + '').padStart(2, '0')
      const hh = (dt.getHours() + '').padStart(2, '0')
      const mm = (dt.getMinutes() + '').padStart(2, '0')
      const ss = (dt.getSeconds() + '').padStart(2, '0')
      return m
    },

  },
  filters: {
    tranfDate(rowdate) {
      const date = new Date(rowdate)
      const weekDay = date.getDay()
      const arr = ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六']
      return arr[weekDay]
    },
  }
}


</script>
<style  lang="scss" scoped>
.item {
  margin-bottom: 18px;
  display: flex;
  justify-content: flex-start;
  margin-left: 5px;
}

.item2 {
  margin-right: 10px;
}

.monthStyle {
  .el-date-picker__header--bordered {
    display: none !important;
  }
}


.centered {
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>

