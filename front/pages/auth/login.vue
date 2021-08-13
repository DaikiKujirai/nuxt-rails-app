<template>
  <bef-login-form-card #form-card-content> <!--eslint-disable-line-->
    <error />
    <v-form
      ref="form"
      v-model="isValid"
    >
      <user-form-email
        :email.sync="user.email"
        no-validation
      />
      <user-form-password
        :password.sync="user.password"
        no-validation
      />
      <v-card-actions>
        <nuxt-link
          to="#"
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
          color="success"
          class="white--text"
          @click="loginUser"
        >
          ログインする
        </v-btn>
      </v-card-text>
    </v-form>
  </bef-login-form-card>
</template>

<script>
import { mapState, mapActions } from 'vuex'
import befLoginFormCard from '../../components/beforeLogin/befLoginFormCard.vue'
import userFormEmail from '../../components/user/userFormEmail.vue'
import userFormPassword from '../../components/user/userFormPassword.vue'
import error from '../../components/error'
import firebase from '~/plugins/firebase'

export default {
  components: {
    userFormEmail,
    userFormPassword,
    befLoginFormCard,
    error
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
    ...mapState({
      state: 'auth/state'
    })
  },
  methods: {
    ...mapActions({
      login: 'auth/login',
      showMessage: 'flash/showMessage'
    }),
    loginUser () {
      this.loading = true
      firebase.auth().signInWithEmailAndPassword(this.user.email, this.user.password)
        .then((res) => {
          this.login(res.user)
          this.showMessage({ message: 'ログインしました', type: 'success', status: 'true' })
          this.$router.replace('/posts')
          this.loading = false
          // eslint-disable-next-line no-console
          console.log(res)
        })
        .catch((err) => {
          this.error = 'メールアドレスまたはパスワードが正しくありません'
          this.loading = false
          // eslint-disable-next-line no-console
          console.log(err)
        })
    }
  }
}
</script>
