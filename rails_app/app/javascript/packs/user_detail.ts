import Vue from 'vue/dist/vue.esm';
import lang from 'element-ui/lib/locale/lang/ja';
import locale from 'element-ui/lib/locale';
import http from '../libs/http.ts';
import error_notification from '../libs/error_notification.ts';
import { Loading } from 'element-ui';
import List from '../components/user/detail_list.vue';
import param_maker from '../libs/param_maker.ts';

locale.use(lang)
type Parameter = { [s: string]: any };

new Vue({
  el: '#user-detail',

  components: {
    "list": List
  },

  data: {
    user_id: <Number>0,
    detail_info: <Object[]>[],
    count: <Number>0,
    mounted: <Boolean>false,
  },

  mounted: function () {
    this.user_id = document.getElementById("user_id").getAttribute('data');
    this.fetchDetail(this.user_id)
  },

  methods:{
    fetchDetail: function(user_id){
      let loading = Loading.service({ text: "Loading..." });
      const url = '/user_details/get'
      const params = param_maker.get({ 
        user_id: user_id
      })
      
      http.fetch(url, params)
          .then(this.successFetch)
          .catch(this.errorFetch)
          .finally(() => { loading.close() });
    },

    successFetch: function(res: Parameter): void{
      this.detail_info = res.data.info;
      this.count = res.data.count;
      this.mounted = true
    },

    errorFetch: function(err: Parameter): void{
      error_notification.to_slack({
        file_name: "user_detail.ts",
        function_name: "fetchDetail()",
        error: err
      });
    },

    onReload: function(): void{
      this.fetchDetail(this.user_id)
    },
  }
})