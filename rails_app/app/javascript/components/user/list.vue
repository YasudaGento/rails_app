<style scoped>
</style>
<template>
  <div v-cloak>
    <el-table :data="info" max-height="700" border style="width:100%">
      <el-table-column prop="user_name" :min-width="80" label="ユーザー名" sortable>
        <template slot-scope="scope">
          <a @click="open_detail_page(scope.row.user_id)" class="all-item-link">
            {{scope.row.user_name}}
          </a>
        </template>
      </el-table-column>
      <el-table-column prop="created_at" :min-width="20" label="登録日" :formatter="format_datatime" sortable/>
    </el-table>
  </div>
</template>

<script lang="ts">
  import { Table, TableColumn } from "element-ui";
  import { Component, Prop, Vue, Emit } from "vue-property-decorator";
  import table_formatter from "../../libs/table_formatter";

  @Component({
    components: {
      "el-table": Table,
      "el-table-column": TableColumn
    },
  })

  export default class List extends Vue {
    @Prop() info!: Object[]

    private format_datatime:(r: any, c:any, d:any) => string = table_formatter.datetime

    open_detail_page(user_id: number): void {
      window.open( '/user_details?user_id=' + user_id)
    }
  }
</script>