<template>
  <bef-login-form-card #form-card-content> <!--eslint-disable-line-->
    <v-form
      ref="form"
      v-model="isValid"
    >
      <user-form-name
        :name.sync="user.name"
        :outlined="true"
      />
      <user-form-email
        :email.sync="user.email"
        :outlined="true"
      />
      <user-form-password
        :password.sync="user.password"
        :outlined="true"
      />
      <v-btn
        :disabled="!isValid || loading"
        :loading="loading"
        block
        rounded
        color="primary"
        class="white--text"
        @click="signup"
      >
        登録する
      </v-btn>
      <guest-login />
    </v-form>
  </bef-login-form-card>
</template>

<script>
import { mapActions } from 'vuex'
import firebase from 'firebase/app'
import befLoginFormCard from '../../components/layout/befLogin/befLoginFormCard.vue'
import userFormEmail from '../../components/user/userFormEmail.vue'
import userFormName from '../../components/user/userFormName.vue'
import userFormPassword from '../../components/user/userFormPassword.vue'
import GuestLogin from '../../components/beforeLogin/guestLogin.vue'

export default {
  components: {
    befLoginFormCard,
    userFormName,
    userFormEmail,
    userFormPassword,
    GuestLogin
  },
  layout: 'beforeLogin',
  data () {
    return {
      isValid: false,
      loading: false,
      user: {
        name: '',
        email: '',
        password: ''
      }
    }
  },
  methods: {
    ...mapActions({
      login: 'auth/login',
      loadData: 'auth/loadData',
      flashMessage: 'flash/flashMessage'
    }),
    signup () {
      this.loading = true
      firebase.auth().createUserWithEmailAndPassword(this.user.email, this.user.password)
        .then((res) => {
          this.createUser(res)
        })
        .catch((err) => {
          this.loading = false
          this.flashMessage({ message: err.errors.messages, type: 'error', status: true })
        })
    },
    createUser (res) {
      const user = {
        name: this.user.name,
        email: res.user.email,
        uid: res.user.uid
      }
      this.$axios.$post('/api/v1/users', { user })
        .then(() => {
          this.login(res.user)
          setTimeout(() => {
            this.$router.replace('/posts')
            this.flashMessage({ message: '登録に成功しました', type: 'success', status: true })
            this.loading = false
          }, 500)
        })
        .catch((err) => {
          this.loading = false
          this.flashMessage({ message: err.errors.messages, type: 'error', status: true })
        })
    }
  }
}
</script>
