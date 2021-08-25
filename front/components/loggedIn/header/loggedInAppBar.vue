<template>
  <v-app-bar
    app
    dark
    hide-on-scroll
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
    <new-post />
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
import appLogo from '../../ui/appLogo.vue'
import newPost from '../../post/newPost.vue'
import appTitle from '../../ui/appTitle.vue'
import Breadcrumbs from '../ui/breadcrumbs.vue'
import accountLink from './accountLink.vue'

export default {
  components: {
    appLogo,
    appTitle,
    newPost,
    accountLink,
    Breadcrumbs
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
