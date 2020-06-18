<template>
  <div>
    <create v-if="modal_status"
            @on-close="closeModal">
    </create>

    <el-button size="mini" @click="openModal()" style="margin: 30px 0px;" type="default" id="create-btn"> 新規登録 <i class="el-icon-user"></i> </el-button>
  </div>
</template>

<script lang="ts">
  import { Button } from 'element-ui';
  import { Component, Prop, Vue, Emit } from "vue-property-decorator";
  import Create from '../../components/user/create.vue';

  @Component({
    components: {
      "el-button": Button,
      "create": Create
    },
  })

  export default class CreateBtn extends Vue {
    private modal_status: boolean = false

    openModal(): void {
      this.modal_status = true
    }

    closeModal(): void{
      this.modal_status = false
    }
  }
</script>