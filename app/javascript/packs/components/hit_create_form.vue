<template lang='pug'>
  q-card(class="q-pa-md" id='card')
    div(class="q-gutter-y-md column")
      q-input(v-model="formData.title" label="Title" outlined)
      q-input(v-model="formData.description" label="Description" outlined type="textarea"
        autogrow)
      div(class="q-gutter-x-md row")
        q-input(v-model="formData.reward" input-class="text-right" outlined
          prefix="$" mask="#.##" fill-mask="0" label="Reward").col
        q-input(v-model.number="formData.maxAssignments" outlined
          label="Max assignments" type="number").col
      div(class="q-gutter-x-md row")
        q-input(v-model.number="formData.assignmentDuration" label="Assignment duration"
          outlined type="number").col
        q-input(v-model.number="formData.lifetime" label="Lifetime"
          outlined type="number").col
      div(class="justify-end row")
        q-btn(color="primary" @click='submit') Создать
</template>

<script>
  export default {
    data() {
      return {
        formData: {
          title: '',
          description: '',
          reward: '1.00',
          assignmentDuration: 600,
          lifetime: 600,
          maxAssignments: 1,
        },
      }
    },
    computed: {},
    watch: {},
    methods: {
      async submit() {
        await this.$errorHandle(this, this.createHITs)
        this.$emit('hitsCreated')
      },
      async createHITs() {
        await this.axios({
          method: 'POST',
          url: `v1/hits`,
          data: this.formData,
        })
      }
    },
  }
</script>

<style scoped>
  #card {
    height: 100%;
    width: 500px
  }
</style>
