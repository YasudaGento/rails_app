import Vue from 'vue/dist/vue.esm';
import lang from 'element-ui/lib/locale/lang/ja';
import locale from 'element-ui/lib/locale';
import List from '../components/user/list.vue';
import Search from '../components/user/search.vue';
import Pagination from '../components/ui/pagination_btn.vue';
import http from '../libs/http.ts';
import param_maker from '../libs/param_maker.ts';
import error_notification from '../libs/error_notification.ts';
import { Loading } from 'element-ui';

locale.use(lang)
type Parameter = { [s: string]: any };

new Vue({
  el: "#user-list",

  components: {
    "list": List,
    "search": Search,
    "pagination-btn": Pagination
  },  

  data: {
    info: <Object[]>[],
    limit: <Number>30,
    offset: <Number>0,
    count: <Number>0,
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
          .finally(() => { loading.close() });
    },

    successFetch: function(res: Parameter): void{
      this.info = res.data.info;
      this.count = res.data.count;
      this.mounted = true
    },

    errorFetch: function(err: Parameter): void{
      error_notification.to_slack({
        file_name: "user.js",
        function_name: "fetchList()",
        error: err
      });
    },

    onSearch: function(): void{
      this.offset = 0
      this.fetchList();
    },

    onClear: function(): void{
      this.offset = 0
      this.query = {}
      this.fetchList();
    },

    prevClick: function(): void{
      this.offset = this.offset - this.limit
      this.fetchList();
    },

    nextClick: function(): void{
      this.offset = this.offset + this.limit
      this.fetchList();
    },

    currentChange: function(index: number): void{
      const i = index - 1
      this.offset = i * 30

      this.fetchList();
    }
  }
});