<template>
  <v-textarea
    v-model="setContent"
    label="内容"
    :placeholder="form.placeholder"
    :rules="rules"
    auto-grow
    outlined
  />
</template>

<script>
export default {
  props: {
    content: {
      type: String,
      required: true
    }
  },
  data () {
    return {
      rules: [
        v => !!v || '内容を入力してください'
      ]
    }
  },
  computed: {
    form () {
      const placeholder = this.noValidation ? undefined : 'コンテンツ'
      return { placeholder }
    },
    setContent: {
      get () { return this.content },
      set (newVal) { return this.$emit('update:content', newVal) }
    }
  }
}
</script>
