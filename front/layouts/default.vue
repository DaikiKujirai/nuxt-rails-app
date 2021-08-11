<template>
  <v-app>
    <wel-app-bar />
    <nuxt />
    <bef-login-footer />
  </v-app>
</template>

<script>
import befLoginFooter from '../components/beforeLogin/befLoginFooter.vue'
import welAppBar from '../components/welcome/welAppBar.vue'
export default {
  components: {
    befLoginFooter,
    welAppBar
  }
}
</script>
