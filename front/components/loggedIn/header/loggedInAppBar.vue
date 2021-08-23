<template>
  <v-app-bar
    app
    dark
    hide-on-scroll
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
    <breadcrumbs
      v-if="notTopPage"
    />
    <v-spacer />
    <new-post />
    <account-link />
  </v-app-bar>
</template>

<script>
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
  }
}
</script>
