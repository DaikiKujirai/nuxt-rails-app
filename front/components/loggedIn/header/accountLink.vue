<template>
  <v-menu
    app
    offset-x
    offset-y
    max-width="200"
  >
    <template #activator="{ on }">
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
            {{ currentUser.name }}
          </v-list-item-subtitle>
        </v-list-item-content>
      </v-list-item>
      <v-divider />
      <v-subheader>
        アカウント
      </v-subheader>
      <v-list-item
        @click="toMyPage"
      >
        <v-list-item-icon class="mr-2">
          <v-icon
            size="22"
            v-text="'mdi-account'"
          />
        </v-list-item-icon>
        <v-list-item-title>
          マイページ
        </v-list-item-title>
      </v-list-item>
      <v-list-item
        to="/account/settings"
      >
        <v-list-item-icon class="mr-2">
          <v-icon
            size="22"
            v-text="'mdi-account-cog'"
          />
        </v-list-item-icon>
        <v-list-item-title>
          アカウント設定
        </v-list-item-title>
      </v-list-item>
      <v-list-item
        @click="logoutUser"
      >
        <v-list-item-icon class="mr-2">
          <v-icon
            size="22"
            v-text="'mdi-logout-variant'"
          />
        </v-list-item-icon>
        <v-list-item-title>
          ログアウト
        </v-list-item-title>
      </v-list-item>
    </v-list>
  </v-menu>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
  computed: {
    ...mapGetters({
      isAuthenticated: 'auth/isAuthenticated',
      currentUser: 'auth/data'
    })
  },
  methods: {
    ...mapActions({
      logout: 'auth/logout',
      flashMessage: 'flash/flashMessage'
    }),
    logoutUser () {
      this.logout()
        .then(() => {
          this.$router.push('/')
          this.flashMessage({ message: 'ログアウトしました', type: 'success', status: true })
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.log(err)
        })
    },
    toMyPage () {
      this.$router.push(`/users/${this.currentUser.id}`)
    }
  }
}
</script>
