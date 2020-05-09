<template>
  <div>
    <edit v-if="modal_status"
          :info="info"
          @on-reload="onReload"
          @on-close="closeModal">
    </edit>

    <el-button size="mini" @click="openModal()" style="margin: 15px; width:50% " type="primary" id="edit-btn"> ユーザー編集 <i class="el-icon-user"></i> </el-button>
  </div>
</template>

<script lang="ts">
  import { Button } from 'element-ui';
  import { Component, Prop, Vue, Emit } from "vue-property-decorator";
  import Edit from '../../components/user/edit.vue';

  @Component({
    components: {
      "el-button": Button,
      "edit": Edit
    },
  })

  export default class EditBtn extends Vue {
    @Prop() info!: Object
    private modal_status: boolean = false

    openModal(): void {
      this.modal_status = true
    }

    closeModal(): void{
      this.modal_status = false
    }

    @Emit('on-update-data')
    onReload(): void{ }
  }
</script>