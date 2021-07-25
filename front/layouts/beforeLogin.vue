<template>
  <v-app>
    <bef-login-app-bar />
    <v-main>
      <nuxt />
    </v-main>
    <bef-login-footer />
  </v-app>
</template>

<script>
import BefLoginAppBar from '../components/beforeLogin/befLoginAppBar.vue'
import BefLoginFooter from '../components/beforeLogin/befLoginFooter.vue'

export default {
  components: {
    BefLoginAppBar,
    BefLoginFooter
  }
}
</script>
