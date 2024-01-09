<template>
  <div class="main">

<!--    搜索区域-->

<!--    按钮区域-->
    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="addDialogVisible = true"
          v-hasPermi="['system:role:add']"
        >新增</el-button
        >
      </el-col>
    </el-row>
    <!--列表区域-->
    <el-card class="box-card">
      <el-table  :data="typeList">
        <el-table-column label="ID"   prop="id"  width="60px" />
        <el-table-column
          label="工作类型"
          prop="name"
          :show-overflow-tooltip="true"
          width="150px"
        />
        <el-table-column
          label="创建时间"
          align="center"
          prop="createTime"
        >
          <template slot-scope="scope">
            <span>{{ parseTime(scope.row.createTime) }}</span>
          </template>
        </el-table-column>
        <el-table-column
          label="操作"
          align="center"
          class-name="small-padding fixed-width"
        >
          <template slot-scope="scope" v-if="scope.row.id !== 1">
            <el-button
              size="mini"
              type="text"
              icon="el-icon-edit"
              @click="showEditDialog(scope.row.id)"
              v-hasPermi="['system:role:edit']"
            >修改</el-button
            >
            <el-button
              size="mini"
              type="text"
              icon="el-icon-delete"
              @click="handleDelete(scope.row.id)"
              v-hasPermi="['system:role:remove']"
            >删除</el-button
            >

          </template>
        </el-table-column>
      </el-table>
    <!-- 分页区 -->
    <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange"
                   :current-page="queryInfo.newSize" :page-sizes="[1, 10, 50, 100]" :page-size="queryInfo.newPage"
                   layout="total, sizes, prev, pager, next, jumper" :total="typeTotal">
    </el-pagination>
    </el-card>

    <!-- 添加工作类型的对话框 -->
    <el-dialog title="添加工作类型" :visible.sync="addDialogVisible" width="50%" @close="addDialogClosed"  :close-on-click-modal="false">
      <!-- 内容主题区 -->
      <el-form :model="addForm" :rules="addFormRules" ref="addFormRef" label-width="90px"  @keyup.enter.native="addType">
        <el-form-item label="工作类型" prop="name" >
          <el-input v-model="addForm.name"></el-input>
        </el-form-item>
      </el-form>
      <!-- 底部按钮区 -->
      <span slot="footer" class="dialog-footer">
                <el-button @click="addDialogVisible = false">取 消</el-button>
                <el-button type="primary" @click="addType">确 定</el-button>
            </span>
    </el-dialog>


    <!-- 修改工作类型的对话框 -->
    <el-dialog title="修改工作类型" :visible.sync="editDialogVisible" width="50%" @close="editDialogClosed" :close-on-click-modal="false">
      <!-- 内容主题区 -->
      <el-form :model="editForm" :rules="addFormRules" ref="editFormRef" label-width="90px" @keyup.enter.native="editType">
        <el-form-item label="工作类型" prop="name" >
          <el-input v-model="editForm.name"></el-input>
        </el-form-item>
      </el-form>
      <!-- 底部按钮区 -->
      <span slot="footer" class="dialog-footer">
                <el-button @click="editDialogVisible = false">取 消</el-button>
                <el-button type="primary" @click="editType">确 定</el-button>
            </span>
    </el-dialog>



  </div>

</template>

<script>

import { creatWorkType, delWorkType, editWorkType, getWork, getWorkTypeList } from "@/api/manage/wordType";

export default {
  data() {
    return {

      addFormRules: {
        name: [
          { required: true, message: '请输入工作类型名称', trigger: 'blur' },
          { min: 1, max: 10, message: '长度在 1到 10 个字符', trigger: 'blur' }
        ],
      },
      //添加用户对话框
      addDialogVisible:false,


      //添加工作类型表单
      addForm:{
            name:''
      },

      //编辑类型

      editDialogVisible:false,

      editForm:{
          name:''
      },

      //工作类型列表
      typeList:[],
      typeTotal:0,

      queryInfo: {
        type: 3,
        pageNum: 1,
        pageSize : 10
      },


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
      // 角色表格数据
      roleList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 是否显示弹出层（数据权限）
      openDataScope: false,
      menuExpand: false,
      menuNodeAll: false,
      deptExpand: true,
      deptNodeAll: false,
      // 日期范围
      dateRange: [],
      // 状态数据字典
      statusOptions: [],
      // 数据范围选项
      dataScopeOptions: [
        {
          value: "1",
          label: "全部数据权限"
        },
        {
          value: "2",
          label: "自定数据权限"
        },
        {
          value: "3",
          label: "本部门数据权限"
        },
        {
          value: "4",
          label: "本部门及以下数据权限"
        },
        {
          value: "5",
          label: "仅本人数据权限"
        }
      ],
      // 菜单列表
      menuOptions: [],
      // 部门列表
      deptOptions: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        roleName: undefined,
        roleKey: undefined,
        status: undefined
      },
      // 表单参数
      form: {},
      defaultProps: {
        children: "children",
        label: "label"
      },
      // 表单校验
      rules: {
        roleName: [
          { required: true, message: "角色名称不能为空", trigger: "blur" }
        ],
        roleKey: [
          { required: true, message: "权限字符不能为空", trigger: "blur" }
        ],
        roleSort: [
          { required: true, message: "角色顺序不能为空", trigger: "blur" }
        ]
      },



    };
  },
  components: {

  },
  created() {
    this.getList();
  },
  methods: {

    addType(){
        this.$refs.addFormRef.validate(valid =>{
          if (!valid) {
            return
          }
          creatWorkType(this.addForm).then(response=>{
            this.msgSuccess("新增成功");
            this.addDialogVisible = false
            this.getList();
          })

        })
    },

    editType(){
      this.$refs.editFormRef.validate(valid =>{
        if (!valid) {
          return
        }
        editWorkType(this.editForm).then(response=>{
          this.msgSuccess("修改成功");
          this.editDialogVisible = false
          this.getList();
        })

      })
    },
    addDialogClosed(){
      this.$refs.addFormRef.resetFields()
    },

    editDialogClosed(){
      this.$refs.editFormRef.resetFields()
    },

    showEditDialog(id){
      getWork(id).then(response =>{
          this.editForm = response.data
          this.loading = false;
        //console.log(this.editForm);
      })
      this.editDialogVisible = true
    },

    async handleDelete(id){
      const confirmResult = await this.$confirm('此操作将删除该类型并且不可恢复, 是否继续?', '提示', {
        confirmButtonText: '确认删除',
        cancelButtonText: '取消',
        type: 'warning'
      }).catch(err => err)

      if (confirmResult !== 'confirm') {
        return this.msgInfo('已经取消删除')
      }
      delWorkType(id).then(response =>{
        this.getList();
      })


    },

    //查询工作类型列表
    getList(){
      this.loading =true;
      getWorkTypeList(this.queryInfo).then(response => {

        //console.log(response);
        this.typeList = response.rows;
        this.typeTotal = response.total
      });

      //console.log(this.typeList);
    },

    handleSizeChange(newSize){
      this.queryInfo.pageSize= newSize
      this.getList();
    },
    handleCurrentChange(newPage){
      this.queryInfo.pageNum = newPage
      this.getList();
    }


  }
};
</script>

<style lang="scss" scoped>
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
</style>
