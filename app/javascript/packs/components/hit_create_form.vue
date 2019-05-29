<template lang='pug'>
  div
    Form(:model='formData' label-position='top')
      Split(v-model='splitValue')
        div(slot='left').left
          Row
            FormItem(label='Title')
              Input(v-model='formData.title')
          Row
            FormItem(label='Description')
              Input(v-model='formData.description' type='textarea')
          Row
            FormItem(label='Reward')
              InputNumber(:max='100' :min='1' v-model='formData.reward' :step='0.2')
          Row
            FormItem(label='Assignment duration')
              Input(v-model='formData.assignmentDuration')
          Row
            FormItem(label='Lifetime')
              Input(v-model='formData.lifetime')
          Row(type='flex' justify='end')
            FormItem
              Button(@click='submit' type='primary') Submit
        div(slot='right').right
          FormItem(label='Question')
            Input(v-model='formData.question' type='textarea' :rows='10')
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
          assignmentDuration: 300,
          lifetime: 300,
          question: '',
        },
      }
    },
    computed: {},
    watch: {},
    methods: {
      async submit() {
        const { data: result } = await this.axios({
          method: 'POST',
          url: `v1/hits`,
          data: this.formData,
        })

        return result
      },
    },
  }
</script>

<style scoped>
  .left {
    margin-right: 10px;
  }

  .right {
    margin-left: 15px;
  }
</style>
