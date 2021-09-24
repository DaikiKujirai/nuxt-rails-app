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
          <user-form-password
            :password.sync="password"
            :outlined="outlined"
            label="現在のパスワードを入力"
            class="mx-15 px-10"
          />
        </v-col>
      </v-row>
      <v-row>
        <v-col class="px-15 pb-0">
          <user-form-password
            :password.sync="newPassword"
            :outlined="outlined"
            label="新しいパスワードを入力"
            class="mx-15 px-10"
          />
        </v-col>
      </v-row>
      <v-row>
        <v-col class="text-center my-10">
          <template v-if="isGuest">
            <v-btn
              disabled
              rounded
              color="error"
              @click="showErrorMessage"
            >
              ゲストユーザーのため変更できません
            </v-btn>
          </template>
          <template v-else>
            <v-btn
              :disabled="!isValid || loading"
              :loading="loading"
              rounded
              color="success"
              @click="reauthenticateUser"
            >
              プロフィールを更新
            </v-btn>
            <btn-disable-account />
          </template>
        </v-col>
      </v-row>
    </v-form>
  </v-tab-item>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import UserFormPassword from '../../userFormPassword.vue'
import BtnDisableAccount from './btnDisableAccount.vue'
import firebase from '~/plugins/firebase'

export default {
  components: {
    UserFormPassword,
    BtnDisableAccount
  },
  props: {
    isGuest: {
      type: Boolean,
      required: true
    }
  },
  data () {
    return {
      tab: null,
      isValid: false,
      loading: false,
      outlined: false,
      password: '',
      newPassword: ''
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data'
    })
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage'
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
          this.flashMessage({ message: '現在のパスワードが正しくありません', type: 'error', status: true })
          this.loading = false
        })
    },
    async updateFirebaseUser (user) {
      await user.updatePassword(this.newPassword)
        .then(() => {
          this.flashMessage({ message: 'アカウント情報を更新しました', type: 'primary', status: true })
          this.loading = false
          this.$router.replace('/posts')
        })
        .catch(() => {
          this.flashMessage({ message: '更新に失敗しました', type: 'error', status: true })
          this.loading = false
        })
    },
    showErrorMessage () {
      this.flashMessage({ message: 'ゲストユーザーのため変更できません', type: 'error', status: true })
    }
  }
}
</script>
