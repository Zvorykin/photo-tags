<template lang='pug'>
  q-layout(view='hHh lpR fFf')#app
    q-drawer(v-model='left' side='left' :width='100' behavior='desktop' bordered)
      q-tabs(v-model='tab' vertical)
        q-tab(name='hits' label='HITs' icon='ion-grid')
        q-tab(name='gallery' label='Gallery' icon='ion-images')
        q-tab(name='tags' label='Tags' icon='ion-pricetags')
        q-tab(name='login' label='Login' icon='ion-log-in')
    q-page-container
      q-page
        q-tab-panels(v-model='tab' keep-alive)#tab-panels
          q-tab-panel(name='hits')
            HitsGrid
          q-tab-panel(name='gallery')
          q-tab-panel(name='tags')
          q-tab-panel(name='login')
            HITCreateForm

        //router-view
    //HitsGrid
</template>

<script>
  import HitsGrid from './packs/components/hits_grid'

  import HITCreateForm from './packs/components/hit_create_form'

  export default {
    components: { HitsGrid, HITCreateForm },
    data() {
      return {
        tab: 'login',
        left: true,
      }
    },
    async created() {
      this.axios.defaults.baseURL = `${ location.origin }/api`
      this.axios.defaults.headers.common['Content-Type'] = 'application/json'
      this.axios.defaults.headers.common['Accept'] = 'application/json'
    },
  }
</script>

<style>
  #tab-panels .q-tab-panel {
    padding: 0 0 1px 0;
  }
</style>
