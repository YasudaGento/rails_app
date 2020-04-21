<style scoped>
</style>
<template>
  <div v-cloak>
    <el-container style="height: 700px; border: 1px solid #eee">
      <el-header style='font-size: 40px; text-align:center;'>{{ detail_info["title"] }}</el-header>
      <el-main style="border: 1px solid #eee">{{ detail_info["content"] }}</el-main>
    </el-container>
  </div>
</template>

<script lang="ts">
  import { Header, Main, Container } from 'element-ui'
  import { Component, Prop, Vue, Emit } from "vue-property-decorator"

  @Component({
    components: {
      "el-header": Header,
      "el-main": Main,
      "el-container": Container
    },
  })

  export default class List extends Vue {
    @Prop() detail_info!: Object[]
  }
</script>