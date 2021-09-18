<template>
  <v-textarea
    v-model="setContent"
    label="いまなにしてる？"
    :rules="rules"
    auto-grow
    class="mx-3"
    @keypress.enter.shift.exact="submitPost"
  />
</template>

<script>
export default {
  props: {
    content: {
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
    setContent: {
      get () { return this.content },
      set (newVal) { return this.$emit('update:content', newVal) }
    }
  },
  methods: {
    submitPost () {
      this.$emit('submitPost')
    }
  }
}
</script>
