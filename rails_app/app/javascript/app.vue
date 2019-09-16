<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>

<template>
  <div id="app">
    <el-table :data="message" size="mini" max-height="700" border style="width:100%">
      <el-table-column prop="hello" label="Hello" sortable></el-table-column>
    </el-table>
  </div>
</template>

<script lang="ts">
import { Table, TableColumn } from 'element-ui'

export default {
  components: {
    'el-table': Table,
    'el-table-column': TableColumn,
  },

  data: function () {
    return {
      message: [{hello: "Hello Vue!"}]
    }
  }
}
</script>
