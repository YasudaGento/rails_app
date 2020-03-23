<style scoped>
</style>
<template>
  <div v-cloak>
    <el-table :data="info" max-height="700" border style="width:100%">
      <el-table-column prop="user_name" :min-width="15" label="投稿者" sortable/>
      <el-table-column prop="title" :min-width="70" label="タイトル" sortable/>
      <el-table-column prop="created_at" :min-width="15" label="作成日" sortable/>
    </el-table>
  </div>
</template>

<script lang="ts">
  import { Table, TableColumn } from 'element-ui'
  import { Component, Prop, Vue, Emit } from "vue-property-decorator"

  @Component({
    components: {
      "el-table": Table,
      "el-table-column": TableColumn
    },
  })

  export default class List extends Vue {
    @Prop() info!: Object[]
  }
</script>