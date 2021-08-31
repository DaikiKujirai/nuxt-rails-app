<template>
  <v-app-bar
    app
    dark
  >
    <nuxt-link
      to="/posts"
      class="text-decoration-none"
    >
      <app-logo />
    </nuxt-link>
    <app-title
      class="hidden-mobile-and-down"
    />
    <v-spacer />
    <v-btn
      @click="signout"
    >
      logout
    </v-btn>
    <account-link />
  </v-app-bar>
</template>

<script>
import { mapActions } from 'vuex'
import AppLogo from '../../ui/appLogo.vue'
import AppTitle from '../../ui/appTitle.vue'
import AccountLink from './accountLink.vue'

export default {
  components: {
    AppLogo,
    AppTitle,
    AccountLink
  },
  computed: {
    notTopPage () {
      return this.$route.name !== 'index'
    }
  },
  methods: {
    ...mapActions({
      logout: 'auth/logout'
    }),
    signout () {
      this.logout()
    }
  }

}
</script>
