<template>
  <v-app-bar
    app
    color="white"
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
    <v-menu
      app
      offset-x
      offset-y
      max-width="200"
    >
      <template v-slot:activator="{ on }"> <!--eslint-disable-line-->
        <v-btn
          icon
          v-on="on"
        >
          <v-icon>
            mdi-account-circle
          </v-icon>
        </v-btn>
      </template>
      <v-list>
        <v-subheader>
          ログイン中のユーザー
        </v-subheader>
        <v-list-item>
          <v-list-item-content>
            <v-list-item-subtitle>
              ユーザー名が表示されます
            </v-list-item-subtitle>
          </v-list-item-content>
        </v-list-item>
        <v-divider />
        <v-subheader>
          アカウント
        </v-subheader>
        <template v-for="(menu, i) in accountMenus">
          <v-divider
            v-if="menu.divider"
            :key="`menu-divider-${i}`"
          />
          <v-list-item
            :key="`menu-list-${i}`"
            :to="{ name: menu.name }"
          >
            <v-list-item-icon class="mr-2">
              <v-icon size="22" v-text="menu.icon" />
            </v-list-item-icon>
            <v-list-item-title>
              {{ $my.pageTitle(menu.name) }}
            </v-list-item-title>
          </v-list-item>
        </template>
      </v-list>
    </v-menu>
  </v-app-bar>
</template>

<script>
import appLogo from '../../appLogo.vue'
import appTitle from '../../ui/appTitle.vue'

export default {
  components: {
    appLogo,
    appTitle
  },
  data ({ $store }) {
    return {
      accountMenus: [
        { name: 'account-settings', icon: 'mdi-account-cog' },
        { name: 'account-password', icon: 'mdi-lock-outline' },
        { name: 'logout', icon: 'mdi-logout-variant', divider: true }
      ],
      menus: [
        { title: 'users' },
        { title: 'posts' },
        { title: 'myPage' }
      ]
    }
  }
}
</script>
