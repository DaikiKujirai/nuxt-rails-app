<template>
  <v-text-field
    v-model="setTitle"
    label="タイトル"
    :placeholder="form.placeholder"
    :rules="rules"
    outlined
  />
</template>

<script>
export default {
  props: {
    title: {
      type: String,
      default: 'デフォルト'
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
      get () {
        return this.title
      },
      set (newVal) {
        return this.$emit('update:title', newVal)
      }
    }
  },
  methods: {
  }
}
</script>
