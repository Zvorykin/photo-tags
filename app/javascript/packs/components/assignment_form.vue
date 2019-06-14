<template lang="pug">
  q-card.col-12
    q-splitter(v-model="splitterValue")
      template(v-slot:before="")
        q-card-section
          q-img(:src="src" :ratio="1")
      template(v-slot:separator="")
        q-icon(flat round name="ion-code")
      template(v-slot:after="")
        q-card-section
          div.text-h6 Теги изображения
          q-separator
          q-chip(v-for="tag of imageTags" :key="tag" :color="isMarked(assignmentTags, tag)"
            outline) {{tag}}
        q-card-section
          div.text-h6 Новые теги
          q-separator
          q-chip(v-for="tag of assignmentTags" :key="tag" @click='disableTag(tag)' clickable
          :disabled="isDisabled(tag)" :color="isMarked(imageTags, tag)" outline) {{tag}}
        q-card-actions.justify-between
          q-btn(@click="submitAssignment(false)" color="negative" outline).col-5 Отклонить
          q-btn(@click="submitAssignment(true)" color="positive" outline).col-5 Принять
</template>

<script>
  export default {
    components: {},
    props: {
      src: {
        type: String,
        required: true,
      },
      imageId: {
        type: String,
        required: true,
      },
      assignmentId: {
        type: String,
        required: true,
      },
      imageTags: {
        type: Array,
        required: true,
      },
      assignmentTags: {
        type: Array,
        required: true,
      },
    },
    data() {
      return {
        splitterValue: 50,
        disabledTags: [],
      }
    },
    computed: {
      newTags() {
        return this.assignmentTags.filter(item => !this.disabledTags.includes(item))
      },
    },
    watch: {},
    methods: {
      disableTag(value) {
        if (this.isDisabled(value)) {
          this.disabledTags = this.disabledTags.filter(tag => tag !== value)
        } else {
          this.disabledTags.push(value)
        }
      },
      isDisabled(value) {
        return this.disabledTags.includes(value)
      },
      isMarked(tags, value) {
        return tags.includes(value) ? 'orange' : undefined
      },
      async submitAssignment(applied) {
        const cb = () => this.axios({
          method: 'PUT',
          url: `v1/assignments/${this.assignmentId}/results`,
          data: {
            imageId: this.imageId,
            tags: [...new Set(this.imageTags.concat(this.newTags))],
            applied
          }
        })

        await this.$errorHandle(this, cb)
        this.$emit('assignmentSubmitted')
      },
    },
  }
</script>

<style scoped>

</style>
