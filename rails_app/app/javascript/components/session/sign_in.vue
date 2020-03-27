<template>
  <div style="text-align: center; margin: 0 auto; width: 50%" v-cloak>
    <h1>ログイン</h1>
    <div class="modal-body">
      <div class="mail">
        <label class="required">mail</label>
        <el-input placeholder="メールアドレスを入力してください" id="mail" v-model="form['mail']"></el-input>
      </div>
    </div>

    <div class="modal-body">
      <div class="password">
        <label class="required">password</label>
        <el-input placeholder="パスワードを入力してください" id="password" v-model="form['password']"></el-input>
      </div>
    </div>

    <div class="modal-footer">
      <div v-if="error_message && error_message.length !== 0" class="error">
        <h4>エラー内容を確認の上、再入力してください。</h4>
        <ul>
          <li v-for="e in error_message" :key="e">{{ e }}</li>
        </ul>
      </div>
      <el-button type="primary" id="submit-btn" @click="sign_in">サインイン</el-button>
    </div>
  </div>
</template>

<script lang="ts">
  import error_notification from '../../libs/error_notification';
  import http from '../../libs/http';
  import param_maker from '../../libs/param_maker';
  import { Component, Prop, Vue } from "vue-property-decorator"
  import { Button, Form, Input } from 'element-ui'

  type Parameter = { [s: string]: any };

  @Component({
    components: {
      'el-button': Button,
      'el-form': Form,
      'el-input': Input
    }
  })

  export default class SignIn extends Vue {
    private error_message: String[] = []
    
    private form: Object = {
      passsword: null,
      mail: null
    }

    private sign_in(): void{
      const url = '/sessions/signin'
      const params = {
        user: {
          passsword: this.form["password"],
          mail: this.form["mail"]
        }
      }
      http.post(url, params)
          .then(this.successFetch)
          .catch(this.errorFetch)
    }

    private successFetch(res: Parameter): void{
      
    }

    private errorFetch(err: Parameter): void{
      this.error_message = err.data.massage
      error_notification.to_slack({
        file_name: "session.js",
        function_name: "sign_in()",
        error: err
      });
    }
  }
</script>