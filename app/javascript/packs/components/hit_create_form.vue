<template lang='pug'>
  q-card(class="q-pa-md" id='card')
    div(class="q-gutter-y-md column")
      q-input(v-model="formData.title" label="Title" outlined)
      q-input(v-model="formData.description" label="Description" outlined type="textarea"
        autogrow)
      q-input(v-model="formData.reward" input-class="text-right" outlined
        prefix="$" mask="#.##" fill-mask="0"
        label="Reward" style="max-width: 100px")
      div(class="q-gutter-x-md row")
        q-input(v-model.number="formData.assignmentDuration" label="Assignment duration"
          outlined type="number")
        q-input(v-model.number="formData.lifetime" label="Lifetime"
          outlined type="number")
      div(class="justify-end row")
        q-btn(color="primary" @click='submit') Create
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
