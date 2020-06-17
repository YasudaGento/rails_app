<template>
  <transition name="modal">
    <div class="modal modal-mask" style="display:block; z-index:1000; overflow-y:scroll;">
      <div class="modal-dialog" role="document" style="width:70%; heigth: 80%;">
        <div class="modal-content modal-wrapper">
          <div class="modal-header">
            <h3 slot="header" class="modal-title">
              ユーザー登録フォーム
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
              <label class="required">ユーザー名</label>
              <el-input placeholder="ユーザー名を入力してください" id="user_name" v-model="form['user_name']"></el-input>
            </div>
          </div>

          <div class="modal-body">
            <div class="field">
              <label class="required">メールアドレス</label>
              <el-input placeholder="メールアドレスを入力してください" id="create-email" v-model="form['email']"></el-input>
            </div>
          </div>

          <div class="modal-body">
            <div class="field">
              <label class="required">パスワード</label>
              <el-input placeholder="変更時のみパスワードを入力してください" id="create-password" v-model="form['password']"></el-input>
            </div>
          </div>

          <div class="modal-body">
            <div class="field">
              <label class="required">パスワード確認用</label>
              <el-input placeholder="確認のため再度入力してください" id="confirm_password" v-model="confirm_password"></el-input>
            </div>
          </div>

          <div class="modal-footer">
             <div v-if="errors && errors.length !== 0" class="error">
              <h4>エラー内容を確認の上、再入力してください。</h4>
              <ul>
                <li v-for="e in errors" :key="e">{{ e }}</li>
              </ul>
            </div>
            <el-button type="primary" id="submit-btn" @click="onSubmit">登録</el-button>
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

  export default class UserCreate extends Vue {
    private modal_status: boolean = false
    private errors: String[] = []
    private form: Object = {
      user_name: null,
      email: null,
      password: "",
    }
    private confirm_password: String = ""

    created(): void{
      modal_back.lock();
    }

    onSubmit(): void {
      if(this.invalid_password()){ 
        this.errors = []
        this.errors.push("パスワードが一致していません")
        return
      }

      const params = {
        user: {
          name: this.form["user_name"],
          email: this.form["email"],
          password: this.form["password"]
        }
      }

      http.post('/users/create', params)        
        .then(this.successFetch)        
        .catch(this.errorFetch);   
    }

    successFetch(): void{
      this.onClose();
      this.notice_success();
    }

    notice_success() :void{
      Notification.success({
        title: "登録完了", 
        message: "ユーザー情報を登録しました。", 
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
          file_name: "user/create.vue",
          function_name: "onSubmit()",
          error: err
        });
      }
    }

    invalid_password(): boolean{
      if(this.form["password"] === ""){ return false}
      return this.form["password"] !== this.confirm_password
    }

    @Emit('on-close')
    onClose(): void {
      modal_back.unlock();
    }
  }
</script>