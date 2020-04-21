import Vue from 'vue/dist/vue.esm';
import lang from 'element-ui/lib/locale/lang/ja';
import locale from 'element-ui/lib/locale';
import http from '../libs/http.ts';
import error_notification from '../libs/error_notification.ts';
import { Loading } from 'element-ui';
import List from '../components/article/detail_list.vue';
import param_maker from '../libs/param_maker.ts';

locale.use(lang)
type Parameter = { [s: string]: any };

new Vue({
  el: '#article-detail',

  components: {
    "list": List
  },

  data: {
    article_id: <Number>0,
    detail_info: <Object>{},
    mounted: <Boolean>false,
  },

  mounted: function () {
    this.article_id = document.getElementById("article_id").getAttribute('data');
    this.fetchDetail(this.article_id)
  },

  methods:{
    fetchDetail: function(article_id){
      let loading = Loading.service({ text: "Loading..." });
      const url = '/article_details/get'
      const params = param_maker.get({ 
        article_id: article_id
      })
      
      http.fetch(url, params)
          .then(this.successFetch)
          .catch(this.errorFetch)
          .finally(() => { loading.close() });
    },

    successFetch: function(res: Parameter): void{
      this.detail_info = res.data.info;
      this.mounted = true
    },

    errorFetch: function(err: Parameter): void{
      error_notification.to_slack({
        file_name: "article_detail.ts",
        function_name: "fetchDetail()",
        error: err
      });
    }
      
  }
})