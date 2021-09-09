<template>
  <v-textarea
    v-model="setIntroduction"
    :rules="rules"
    :counter="max"
    label="紹介文を入力"
    auto-grow
    outlined
  />
</template>

<script>
export default {
  props: {
    introduction: {
      type: String,
      default: ''
    }
  },
  data () {
    const max = 500
    return {
      max,
      rules: [
        v => !!v || '',
        v => (!!v && max >= v.length) || `${max}文字以内で入力してください`
      ]
    }
  },
  computed: {
    setIntroduction: {
      get () { return this.introduction },
      set (newVal) { return this.$emit('update:introduction', newVal) }
    }
  }
}
</script>
