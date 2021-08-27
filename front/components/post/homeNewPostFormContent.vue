<template>
  <v-textarea
    v-model="setContent"
    label="いまなにしてる？"
    auto-grow
    counter="140"
    :placeholder="form.placeholder"
    :rules="rules"
    class="mx-3"
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
  }
}
</script>
