import Vue from "vue/dist/vue.esm";
import lang from 'element-ui/lib/locale/lang/ja'
import locale from 'element-ui/lib/locale'
import List from "../components/demo_list/list.vue";
import http from '../libs/http.ts'
import param_maker from '../libs/param_maker.ts'

locale.use(lang)
type Parameter = { [s: string]: any };

new Vue({
  el: "#demo-list",

  components: {
    "list": List
  },  

  data: {
    info: <Object[]>[],
    q: <Object>{},
    limit: <Number>0,
    offset: <Number>0,
    mounted: false
  },

  created: function(): void { 
    this.fetchList()  
  },

  methods: {
    fetchList: function(){
      const url = '/demo_lists/get'
      const params = param_maker.get({
          q: this.query,
          offset: this.offset,
          limit: this.limit
      })
      http.fetch(url, params,)
          .then((res) => {this.successFetch(res) })
    },

    successFetch: function(res: Parameter){
      this.info = res.data.info;
      this.mounted = true
    },
  }
});