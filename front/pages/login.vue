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
          @click="login"
        >
          ログインする
        </v-btn>
      </v-card-text>
    </v-form>
  </bef-login-form-card>
</template>

<script>
import befLoginFormCard from '../components/beforeLogin/befLoginFormCard.vue'
import userFormEmail from '../components/user/userFormEmail.vue'
import userFormPassword from '../components/user/userFormPassword.vue'
import error from '../components/error'
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
  methods: {
    login () {
      this.loading = true
      firebase.auth().signInWithEmailAndPassword(this.user.email, this.user.password)
        .then((res) => {
          setTimeout(() => {
            this.$router.replace('/posts')
            this.loading = false
          }, 1500)
          // eslint-disable-next-line no-console
          console.log('ログイン成功', res)
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error('ログイン失敗', err)
          this.error = 'メールアドレスまたはパスワードが正しくありません'
          this.loading = false
        })
    }
  }
}
</script>
