<template lang='pug'>
  Form(:model='formData' label-position='top')
    Row
      FormItem(label='Title')
        Input(v-model='formData.title')
    Row
      FormItem(label='Description')
        Input(v-model='formData.description' type='textarea')
    Row
      FormItem(label='Reward')
        InputNumber(:max='100' :min='1' :step='0.2' v-model='formData.reward' )
    Row
      FormItem(label='Assignment duration')
        Input(v-model='formData.assignmentDuration')
    Row
      FormItem(label='Lifetime')
        Input(v-model='formData.lifetime')
    Row(type='flex' justify='end')
      FormItem
        Button(@click='submit' type='primary') Submit
</template>

<script>
  export default {
    data() {
      return {
        splitValue: 0.3,
        formData: {
          title: '',
          description: '',
          reward: 1,
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
      },
      async createHITs() {
        const { data: result } = await this.axios({
          method: 'POST',
          url: `v1/hits`,
          data: this.formData,
        })

        this.$emit('hitsCreated')

        return result
      }
    },
  }
</script>

<style scoped>

</style>
