<template>
  <v-app-bar
    app
    dark
    hide-on-scroll
    clipped-left
  >
    <app-logo />
    <v-toolbar-title>
      {{ appName }}
    </v-toolbar-title>
    <v-spacer />
    <v-toolbar-items>
      <v-btn
        v-for="(menu, i) in menus"
        :key="`menu-btn-${i}`"
        text
        rounded
        class="mr-2"
        to="/users"
      >
        {{ $t(`menus.${menu.title}`) }}
      </v-btn>
    </v-toolbar-items>
    <signup-link />
    <login-link />
    <v-btn
      rounded
      color="info"
      class="open-modal-btn"
      @click="dialog = true"
    >
      +
    </v-btn>
    <v-dialog
      v-model="dialog"
      width="500"
    >
      <v-card>
        <!-- eslint-disable-next-line vue/no-lone-template -->
        <div class="d-flex">
          <v-card-title>
            新規登録
          </v-card-title>
          <v-spacer />
          <v-icon
            size="30"
            class="mr-5"
            @click="dialog = false"
          >
            ✖︎
          </v-icon>
        </div>
        <v-textarea />
        <v-btn
          color="info"
          @click="dialog = false"
        >
          ボタン
        </v-btn>
      </v-card>
    </v-dialog>
    <v-app-bar-nav-icon />
  </v-app-bar>
</template>

<script>
import AppLogo from '../appLogo.vue'
import signupLink from '~/components/beforeLogin/signupLink'
import loginLink from '~/components/beforeLogin/loginLink'

export default {
  components: {
    AppLogo,
    signupLink,
    loginLink
  },
  props: {
    imgHeight: {
      type: Number,
      default: 0
    }
  },
  data ({ $config: { appName } }) {
    return {
      appName,
      dialog: false,
      menus: [
        { title: 'users' },
        { title: 'posts' },
        { title: 'myPage' }
      ]
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
