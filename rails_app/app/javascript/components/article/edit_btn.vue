<template>
  <div>
    <edit v-if="modal_status"
          :info="info"
          @on-reload="onReload"
          @on-close="closeModal">
    </edit>

    <el-button size="medium" @click="openModal()" style="margin: 20px; width:100% " type="success"> 編集 <i class="el-icon-edit"></i> </el-button>
  </div>
</template>

<script lang="ts">
  import { Button } from 'element-ui'
  import { Component, Prop, Vue, Emit } from "vue-property-decorator"
  import Edit from '../../components/article/edit.vue';

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
    onReload(data: Object): Object{
      return data
    }
  }
</script>