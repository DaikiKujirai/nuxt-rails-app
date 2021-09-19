<template>
  <v-textarea
    v-model="setMessage"
    :rules="rules"
    rows="1"
    label="メッセージを入力"
    auto-grow
    outlined
    hide-details="false"
    dense
    rounded
    @keypress.enter.shift.exact="sendMessage"
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
  },
  methods: {
    sendMessage () {
      this.$emit('sendMessage')
    }
  }
}
</script>
