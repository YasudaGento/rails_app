<template>
  <div id="app">
    <el-table :data="message" size="mini" max-height="700" border style="width:100%">
      <el-table-column prop="name" label="Hello" sortable></el-table-column>
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
    }
  })

export default class List extends Vue {
  @Prop() message!: Object[]

  created(): void{
    console.log(this.message)
  }
}
</script>