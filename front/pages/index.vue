<template>
  <layout-main #layout-main>　<!--eslint-disable-line-->
    ロード中
  </layout-main>
</template>

<script>
import layoutMain from '../components/layout/loggedIn/layoutMain.vue'

export default {
  components: {
    layoutMain
  }
  // beforeCreate () {
  //   this.$store.$router.push('/posts')
  // }
}
</script>
