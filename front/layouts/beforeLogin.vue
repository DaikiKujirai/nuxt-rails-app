<template>
  <v-app>
    <wel-app-bar />
    <v-main>
      <flash />
      <nuxt />
    </v-main>
    <bef-login-footer />
  </v-app>
</template>

<script>
import befLoginFooter from '../components/beforeLogin/befLoginFooter.vue'
import flash from '../components/ui/flash.vue'
import WelAppBar from '../components/welcome/welAppBar.vue'

export default {
  components: {
    befLoginFooter,
    flash,
    WelAppBar
  }
}
</script>
