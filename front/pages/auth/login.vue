<template>
  <bef-login-form-card #form-card-content> <!--eslint-disable-line-->
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
import { mapActions } from 'vuex'
import befLoginFormCard from '../../components/beforeLogin/befLoginFormCard.vue'
import userFormEmail from '../../components/user/userFormEmail.vue'
import userFormPassword from '../../components/user/userFormPassword.vue'
import firebase from '~/plugins/firebase'

export default {
  components: {
    userFormEmail,
    userFormPassword,
    befLoginFormCard
  },
  layout: 'beforeLogin',
  data () {
    return {
      isValid: false,
      loading: false,
      user: { email: '', password: '' }
    }
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
          this.flashMessage({ message: 'ログインしました', type: 'success', status: true })
          this.$router.push('/posts')
          this.loading = false
        })
        .catch((err) => {
          this.loading = false
          // eslint-disable-next-line no-console
          console.log(err)
          this.flashMessage({ message: 'メールアドレスまたはパスワードが正しくありません', type: 'error', status: true })
        })
    }
  }
}
</script>
