<template>
  <bef-login-form-card #form-card-content> <!--eslint-disable-line-->
    <v-form
      ref="form"
      v-model="isValid"
    >
      <user-form-email
        :email.sync="params.user.email"
        no-validation
      />
      <user-form-password
        :password.sync="params.user.password"
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
import { mapActions } from 'vuex'
import befLoginFormCard from '../components/beforeLogin/befLoginFormCard.vue'
import userFormEmail from '../components/user/userFormEmail.vue'
import userFormPassword from '../components/user/userFormPassword.vue'
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
      params: { user: { email: '', password: '' } }
    }
  },
  methods: {
    ...mapActions({
      login: 'auth/login'
    }),
    login () {
      this.loading = true
      firebase.auth().signInWithEmailAndPassword(this.params.user.email, this.params.user.password)
        .then((res) => {
          setTimeout(() => {
            // this.login(res.user)
            this.$router.replace('/posts')
            this.loading = false
          }, 1500)
          // eslint-disable-next-line no-console
          console.log('ログイン成功')
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error('ログイン失敗', err)
        })
    }
  }
}
</script>
