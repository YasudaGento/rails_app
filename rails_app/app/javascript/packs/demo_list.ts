import Vue from "vue/dist/vue.esm";
import lang from 'element-ui/lib/locale/lang/ja'
import locale from 'element-ui/lib/locale'
import List from "../components/demo_list/list.vue";
import axios from 'axios'
import Qs from "qs";

locale.use(lang)

new Vue({
  el: "#demo-list",

  components: {
    "list": List
  },  

  data: {
    info: <Object[]>[{name: "yasuda"}],
    q: <Object>{},
    limit: <Number>0,
    offset: <Number>0
  },

  created: function(): void { 
    const url = '/demo_lists/get'
    const params = this.qs({
        q: this.query,
        offset: this.offset,
        limit: this.limit
    })
    axios.get(url, params,)
         .then((res) => { console.log("yes") })
   },

  methods: {
    qs: function(params){
      return  {
           params,
           paramsSerializer: function (params) { return Qs.stringify(params, { arrayFormat: 'brackets' }); }
       }
    },
  }
});