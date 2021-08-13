<template>
  <v-app-bar
    app
    dark
    hide-on-scroll
    clipped-left
  >
    <app-logo />
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
  props: {
    imgHeight: {
      type: Number,
      default: 0
    }
  },
  data ({ $store }) {
    return {
      dialog: false
    }
  },
  mounted () {
  },
  beforeDestroy () {
  },
  methods: {
    goTo (id) {
      this.$vuetify.goTo(`#${id}`)
    }
  }
}
</script>
