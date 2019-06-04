<template lang="pug">
  #app
    HitsGrid
    //Layout(style="height: 100vh; margin:'20px'")
      Sider(collapsible)
      Content
        HitsGrid
</template>

<script>
  import HitsGrid from './packs/components/hits_grid'

  export default {
    components: { HitsGrid },
    data() {
      return {}
    },
    async created() {
      this.axios.defaults.baseURL = `${ location.origin }/api`
      this.axios.defaults.headers.common['Content-Type'] = 'application/json'
      this.axios.defaults.headers.common['Accept'] = 'application/json'
    },
  }
</script>

<style>
  /*@import 'packs/styles/layout.css';*/
  @import 'packs/styles/card.css';
  @import 'packs/styles/form.css';
  @import 'packs/styles/table.css';

  /*#app {*/
  /*  height: 100vh;*/
  /*}*/

  .drawer-footer {
    width: 100%;
    position: absolute;
    bottom: 0;
    left: 0;
    border-top: 1px solid #e8e8e8;
    padding: 10px 16px;
    text-align: right;
    background: #fff;
  }
</style>
