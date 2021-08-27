<template>
  <layout-main #layout-main> <!--eslint-disable-line-->
    <v-main
      justify="center"
      align="center"
    >
      ロード中
    </v-main>
  </layout-main>
</template>

<script>
import layoutMain from '../components/layout/loggedIn/layoutMain.vue'

export default {
  components: {
    layoutMain
  },
  data () {
    return {
      loading: true
    }
  },
  computed: {
  },
  created () {
    this.$router.push('/posts')
  },
  methods: {
  }
}
</script>
