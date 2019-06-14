<template lang="pug">
  q-card.image-card.row
    q-img(:src="srcThumb" :ratio="1").img
      q-tooltip
        q-img(:src="srcPreview").preview.fixed-center
    q-card-section.col.no-padding
      div.text-h6.on-right {{`${title || ''} (${filename})`}}
      q-chip(v-for="tag of tags" :key="tag" outline) {{tag}}
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
    },
    data() {
      return {}
    },
    computed: {},
    watch: {},
    methods: {}
  }
</script>

<style scoped>
  .preview {
    max-width: 700px;
  }

  .img {
    width: 200px;
  }

  .image-card {
    /*max-width: 1200px;*/
    /*height: 200px;*/
    float: left;
    margin-right: 15px;
    width: 98%;
  }
</style>
