<template lang='pug'>
  q-layout(view='hHh lpR fFf')#app
    q-drawer(v-model='showDrawer' side='left' :width='100' behavior='desktop' bordered)
      q-tabs(v-model='tab' vertical)
        q-tab(name='hits' label='Задания' icon='ion-grid')
        q-tab(name='gallery' label='Галерея' icon='ion-images')
        q-tab(name='tags' label='Теги' icon='ion-pricetags')
        q-tab(name='login' label='Логин' icon='ion-log-in')
    q-page-container
      q-page
        q-tab-panels(v-model='tab' keep-alive)#tab-panels
          q-tab-panel(name='hits')
            HitsGrid
          q-tab-panel(name='gallery')
            Gallery
          q-tab-panel(name='tags')
          q-tab-panel(name='login')
            temp

        //router-view
</template>

<script>
  import HitsGrid from './packs/components/hits_grid'
  import Gallery from './packs/components/gallery'
  import temp from './packs/components/gallery'

  export default {
    components: { HitsGrid, Gallery, temp },
    data() {
      return {
        tab: 'gallery',
        showDrawer: true,
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
