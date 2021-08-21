<template>
  <v-main
    justify="center"
    align="center"
  >
    ページが見つかりませんでした。
  </v-main>
</template>

<script>
export default {
  data () {

  },
  created () {
    this.toTop()
  },
  methods: {
    toTop () {
      this.$router.replace('/posts')
    }
  }
}
</script>
