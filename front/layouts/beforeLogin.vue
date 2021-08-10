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
import befLoginAppBar from '../components/beforeLogin/befLoginAppBar.vue'
import befLoginFooter from '../components/beforeLogin/befLoginFooter.vue'

export default {
  components: {
    befLoginAppBar,
    befLoginFooter
  }
}
</script>
