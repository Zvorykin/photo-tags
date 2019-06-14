<template lang="pug">
  q-layout(view="lHh lpr lFf" container)
    q-header(bordered)#header
      q-toolbar
        q-input(outlined dense clearable v-model.lazy="searchParams.query").col
          template(v-slot:append='')
            q-btn(dense flat round icon="ion-search" @click="search")
    q-page-container
      q-page.q-gutter-x-md.q-gutter-y-md.row#cards-container
        q-inner-loading(:showing="loading")
          q-spinner-tail(size="6em" color="primary")
        GalleryImageCard(v-for="image in images" :key="image.id"
          v-bind="formatImageProps(image)")
    q-footer(bordered)#footer
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
  import AssignmentForm from './assignment_form'
  import GalleryImageCard from './image_card'

  export default {
    components: { AssignmentForm, GalleryImageCard },
    data() {
      return {
        images: [],
        imageProps: {},
        searchParams: {
          query: 'sunset',
          page: 1,
          perPage: 10,
        },
        formVisible: false,
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
        this.images = []

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
      formatImageProps(image) {
        return {
          srcPreview: image.preview1xUrl,
          srcThumb: image.thumb1xUrl,
          id: image.id,
          filename: image.filename,
          title: image.title,
          tags:  image.tags.map(tag => tag.title)
        }
      },
      // async processAssignment(image) {
      //   if (image.assignment) {
      //     this.imageProps = {
      //       src: image.preview1xUrl,
      //       imageId: image.id,
      //       imageTags: image.tags.map(tag => tag.title),
      //       assignmentId: image.assignment.assignment_id,
      //       assignmentTags: image.assignment.tags,
      //     }
      //     this.setFormVisible(true)
      //   }
      // },
      async setFormVisible(value = false) {
        this.formVisible = value
      },
      onAssignmentSubmitted() {
        this.setFormVisible(false)

        this.images = this.images.filter(image => {
          if (image.assignment && image.assignment.assignment_id) {
            return !(image.assignment.assignment_id === this.imageProps.assignmentId
              && image.id === this.imageProps.imageId)
          }
          return true
        })
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
    padding-bottom: 15px;
  }

  .black-text {
    color: rgba(0, 0, 0, 0.87);
  }
</style>
