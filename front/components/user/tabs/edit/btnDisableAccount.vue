<template>
  <div>
    <v-row>
      <v-col class="text-center mb-5">
        <v-btn
          text
          color="error"
          rounded
          @click="dialog = true"
        >
          退会する
        </v-btn>
      </v-col>
    </v-row>
    <v-dialog
      v-model="dialog"
      width="500"
    >
      <v-card>
        <v-card-title>
          退会します。よろしいですか？
        </v-card-title>
        <v-card-text>
          この操作は取り消せません。
        </v-card-text>
        <v-divider />
        <v-card-actions>
          <v-spacer />
          <v-btn
            rounded
            color="info"
            @click="dialog = false"
          >
            キャンセル
          </v-btn>
          <v-btn
            rounded
            color="error"
            @click="clickOK"
          >
            退会する
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import firebase from '~/plugins/firebase'

export default {
  data () {
    return {
      dialog: false
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data',
      user: 'auth/user'
    })
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage',
      logout: 'auth/logout'
    }),
    clickOK () {
      const formData = new FormData()
      formData.append('user[is_active]', false)
      const url = `/api/v1/users/${this.currentUser.id}`
      this.$axios.patch(url, formData)
        .then(() => {
          this.logout()
          this.deleteUser()
          this.flashMessage({ message: '退会しました', type: 'primary', status: true })
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    deleteUser () {
      const user = firebase.auth().currentUser
      user.delete()
    }
  }
}
</script>
