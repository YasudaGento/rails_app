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
        <el-col :span="3">
          <el-input id='user_name' v-model="query.name_cont" placeholder="ユーザー名" />
        </el-col>
      </el-row>
      <el-row style="padding-top:10px">
        <el-button type="primary" native-type="submit">サーチ</el-button>
        <el-button @click="onClear" type="default">クリア</el-button>
      </el-row>
    </el-form>
  </div>
</template>

<script lang="ts">
  import { Component, Prop, Vue, Emit } from "vue-property-decorator"
  import { Select, Option, Form, Col, Row, Button, Input } from 'element-ui'

  @Component({
    components: {
      "el-select": Select,
      "el-option": Option,
      "el-form": Form,
      "el-col": Col,
      "el-row": Row,
      "el-button": Button,
      "el-input": Input
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