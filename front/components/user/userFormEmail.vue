<template>
  <v-text-field
    v-model="setEmail"
    :rules="rules"
    label="メールアドレスを入力"
    :placeholder="form.placeholder"
    :outlined="outlined"
  />
</template>

<script>
export default {
  props: {
    email: {
      type: String,
      default: ''
    },
    noValidation: {
      type: Boolean,
      default: false
    },
    outlined: {
      type: Boolean,
      required: true
    }
  },
  data () {
    return {
      rules: [
        v => !!v || '',
        v => /.+@.+\..+/.test(v) || ''
      ]
    }
  },
  computed: {
    setEmail: {
      get () { return this.email },
      set (newVal) { return this.$emit('update:email', newVal) }
    },
    form () {
      const placeholder = this.noValidation ? undefined : 'your@email.com'
      return { placeholder }
    }
  }
}
</script>
