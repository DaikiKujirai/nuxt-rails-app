<template>
  <v-text-field
    v-model="setPasswordConfirmation"
    :rules="form.rules"
    :counter="!noValidation"
    :hint="form.hint"
    label="パスワード確認用"
    :placeholder="form.placeholder"
    :hide-details="noValidation"
    :append-icon="toggle.icon"
    :type="toggle.type"
    outlined
    autocomplete="on"
    @click:append="show = !show"
  />
</template>

<script>
export default {
  props: {
    passwordConfirmation: {
      type: String,
      default: ''
    },
    noValidation: {
      type: Boolean,
      default: false
    }
  },
  data () {
    return {
      show: false
    }
  },
  computed: {
    setPasswordConfirmation: {
      get () { return this.password_confirmation },
      set (newVal) { return this.$emit('update:password_confirmation', newVal) }
    },
    form () {
      const min = '8文字以上'
      const msg = `${min}。半角英数字・ﾊｲﾌﾝ・ｱﾝﾀﾞｰﾊﾞｰが使えます`
      const required = v => !!v || ''
      const format = v => /^[\w-]{8,72}$/.test(v) || msg

      const rules = this.noValidation ? [required] : [format]
      const hint = this.noValidation ? undefined : msg
      const placeholder = this.noValidation ? undefined : min
      return { rules, hint, placeholder }
    },
    toggle () {
      const icon = this.show ? 'mdi-eye' : 'mdi-eye-off'
      const type = this.show ? 'text' : 'password'
      return { icon, type }
    }
  }
}
</script>
