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
    <btn-change-theme />
  </v-app-bar>
</template>

<script>
import appLogo from '../ui/appLogo.vue'
import BtnChangeTheme from '../loggedIn/header/btnChangeTheme.vue'
import appTitle from '~/components/ui/appTitle'
import signupLink from '~/components/beforeLogin/signupLink'
import loginLink from '~/components/beforeLogin/loginLink'

export default {
  components: {
    appLogo,
    appTitle,
    signupLink,
    loginLink,
    BtnChangeTheme
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
