<template lang="pug">
  q-layout(view="lHh lpr lFf" container)
    q-header(bordered)#header
      q-toolbar
        q-input(outlined dense clearable v-model.lazy="searchParams.query" class="col")
          template(v-slot:append='')
            q-btn(dense flat round icon="ion-search" @click="search")
    q-page-container
      q-page.q-gutter-x-md.q-gutter-y-md#cards-container
        q-inner-loading(:showing="loading")
          q-spinner-tail(size="8em" color="primary")
        q-card(v-for="image in images" v-bind:key="image.id" class="image-card")
          q-img(:src="image.thumb1xUrl" :ratio="1")
            q-badge(floating transparent color="red" v-if="image.assignment")
              q-icon(name="ion-alert" size="1rem")
    q-footer(bordered)#footer
      q-toolbar.q-gutter-x-md
        q-pagination(v-model="searchParams.page" :max-pages="10" :max="99"
          :boundary-numbers="false")
        q-select(dense v-model="searchParams.per_page" :options="per_page_options" outlined
          filled bg-color="primary" dark options-dense)
        q-space
        p {{total}} 1231
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
        per_page_options: [5, 10, 15, 20, 25, 50],
        loading: false,
        total: 0
      }
    },
    computed: {},
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
        this.total = 0

        await this.$errorHandle(this, this.searchRequest)
      },
      async searchRequest() {
        const { data: result } = await this.axios({
          method: 'GET',
          url: `v1/photos`,
          params: this.searchParams,
        })

        this.images = result.photos
        this.total = result.total
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
  }
</style>
