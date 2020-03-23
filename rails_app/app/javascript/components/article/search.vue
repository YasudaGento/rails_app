<style scoped>
  .el-row {
    margin-bottom: 20px;
  }
  .el-col {
    margin: 0 2px;
    border-radius: 4px;
  }
</style>

<template>
  <div>
    <el-form @submit.native.prevent="onSearch">
      <el-row>
        <el-col :span="4">
          <el-input id='user_name' v-model="query.user_name_cont" placeholder="投稿者" />
        </el-col>
        <el-col :span="4">
          <el-input id='title' v-model="query.title_cont" placeholder="タイトル" />
        </el-col>
        <el-col :span="4">
          <el-date-picker　id='created_at_gteq' value-format="yyyy-MM-dd" v-model="query.created_at_gteq" type="date" placeholder="作成日(以降)" style="width:100%"/>
        </el-col>
        <el-col :span="4">
          <el-date-picker id='created_at_lteq' value-format="yyyy-MM-dd" v-model="query.created_at_lteq" type="date" placeholder="作成日(以前)" style="width:100%"/>
        </el-col>
      </el-row>

      <el-row style="padding-top:10px">
        <el-button type="primary" native-type="submit" id='submit-btn'>サーチ</el-button>
        <el-button @click="onClear" type="default">クリア</el-button>
      </el-row>
    </el-form>
  </div>
</template>

<script lang="ts">
  import { Component, Prop, Vue, Emit } from "vue-property-decorator"
  import { Select, Option, Form, Col, Row, Button, Input, DatePicker } from 'element-ui'

  @Component({
    components: {
      "el-select": Select,
      "el-option": Option,
      "el-form": Form,
      "el-col": Col,
      "el-row": Row,
      "el-button": Button,
      "el-input": Input,
      "el-date-picker": DatePicker
    }
  })

  export default class Search extends Vue {
    @Prop() query!: Object

    @Emit('on-search')
    onSearch(): void { }

    @Emit('on-clear')
    onClear(): void { }
  }
</script>