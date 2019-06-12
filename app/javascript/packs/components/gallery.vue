<template lang="pug">
  q-layout(view="lHh lpr lFf" container)
    q-header(bordered)#header
      q-toolbar
        q-checkbox(v-model='searchParams.showAssignments' dense label="Выполненные задания"
          id="show-assignments" class="black-text")
        q-input(outlined dense clearable v-model.lazy="searchParams.query" class="col")
          template(v-slot:append='')
            q-btn(dense flat round icon="ion-search" @click="search")
    q-page-container
      q-page.q-gutter-x-md.q-gutter-y-md#cards-container
        q-inner-loading(:showing="loading")
          q-spinner-tail(size="8em" color="primary")
        q-card(v-for="image in images" v-bind:key="image.id" class="image-card")
          q-img(:src="image.thumb1xUrl" :ratio="1")
            div(class="absolute-top-right bg-red rounded-borders" v-if="image.assignment"
              @click="setFormVisible(true)")
              q-icon(name="ion-alert" size="1.2rem")
    q-footer(bordered)#footer
      q-toolbar.q-gutter-x-md
        q-pagination(v-model="searchParams.page" :max-pages="10" :max="99"
          :boundary-numbers="false")
        q-select(dense v-model="searchParams.perPage" :options="perPageOptions" outlined
          filled bg-color="primary" dark options-dense)
        q-space
        p.black-text Всего: {{total}}
    q-dialog(v-model="formVisible" position="right")
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
          perPage: 3,
          showAssignments: true,
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
      async setFormVisible(value = false) {
        console.log(value)

      }
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

  #show-assignments {
    width: 180px;
  }

  #cards-container {
    margin: 0;
  }

  .black-text {
    color: rgba(0, 0, 0, 0.87);
  }

  .image-card {
    width: 200px;
    height: 200px;
    float: left;
  }
</style>
