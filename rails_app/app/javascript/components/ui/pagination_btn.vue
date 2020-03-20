<style scoped>
  .pagination-btn{
    margin: 10px;
  }
</style>

<template>
  <div class='pagination-btn'>
    <el-pagination background 
                   layout="prev, pager, next" 
                   :total="count"
                   :page-size='30'
                   @current-change="currentChange"
                   @prev-click="prevClick"
                   @next-click="nextClick"/>
  </div>
</template>

<script lang="ts">
  import { Pagination } from 'element-ui'
  import { Component, Prop, Vue, Emit } from "vue-property-decorator"

  @Component({
    components: {
      "el-pagination": Pagination
    },
  })

  export default class List extends Vue {
    @Prop() count!: number
    @Prop() limit!: number
    @Prop() offset!: number

    private currentChange(index: any): void{
      this.$emit('current-change', index)
    }

    @Emit('prev-click')
    private prevClick(): void{ } 

    @Emit('next-click')
    private nextClick(): void{ }
  }
</script>