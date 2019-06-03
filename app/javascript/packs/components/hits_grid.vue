<template lang='pug'>
  Card(:dis-hover='true' id='card')
    p(slot='title') HITs
    Button(slot='extra' size='default' icon='md-refresh-circle' @click='refresh'
      type='text' shape='circle' class='refresh-card-button')
    Form(:labelWidth='50', inline)
      FormItem(:labelWidth='0')
        Button(type='primary' size='small' icon='md-add' shape='circle'
          @click='setFormVisible(true)')
      FormItem(:labelWidth='0')
        Button(type='success', size='small' icon='md-create' shape='circle'
          @click='setFormVisible(true)')
    Table(border :columns='table.columns' :data='table.data' @on-row-click='selectRow'
      highlight-row max-height='600' :loading='loading')
    Drawer(title='Create HIT' v-model='formVisible' placement='left' width='500')
      HITCreateForm(v-on:hitsCreated='refresh')
</template>

<script>
  import HITCreateForm from './hit_create_form'

  export default {
    components: { HITCreateForm },
    data() {
      return {
        table: {
          data: [],
          columns: [],
        },
        loading: false,
        formVisible: false,
        styles: {
          // height: 'calc(100% - 100px)',
          // overflow: 'auto',
          // paddingBottom: '53px',
          // position: 'static'
        },
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

        const { hits, next_token, max_amount } = result

        this.table.data = hits
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
          title: 'Title',
          key: 'title',
          sortable: true,
        },
        {
          title: 'Status',
          key: 'hit_status',
          width: 100,
          sortable: true,
        },
        {
          title: 'Reward',
          key: 'reward',
          width: 100,
          sortable: true,
        },
        {
          title: 'Creation time',
          key: 'creation_time',
          width: 200,
          sortable: true,
        },
        {
          title: 'Id',
          key: 'hit_id',
          width: 270,
          sortable: true,
        },
      ]

      this.refresh()
    },
  }
</script>

<style scoped>

</style>
