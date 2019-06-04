<template lang='pug'>
  div
    q-btn(round color="secondary" icon="ion-add-circle")
    q-table(dense :data="table.items" :columns="table.fields")
    //b-table(hover :items="table.items" :fields="table.fields")

  //Card(:dis-hover='true' id='card')
    p(slot='title') HITs
    Button(slot='extra' size='default' icon='md-refresh-circle' @click='refresh'
      type='text' shape='circle' class='refresh-card-button')
    Form(inline)
      FormItem(:labelWidth='0')
        Button(type='primary' size='small' icon='md-add' shape='circle'
          @click='setFormVisible(true)')
      FormItem(:labelWidth='0')
        Button(type='success', size='small' icon='md-create' shape='circle'
          @click='setFormVisible(true)')
    Table(border :columns='table.columns' :data='table.data' @on-row-click='selectRow'
      highlight-row :loading='loading')#table
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
          items: [],
          fields: [],
        },
        loading: false,
        formVisible: false,
      }
    },
    computed: {},
    watch: {},
    methods: {
      async refresh() {
        this.table.items = []

        this.setFormVisible(false)
        await this.reloadTable()
        // await this.$errorHandle(this, this.reloadTable)
      },
      async reloadTable() {
        const { data: result } = await this.axios({
          method: 'GET',
          url: `v1/hits`,
        })

        const { hits, next_token, max_amount } = result

        this.table.items = hits
      },
      selectRow(row) {
        //   this.manager.id = row.id
      },
      setFormVisible(value = true) {
        this.formVisible = value
      },
    },
    created() {
      this.table.fields = [
        {
          label: 'Title',
          name: 'title',
          field: 'title',
          sortable: true,
        },
        // {
        //   label: 'Status',
        //   key: 'hit_status',
        //   width: 100,
        //   sortable: true,
        // },
        // {
        //   key: 'reward',
        //   width: 100,
        //   sortable: true,
        // },
        // {
        //   key: 'creation_time',
        //   width: 200,
        //   sortable: true,
        // },
        // {
        //   title: 'Id',
        //   key: 'hit_id',
        //   width: 270,
        //   sortable: true,
        // },
      ]

      this.refresh()
    },
  }
</script>

<style scoped>
</style>
