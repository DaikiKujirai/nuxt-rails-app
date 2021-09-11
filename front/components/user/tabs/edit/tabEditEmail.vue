<template>
  <v-tab-item
    class="mb-2"
  >
    <v-form
      ref="form"
      v-model="isValid"
    >
      <v-row>
        <v-col class="px-15 pb-0">
          <user-form-email
            :email.sync="email"
            :outlined="outlined"
            :label="label"
            class="mx-15 px-10"
          />
        </v-col>
      </v-row>
      <v-row>
        <v-col
          class="px-15 pb-0"
        >
          <user-form-password
            :password.sync="password"
            :outlined="outlined"
            class="mx-15 px-10"
          />
        </v-col>
      </v-row>
      <v-row>
        <v-col class="text-center my-10">
          <v-btn
            :disabled="!isValid || loading"
            :loading="loading"
            rounded
            color="success"
            @click="reauthenticateUser"
          >
            プロフィールを更新
          </v-btn>
        </v-col>
      </v-row>
    </v-form>
  </v-tab-item>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import userFormEmail from '../../userFormEmail.vue'
import UserFormPassword from '../../userFormPassword.vue'
import firebase from '~/plugins/firebase'

export default {
  components: {
    userFormEmail,
    UserFormPassword
  },
  data () {
    return {
      tab: null,
      isValid: false,
      loading: false,
      outlined: false,
      label: '新しいメールアドレスを入力',
      email: '',
      password: ''
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data'
    })
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage',
      updateCurrentUser: 'auth/updateCurrentUser'
    }),
    async reauthenticateUser () {
      this.loading = true
      const user = firebase.auth().currentUser
      const credential = await firebase.auth.EmailAuthProvider.credential(this.currentUser.email, this.password)
      await user.reauthenticateWithCredential(credential)
        .then(() => {
          this.updateFirebaseUser(user)
        })
        .catch(() => {
          this.flashMessage({ message: 'パスワードが正しくありません', type: 'error', status: true })
          this.loading = false
        })
    },
    async updateFirebaseUser (user) {
      await user.updateEmail(this.email)
        .then(() => {
          this.updateUserData()
        })
        .catch(() => {
          this.flashMessage({ message: '更新に失敗しました', type: 'error', status: true })
          this.loading = false
        })
    },
    async updateUserData () {
      const url = `/api/v1/update_account/${this.currentUser.id}`
      await this.$axios.put(url, { user: { email: this.email, uid: this.currentUser.uid } })
        .then((res) => {
          this.updateCurrentUser(res.data)
          this.flashMessage({ message: 'アカウント情報を更新しました', type: 'primary', status: true })
          this.loading = false
          this.$router.replace('/posts')
        })
        .catch(() => {
          this.flashMessage({ message: '更新に失敗しました', type: 'error', status: true })
          this.loading = false
        })
    }
  }
}
</script>
