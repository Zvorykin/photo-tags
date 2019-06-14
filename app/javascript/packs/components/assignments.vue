<template lang="pug">
  q-layout(view="lHh lpr lFf" container)
    q-header(bordered).header
      q-toolbar
        q-btn(round color='primary' icon="ion-refresh" @click="debouncedRefresh")
    q-page-container
      q-page.q-gutter-x-md.q-gutter-y-md.row.cards-container
        q-inner-loading(:showing="loading")
          q-spinner-tail(size="6em" color="primary")
        PhotoCard(v-for="photo in photos" :key="photo.id + photo.assignment_id"
          v-bind="formatPhotoProps(photo)" @assignmentSubmitted="onAssignmentSubmitted")
    q-footer(bordered).footer
      q-toolbar.q-gutter-x-md
        q-select(dense v-model="refreshParams.perPage" :options="perPageOptions" outlined
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
        refreshParams: {
          perPage: 10,
        },
        perPageOptions: [5, 10, 15, 20, 25, 50],
        loading: false,
        total: 0,
      }
    },
    computed: {},
    watch: {
      refreshParams: {
        handler() {
          this.debouncedRefresh()
        },
        deep: true,
      },
    },
    methods: {
      async refresh() {
        this.photos = []

        await this.$errorHandle(this, this.refreshRequest)
      },
      async refreshRequest() {
        const { data: result } = await this.axios({
          method: 'GET',
          url: `v1/assignments_to_review`,
          params: this.refreshParams,
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
          tags: photo.tags.map(tag => tag.title),
          assignmentId: photo.assignment_id,
          assignmentTags: photo.assignment_tags,
        }
      },
      onAssignmentSubmitted({ id, assignmentId }) {
        this.photos = this.photos.filter(photo => {
          return !(photo.assignment_id === assignmentId && photo.id === id)
        })
      },
    },
    async created() {
      this.debouncedRefresh = this.$debounce(this.refresh, 1000)
      this.refresh()
    },
  }
</script>

<style scoped>

</style>

