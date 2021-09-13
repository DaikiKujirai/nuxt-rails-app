<template>
  <v-textarea
    v-model="setMessage"
    :rules="rules"
    label="メッセージを入力"
    auto-grow
    outlined
    dense
    rounded
  />
</template>

<script>
export default {
  props: {
    message: {
      type: String,
      default: ''
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
      const placeholder = this.noValidation ? undefined : 'いまなにしてる？'
      return { placeholder }
    },
    setMessage: {
      get () { return this.message },
      set (newVal) { return this.$emit('update:message', newVal) }
    }
  }
}
</script>
