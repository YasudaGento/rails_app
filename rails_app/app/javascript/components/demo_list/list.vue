<style scoped>
</style>
<template>
  <div v-cloak>
    <el-table :data="info" max-height="700" border style="width:100%">
      <el-table-column prop="name" label="名前" sortable></el-table-column>
      <el-table-column prop="id" label="ID" sortable></el-table-column>
      <el-table-column prop="created_at" label="日付" sortable></el-table-column>
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