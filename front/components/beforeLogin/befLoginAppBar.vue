<template>
  <v-app-bar
    app
    color="white"
  >
    <nuxt-link
      to="/"
      class="text-decoration-none"
    >
      <app-logo />
    </nuxt-link>
    <app-title
      class="hidden-mobile-and-down"
    />
    <v-spacer />
    <signup-link />
    <login-link />
  </v-app-bar>
</template>

<script>
import appLogo from '../appLogo.vue'
import appTitle from '../ui/appTitle.vue'
import signupLink from './signupLink.vue'
import loginLink from './loginLink.vue'

export default {
  components: {
    appLogo,
    appTitle,
    signupLink,
    loginLink
  },
  data ({ $store }) {
    return {
    }
  }
}
</script>
