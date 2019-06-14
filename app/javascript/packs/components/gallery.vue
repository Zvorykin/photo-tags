<template lang="pug">
  q-layout(view="lHh lpr lFf" container)
    q-header(bordered).header
      q-toolbar
        q-input(outlined dense clearable v-model.lazy="searchParams.query").col
          template(v-slot:append='')
            q-btn(dense flat round icon="ion-search" @click="search")
    q-page-container
      q-page.q-gutter-x-md.q-gutter-y-md.row.cards-container
        q-inner-loading(:showing="loading")
          q-spinner-tail(size="6em" color="primary")
        PhotoCard(v-for="photo in photos" :key="photo.id" v-bind="formatPhotoProps(photo)")
    q-footer(bordered).footer
      q-toolbar.q-gutter-x-md
        q-pagination(v-model="searchParams.page" :max-pages="10" :max="99"
          :boundary-numbers="false")
        q-select(dense v-model="searchParams.perPage" :options="perPageOptions" outlined
          bg-color="primary" dark options-dense)
        q-space
        q-field(borderless dense)
          div.self-center Всего: {{total}}
</template>

<script>
  import PhotoCard from './photo_card'

  export default {
    components: { PhotoCard },
    data() {
      return {
        photos: [],
        searchParams: {
          query: 'sunset',
          page: 1,
          perPage: 10,
        },
        perPageOptions: [5, 10, 15, 20, 25, 50],
        loading: false,
        total: 0,
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
        this.photos = []

        await this.$errorHandle(this, this.searchRequest)
      },
      async searchRequest() {
        const { data: result } = await this.axios({
          method: 'GET',
          url: `v1/photos`,
          params: this.searchParams,
        })

        this.photos = result.photos
        this.total = result.total
      },
      formatPhotoProps(photo) {
        return {
          srcPreview: photo.preview1xUrl,
          srcThumb: photo.thumb1xUrl,
          id: photo.id,
          filename: photo.filename,
          title: photo.title,
          tags:  photo.tags.map(tag => tag.title)
        }
      },
    },
    async created() {
      this.debouncedSearch = this.$debounce(this.search, 500)
      this.search()
    },
  }
</script>

<style scoped>

</style>
