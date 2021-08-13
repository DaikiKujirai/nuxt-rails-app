<template>
  <v-app>
    <template v-if="!isAuthenticated">
      <wel-app-bar />
    </template>
    <template v-else>
      <logged-in-app-bar />
    </template>
    <v-main>
      <nuxt />
    </v-main>
    <bef-login-footer />
  </v-app>
</template>

<script>
import { mapGetters } from 'vuex'
import befLoginFooter from '../components/beforeLogin/befLoginFooter.vue'
import LoggedInAppBar from '../components/loggedIn/header/loggedInAppBar.vue'
import welAppBar from '../components/welcome/welAppBar.vue'

export default {
  components: {
    befLoginFooter,
    welAppBar,
    LoggedInAppBar
  },
  computed: {
    ...mapGetters({
      isAuthenticated: 'auth/isAuthenticated'
    })
  }
}
</script>
