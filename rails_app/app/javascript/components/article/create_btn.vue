<template>
  <div>
    <create v-if="modal_status"
            :user_id="user_id"
            @on-reload="onReload"
            @on-close="closeModal">
    </create>

    <el-button size="mini" @click="openModal()" style="margin: 20px; width:100% " type="success" id="create-btn"> 新しい記事を書く <i class="el-icon-edit"></i> </el-button>
  </div>
</template>

<script lang="ts">
  import { Button } from 'element-ui';
  import { Component, Prop, Vue, Emit } from "vue-property-decorator";
  import Create from '../../components/article/create.vue';

  @Component({
    components: {
      "el-button": Button,
      "create": Create
    },
  })

  export default class CreateBtn extends Vue {
    @Prop() user_id!: Number
    private modal_status: boolean = false

    openModal(): void {
      this.modal_status = true
    }

    closeModal(): void{
      this.modal_status = false
    }

    @Emit('on-reload')
    onReload(): void{}
  }
</script>