<template>
  <v-app-bar
    app
    dark
  >
    <drawer-icon
      class="d-md-none"
      @toggleDrawer="toggleDrawer"
    />
    <app-logo />
    <app-title
      class="hidden-ipad-and-down"
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
import drawerIcon from './drawerIcon.vue'

export default {
  components: {
    AppLogo,
    AppTitle,
    AccountLink,
    drawerIcon
  },
  data () {
    return {
      drawer: false
    }
  },
  computed: {
    notTopPage () {
      return this.$route.name !== 'index'
    }
  },
  methods: {
    ...mapActions({
      logout: 'auth/logout',
      flashMessage: 'flash/flashMessage'
    }),
    signout () {
      this.logout()
        .then(() => {
          this.flashMessage({ message: 'ログアウトしました', type: 'primary', status: true })
        })
    },
    toggleDrawer () {
      this.$emit('toggleDrawer')
    }
  }

}
</script>
