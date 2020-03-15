import Vue from "vue/dist/vue.esm";
import lang from 'element-ui/lib/locale/lang/ja';
import locale from 'element-ui/lib/locale';
import List from "../components/user/list.vue";
import Search from "../components/user/search.vue";
import http from '../libs/http.ts';
import param_maker from '../libs/param_maker.ts';
import error_notification from '../libs/error_notification.ts';
import { Loading } from "element-ui";

locale.use(lang)
type Parameter = { [s: string]: any };

new Vue({
  el: "#user-list",

  components: {
    "list": List,
    "search": Search
  },  

  data: {
    info: <Object[]>[],
    limit: <Number>0,
    offset: <Number>0,
    mounted: <Boolean>false,
    query: <Object>{}
  },

  created: function(): void { 
    this.fetchList()  
  },

  methods: {
    fetchList: function(): void{
      let loading = Loading.service({ text: "Loading..." });
      const url = '/users/get'
      const params = param_maker.get({
        offset: this.offset,
        limit: this.limit,
        q: this.query
      })
      http.fetch(url, params,)
          .then(this.successFetch)
          .catch(this.errorFetch)
          .finally(loading.close());
    },

    successFetch: function(res: Parameter): void{
      this.info = res.data.info;
      this.mounted = true
    },

    errorFetch: function(err: Parameter): void{
      error_notification.to_slack({
        file_name: "contact.js",
        function_name: "onRead()",
        error: err
      });
    },

    onSearch: function(): void{
      this.fetchList();
    },

    onClear: function(): void{
      this.query = {}
      this.fetchList();
    },
  }
});