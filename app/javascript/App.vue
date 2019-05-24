<template lang="pug">
  #app
    p {{ message }}
</template>

<script>
  export default {
    data: function () {
      return {
        message: "Hello Vue!123",
      }
    },
  }
</script>

<style>
  @import 'packs/styles/layout.css';
  @import 'packs/styles/card.css';
  @import 'packs/styles/form.css';
  @import 'packs/styles/table.css';

  #tabs-admin .ivu-tabs-nav {
    padding: 0 5px !important;
  }

  .ivu-tabs-tab-disabled {
    visibility: hidden;
  }

  .ivu-tabs-bar {
    height: 35px;
  }
</style>
