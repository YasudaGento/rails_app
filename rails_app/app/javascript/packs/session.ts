import Vue from 'vue/dist/vue.esm';
import lang from 'element-ui/lib/locale/lang/ja';
import locale from 'element-ui/lib/locale';
import UserCreateButton from '../components/user/create_btn.vue';

locale.use(lang)

new Vue({
  el: '#session',

  components: {
    "user-create-button": UserCreateButton
  }
})