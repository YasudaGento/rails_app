<style scoped>
</style>
<template>
  <div v-cloak>
    <el-table :data="info" max-height="700" border style="width:100%">
      <el-table-column prop="user_name" :min-width="15" label="投稿者" sortable/>
      <el-table-column prop="title" :min-width="70" label="タイトル" sortable>
        <template slot-scope="scope">
          <a @click="open_detail_page(scope.row.article_id)" class="all-item-link">
            {{scope.row.title}}
          </a>
        </template>
      </el-table-column>
      <el-table-column prop="created_at" :min-width="15" label="作成日" :formatter="format_datatime" sortable/>
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

    open_detail_page(article_id: number): void {
      window.open( '/article_details?article_id=' + article_id)
    }
  }
</script>