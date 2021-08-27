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
    <breadcrumbs
      v-if="notTopPage"
    />
    <v-spacer />
    <btn-new-post />
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
import Breadcrumbs from '../ui/breadcrumbs.vue'
import AccountLink from './accountLink.vue'
import BtnNewPost from '~/components/btn/newPost/btnNewPost.vue'

export default {
  components: {
    AppLogo,
    AppTitle,
    AccountLink,
    Breadcrumbs,
    BtnNewPost
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
