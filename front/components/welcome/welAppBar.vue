<template>
  <v-app-bar
    app
    dark
  >
    <app-logo
      :to="'/posts'"
    />
    <app-title
      class="hidden-mobile-and-down"
    />
    <v-spacer />
    <signup-link />
    <login-link />
    <v-app-bar-nav-icon />
  </v-app-bar>
</template>

<script>
import appLogo from '../ui/appLogo.vue'
import appTitle from '~/components/ui/appTitle'
import signupLink from '~/components/beforeLogin/signupLink'
import loginLink from '~/components/beforeLogin/loginLink'

export default {
  components: {
    appLogo,
    appTitle,
    signupLink,
    loginLink
  },
  data () {
    return {
      dialog: false
    }
  },
  methods: {
    goTo (id) {
      this.$vuetify.goTo(`#${id}`)
    }
  }
}
</script>
