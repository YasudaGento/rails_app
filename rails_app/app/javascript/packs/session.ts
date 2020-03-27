import Vue from 'vue/dist/vue.esm';
import SignIn from '../components/session/sign_in.vue';


new Vue({
  el: "#sign-in",

  components: {
    "sign-in": SignIn,
  }
});