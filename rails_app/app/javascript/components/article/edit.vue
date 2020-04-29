<template>
  <transition name="modal">
    <div v-if="loaded" class="modal modal-mask" style="display:block; z-index:1000; overflow-y:scroll;">
      <div class="modal-dialog" role="document" style="width:70%; heigth: 80%;">
        <div class="modal-content modal-wrapper">
          <div class="modal-header">
            <h3 slot="header" class="modal-title">
              記事編集フォーム
              <button
                type="button"
                class="close"
                data-dismiss="modal"
                aria-label="Close"
                @click="onClose" >
                <span aria-hidden="true">&times;</span>
              </button>
            </h3>
          </div>

          <div class="modal-body">
            <div class="field">
              <label class="required">タイトル</label>
              <el-input placeholder="タイトルを入力してください" id="title" v-model="form['title']"></el-input>
            </div>
          </div>

          <div class="modal-body">
            <div class="field">
              <label class="required">記事欄</label>
              <el-input type="textarea" placeholder="記事を入力してください" id="content" v-model="form['content']" :autosize='{ minRows: 50, maxRows: 300}'></el-input>
            </div>
          </div>

          <div class="modal-footer">
             <div v-if="errors && errors.length !== 0" class="error">
              <h4>エラー内容を確認の上、再入力してください。</h4>
              <ul>
                <li v-for="e in errors" :key="e">{{ e }}</li>
              </ul>
            </div>
            <el-button type="primary" id="submit-btn" @click="onSubmit">編集</el-button>
            <el-button type="plain" @click="onClose">閉じる</el-button>
          </div>
        </div>
      </div>
    </div>
  </transition>
</template>

<script lang="ts">
  import { Button, Input, Notification } from 'element-ui';
  import { Component, Prop, Vue, Emit } from "vue-property-decorator";
  import error_notification from "../../libs/error_notification";
  import modal_back from "../../libs/modal_back";
  import http from "../../libs/http";
  type Parameter = { [s: string]: any };

  @Component({
    components: {
      "el-button": Button,
      "el-input": Input
    },
  })

  export default class EditButton extends Vue {
    @Prop() info!: Object
    private modal_status: boolean = false
    private loaded: boolean = false
    private errors: String[] = []
    private form: Object = {
      title: null,
      content: null
    }

    created(): void{
      this.set_init_data(this.info)
    }

    set_init_data(info: Object): void{
      this.form["title"] = info["title"]
      this.form["content"] = info["content"]
      this.loaded = true
      modal_back.lock();
    }

    onSubmit(): void {
      const params = {
        article: {
          id: this.info["article_id"],
          title: this.form["title"],
          content: this.form["content"]
        }
      }

      http.post('/articles/update', params)        
        .then(this.successFetch)        
        .catch(this.errorFetch);   
    }

    successFetch(res: Parameter): void{
      this.onReload(res);
      this.onClose();
      this.notice_success();
    }

    notice_success() :void{
      Notification.success({
        title: "編集完了", 
        message: "記事を編集しました。", 
        type: "success",
        position: "top-left",
        offset: 100,
        duration: 2000
      });
    }

    errorFetch(err: Parameter): void{
      if (err.response.status === 422){ 
        this.errors = err.response.data.message 
      } else {
        this.errors = [ "原因不明のエラーが発生しました。開発者に連絡してください" ]
        // エラー通知
        error_notification.to_slack({
          file_name: "article/edit.vue",
          function_name: "onSubmit()",
          error: err
        });
      }
    }

    @Emit('on-close')
    onClose(): void {
      modal_back.unlock();
    }

    @Emit('on-reload')
    onReload(res: Parameter): Object{
      return res.data.changed
    }
  }
</script>