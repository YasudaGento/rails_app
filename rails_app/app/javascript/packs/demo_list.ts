import Vue from "vue/dist/vue.esm";
import lang from 'element-ui/lib/locale/lang/ja'
import locale from 'element-ui/lib/locale'
import List from "../components/demo_list/list.vue";

locale.use(lang)

new Vue({
  el: "#demo-list",

  components: {
    "list": List
  },  

  data: {
    info: <Object[]>[{name: "yasuda"}],
  },

  created: function(): void { this.get_info() },

  methods: {
    get_info: function(): void {
      console.log(this.info)
    }
  }
});