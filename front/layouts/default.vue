<template>
  <v-app>
    <template v-if="!isAuthenticated">
      <wel-app-bar />
    </template>
    <template v-else>
      <logged-in-app-bar />
    </template>
    <v-main>
      <flash />
      <nuxt />
    </v-main>
    <bef-login-footer />
  </v-app>
</template>

<script>
import { mapGetters } from 'vuex'
import befLoginFooter from '../components/beforeLogin/befLoginFooter.vue'
import loggedInAppBar from '../components/loggedIn/header/loggedInAppBar.vue'
import welAppBar from '../components/welcome/welAppBar.vue'
import flash from '../components/ui/flash.vue'

export default {
  components: {
    befLoginFooter,
    welAppBar,
    loggedInAppBar,
    flash
  },
  computed: {
    ...mapGetters({
      isAuthenticated: 'auth/isAuthenticated'
    })
  }
}
</script>
