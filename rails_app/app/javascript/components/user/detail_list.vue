<style scoped>
  .inline-header-block {
    display: inline-block;
    margin: 10px;
  }

  .aside-item {
    margin: 25px;
  }
</style>
<template>
  <div v-cloak>
    <el-container style="height: 700px; border: 1px solid #eee">
      <el-header style='font-size: 30px; margin: 15px;'>
        <div class="inline-header-block">
          {{ detail_info[0]["user_name"] }}さん
        </div>
        <div class="inline-header-block">
          <!-- 記事投稿モーダル -->
          <div v-if="this.login_user_id === this.detail_info[0]['user_id']">
            <article-create-button :user_id="detail_info[0].user_id" @on-reload="onReload"></article-create-button>
          </div>
        </div>
      </el-header>
      <el-container>
        <el-aside width="300px" style="border: 1px solid #eee">
          <table>
            <div class="aside-item">
              <tr>
                <th>登録日 : </th>
                <td> {{ this.format_datatime(detail_info[0]["user_created_at"]) }}</td>
              </tr>
            </div>
            <div class="aside-item">
              <tr>
                <th>投稿数 : </th>
                <td> {{ this.count }} 件</td>
              </tr>
            </div>

            <!-- ユーザー編集モーダル -->
            <div v-if="this.login_user_id === this.detail_info[0]['user_id']">
              <user-edit-button :info="detail_info[0]" @on-update-data="onReload"></user-edit-button>
            </div>
          </table>
        </el-aside>
        
        <el-table :data="detail_info" max-height="700" border style="width:100%">
          <el-table-column prop="title" :min-width="80" label="タイトル(最新10県表示)" sortable>
            <template slot-scope="scope">
              <a @click="open_article_detail_page(scope.row.article_id)" class="all-item-link">
                {{scope.row.title}}
              </a>
            </template>
          </el-table-column>
          <el-table-column prop="article_created_at" :min-width="25" label="投稿日" :formatter="table_format_datatime" sortable/>
        </el-table>
      </el-container>
    </el-container>
  </div>
</template>

<script lang="ts">
  import { Header, Main, Container, Aside, Button, Table, TableColumn } from 'element-ui';
  import { Component, Prop, Vue, Emit } from "vue-property-decorator";
  import ArticleCreateButton from '../../components/article/create_btn.vue';
  import UserEditButton from '../../components/user/edit_btn.vue';
  import formatter from "../../libs/formatter";
  import table_formatter from "../../libs/table_formatter";

  @Component({
    components: {
      "el-header": Header,
      "el-main": Main,
      "el-aside": Aside,
      "el-container": Container,
      "el-button": Button,
      "el-table": Table,
      "el-table-column": TableColumn,
      "article-create-button": ArticleCreateButton,
      "user-edit-button": UserEditButton
    },
  })

  export default class DetailList extends Vue {
    @Prop() detail_info!: Object[]
    @Prop() login_user_id!: Number
    @Prop() count!: Number

    private format_datatime:(d:string) => string = formatter.datetime
    private table_format_datatime:(r: any, c:any, d:any) => string = table_formatter.datetime

    open_article_detail_page(article_id: number): void {
      window.open( '/article_details?article_id=' + article_id)
    }

    @Emit('on-reload')
    onReload(): void{}
  }
</script>