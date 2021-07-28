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
    <v-toolbar-items>
      <v-btn
        v-for="(menu, i) in menus"
        :key="`menu-btn-${i}`"
        text
        rounded
        class="mr-2"
        :to="`/${menu.title}`"
      >
        {{ $t(`menus.${menu.title}`) }}
      </v-btn>
    </v-toolbar-items>
    <signup-link />
    <login-link />
    <modal-new-post />
    <v-app-bar-nav-icon />
  </v-app-bar>
</template>

<script>
import appLogo from '../appLogo.vue'
import appTitle from '~/components/ui/apptitle'
import signupLink from '~/components/beforeLogin/signupLink'
import loginLink from '~/components/beforeLogin/loginLink'
import modalNewPost from '~/components/posts/modalNewPost.vue'

export default {
  components: {
    appLogo,
    appTitle,
    signupLink,
    loginLink,
    modalNewPost
  },
  props: {
    imgHeight: {
      type: Number,
      default: 0
    }
  },
  data ({ $store }) {
    return {
      dialog: false,
      menus: [
        { title: 'users' },
        { title: 'posts' },
        { title: 'myPage' }
      ]
      // appBarHeight: $store.state.styles.beforeLogin.appBarHeight
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
