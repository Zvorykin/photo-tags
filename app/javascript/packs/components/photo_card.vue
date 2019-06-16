<template lang="pug">
  q-card.photo-card.row
    q-img(:src="srcThumb" :ratio="1").img.col-2
      q-tooltip
        q-img(:src="srcPreview").preview.fixed-center
    q-card-section.col
      p.text-h6.on-right.no-margin-bottom {{`${title || ''} (${filename})`}}
      q-chip(v-for="tag of tags" :key="tag" :color="isMarked(assignmentTags, tag)"
        outline) {{tag}}
      q-separator(spaced)
      // TODO: move to separate component
      div(v-if="assignmentId").row
        div.text-h6.on-right.no-margin-bottom Новые теги
        div.col
          q-chip(v-for="tag of assignmentTags" :key="tag" outline @click='disableTag(tag)'
            clickable :disabled="isDisabled(tag)" :color="isMarked(tags, tag)") {{tag}}
        q-space
        q-separator(vertical)
        div.buttons.q-gutter-y-md.q-pa-md
          q-btn(color="positive" :loading='loading' @click="submitAssignment(false)"
            outline).full-width Принять
          q-btn(color="negative" :loading='loading' @click="submitAssignment(false)"
            outline).full-width Отклонить
</template>

<script>
  export default {
    components: {},
    props: {
      srcPreview: {
        type: String,
        required: true,
      },
      srcThumb: {
        type: String,
        required: true,
      },
      id: {
        type: String,
        required: true,
      },
      title: {
        type: String,
        required: true,
      },
      filename: {
        type: String,
        required: true,
      },
      tags: {
        type: Array,
        required: true,
      },
      assignmentId: {
        type: String,
        default: null,
      },
      assignmentTags: {
        type: Array,
        default: () => [],
      },
    },
    data() {
      return {
        disabledTags: [],
        loading: false,
      }
    },
    computed: {},
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
        return tags.includes(value) ? 'positive' : undefined
      },
      async submitAssignment(applied) {
        const newTags = this.assignmentTags.filter(item => !this.disabledTags.includes(item))

        const cb = () => this.axios({
          method: 'PUT',
          url: `v1/assignments/${this.assignmentId}/results`,
          data: {
            photoId: this.id,
            tags: newTags,
            applied
          }
        })

        await this.$errorHandle(this, cb)

        this.$q.notify({
          color: 'secondary',
          position: 'top',
          message: 'Успешно выполнено!',
          timeout: 2000
        })

        const payload = {
          id: this.id,
          assignmentId: this.assignmentId
        }
        this.$emit('assignmentSubmitted', payload)
      },
    }
  }
</script>

<style scoped>
  .preview {
    max-width: 700px;
  }

  .img {
    min-width: 200px;
    height: 200px;
  }

  .buttons {
    width: 130px;
  }

  .no-margin-bottom {
    margin-bottom: 0;
  }

  .photo-card {
    /*max-width: 1200px;*/
    /*height: 200px;*/
    /*float: left;*/
    margin-right: 15px;
    width: 98%;
  }
</style>
