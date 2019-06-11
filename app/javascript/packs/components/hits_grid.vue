<template lang='pug'>
  div
    q-table(title='HITs' dense flat :data="table.data" :columns="table.columns"
      :pagination.sync="table.pagination" :loading="loading" class="sticky-table"
      separator="vertical")
      template(v-slot:top="")
        q-btn(dense color="primary" icon="ion-add-circle" label="Создать"
          @click='setFormVisible(true)')
        q-space
        q-btn(dense flat round icon="ion-refresh" @click="refresh")
    q-dialog(v-model="formVisible" position="left")
      HITCreateForm(v-on:hitsCreated='refresh')
</template>

<script>
  import HITCreateForm from './hit_create_form'

  export default {
    components: { HITCreateForm },
    data() {
      return {
        table: {
          pagination: {
            sortBy: 'created_at',
            descending: true,
            page: 1,
            rowsPerPage: 0
          },
          data: [],
          columns: [],
        },
        loading: false,
        formVisible: false,
      }
    },
    computed: {},
    watch: {},
    methods: {
      async refresh() {
        this.table.data = []

        this.setFormVisible(false)
        await this.$errorHandle(this, this.reloadTable)
      },
      async reloadTable() {
        const { data: result } = await this.axios({
          method: 'GET',
          url: `v1/hits`,
        })

        this.table.data = result.hits
      },
      selectRow(row) {
        //   this.manager.id = row.id
      },
      setFormVisible(value = true) {
        this.formVisible = value
      },
    },
    created() {
      this.table.columns = [
        {
          label: 'Заголовок',
          name: 'title',
          field: 'title',
          sortable: true,
          align: 'left',
        },
        {
          label: 'Статус',
          name: 'status',
          field: 'status',
          sortable: true,
        },
        {
          label: 'Вознаграждение',
          name: 'reward',
          field: 'reward',
          sortable: true,
        },
        {
          label: 'Время создания',
          name: 'created_at',
          field: 'created_at',
          sortable: true,
        },
        {
          label: 'Размещение истекает',
          name: 'expiration_at',
          field: 'expiration_at',
          sortable: true,
        },
        {
          label: 'MTurk id',
          name: 'mturk_id',
          field: 'mturk_id',
          sortable: true,
        },
      ]

      this.refresh()
    },
  }
</script>

<style lang="stylus">
  .sticky-table
    .q-table__middle
      height calc(100% - 107px)

    .q-table__top,
    .q-table__bottom,
    thead tr:first-child th
      background-color #f6f6f6

    thead tr:first-child th
      position sticky
      top 0
      opacity 1
      z-index 1
</style>
