<template>
  <bef-login-form-card #form-card-content> <!--eslint-disable-line-->
    <v-form
      ref="form"
      v-model="isValid"
    >
      <user-form-email
        :email.sync="user.email"
        :outlined="true"
        no-validation
      />
      <user-form-password
        :password.sync="user.password"
        :outlined="true"
        no-validation
      />
      <v-card-actions>
        <nuxt-link
          to="/auth/forgetPassword"
          class="body-2 text-decoration-none"
        >
          パスワードを忘れた?
        </nuxt-link>
      </v-card-actions>
      <v-card-text class="px-0">
        <v-btn
          :disabled="!isValid || loading"
          :loading="loading"
          block
          rounded
          color="success"
          class="white--text"
          @click="loginUser"
        >
          ログインする
        </v-btn>
        <guest-login />
      </v-card-text>
    </v-form>
  </bef-login-form-card>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import befLoginFormCard from '../../components/layout/befLogin/befLoginFormCard.vue'
import userFormEmail from '../../components/user/userFormEmail.vue'
import userFormPassword from '../../components/user/userFormPassword.vue'
import GuestLogin from '../../components/beforeLogin/guestLogin.vue'
import firebase from '~/plugins/firebase'

export default {
  components: {
    userFormEmail,
    userFormPassword,
    befLoginFormCard,
    GuestLogin
  },
  layout: 'beforeLogin',
  data () {
    return {
      isValid: false,
      loading: false,
      user: { email: '', password: '' }
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data'
    })
  },
  methods: {
    ...mapActions({
      login: 'auth/login',
      flashMessage: 'flash/flashMessage'
    }),
    loginUser () {
      this.loading = true
      firebase.auth().signInWithEmailAndPassword(this.user.email, this.user.password)
        .then((res) => {
          this.login(res.user)
          setTimeout(() => {
            this.$router.replace(`/homes/${this.currentUser.id}`)
            this.flashMessage({ message: 'ログインしました', type: 'success', status: true })
            this.loading = false
          }, 1500)
        })
        .catch(() => {
          this.loading = false
          this.flashMessage({ message: 'メールアドレスまたはパスワードが正しくありません', type: 'error', status: true })
        })
    }
  }
}
</script>
