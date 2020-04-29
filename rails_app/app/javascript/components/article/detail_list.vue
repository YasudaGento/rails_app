<style scoped>
  th {
    margin: 15px;
  }
</style>
<template>
  <div v-cloak>
    <el-container style="height: 700px; border: 1px solid #eee">
      <el-header style='font-size: 40px; text-align:center;'>{{ detail_info["title"] }}</el-header>
      <el-container>
        <el-aside width="300px" style="border: 1px solid #eee">
          <table>
            <!-- 記事編集モーダル -->
            <article-edit-button :info="detail_info" @on-update-data="onUpdateData"></article-edit-button>
            <tr>
              <th>投稿者 : </th>
              <td> {{ detail_info["user_name"] }}</td>
            </tr>
            <tr>
              <th>投稿数 : </th>
              <td> {{ detail_info["article_count"] }}</td>
            </tr>
            <tr>
              <th>投稿日 : </th>
              <td> {{ detail_info["created_at"] }}</td>
            </tr>
            <tr>
              <th>変更日 : </th>
              <td> {{ detail_info["updated_at"] }}</td>
            </tr>
          </table>
        </el-aside>

        <el-main style="border: 1px solid #eee">{{ detail_info["content"] }}</el-main>
      </el-container>
    </el-container>
  </div>
</template>

<script lang="ts">
  import { Header, Main, Container, Aside, Button } from 'element-ui';
  import { Component, Prop, Vue, Emit } from "vue-property-decorator";
  import ArticleEditButton from '../../components/article/edit_btn.vue';

  @Component({
    components: {
      "el-header": Header,
      "el-main": Main,
      "el-aside": Aside,
      "el-container": Container,
      "el-button": Button,
      "article-edit-button": ArticleEditButton
    },
  })

  export default class DetailList extends Vue {
    @Prop() detail_info!: Object

    onUpdateData(data: Object): void{
      // 編集後の値の更新
      this.detail_info["title"] = data["title"]
      this.detail_info["content"] = data["content"]
    }
  }
</script>