<template lang="pug">
  q-layout(view="lHh lpr lFf" container)
    q-header(bordered)#header
      q-toolbar
        q-input(outlined dense clearable v-model.lazy="searchParams.query" class="col")
          template(v-slot:append='')
            q-icon(name="ion-search")
    q-page-container
      q-page.q-gutter-x-md.q-gutter-y-md#cards-container
        q-card(v-for="image in images" v-bind:key="image.id" class="image-card")
          q-img(:src="image.thumb1xUrl" :ratio="1")
    q-footer(bordered)#footer
      q-toolbar
        q-pagination(v-model="searchParams.page" :max="10")
</template>

<script>
  export default {
    components: {},
    data() {
      return {
        images: [],
        searchParams: {
          query: 'cats',
          page: 1,
          per_page: 3,
        },
      }
    },
    computed: { },
    watch: {
      searchParams: {
        handler() {
          this.debouncedSearch()
        },
        deep: true,
      },
    },
    methods: {
      async search() {
        this.images = []

        await this.$errorHandle(this, this.searchRequest)
      },
      async searchRequest() {
        const { data: result } = await this.axios({
          method: 'GET',
          url: `v1/photos`,
          params: this.searchParams,
        })

        this.images = result
      },
    },
    async created() {
      this.debouncedSearch = this.$debounce(this.search, 500)
      this.search()
    },
  }
</script>

<style scoped>
  #footer, #header {
    background: white;
  }

  #cards-container {
    margin: 0;
  }

  .image-card {
    width: 200px;
    height: 200px;
    float: left;
    /*margin: 16px 16px 0 0;*/
  }


</style>
