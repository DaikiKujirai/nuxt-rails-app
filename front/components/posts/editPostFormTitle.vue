<template>
  <v-text-field
    v-model="content"
    label="タイトル"
    placeholder="本のタイトル"
    :rules="rules"
    outlined
  />
</template>

<script>
export default {
  props: {
    title: {
      type: String,
      default: ''
    }
  },
  data () {
    return {
      content: '',
      rules: [
        v => !!v || 'タイトルを入力してください'
      ]
    }
  },
  computed: {
    form () {
      const placeholder = this.noValidation ? undefined : '本のタイトル'
      return { placeholder }
    },
    setTitle: {
      get () { return this.title },
      set (newVal) { return this.$emit('update:title', newVal) }
    }
  },
  methods: {
    
  }
}
</script>
