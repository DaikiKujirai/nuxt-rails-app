<template>
  <bef-login-form-card #form-card-content> <!--eslint-disable-line-->
    <v-form
      ref="form"
      v-model="isValid"
    >
      <user-form-name
        :name.sync="user.name"
      />
      <user-form-email
        :email.sync="user.email"
      />
      <user-form-password
        :password.sync="user.password"
      />
      <v-btn
        :disabled="!isValid || loading"
        :loading="loading"
        block
        color="primary"
        class="white--text"
        @click="signup"
      >
        登録する
      </v-btn>
    </v-form>
  </bef-login-form-card>
</template>

<script>
import { mapActions } from 'vuex'
import firebase from 'firebase/app'
import befLoginFormCard from '../../components/beforeLogin/befLoginFormCard.vue'
import userFormEmail from '../../components/user/userFormEmail.vue'
import userFormName from '../../components/user/userFormName.vue'
import userFormPassword from '../../components/user/userFormPassword.vue'

export default {
  components: {
    befLoginFormCard,
    userFormName,
    userFormEmail,
    userFormPassword
  },
  layout: 'beforeLogin',
  middleware: [
    'handle-login-route',
    'disable-direct-access'
  ],
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
      showMessage: 'flash/showMessage'
    }),
    signup () {
      this.loading = true
      firebase.auth().createUserWithEmailAndPassword(this.user.email, this.user.password)
        .then((res) => {
          // eslint-disable-next-line no-console
          console.log('サインアップ成功', res)
          const user = {
            name: this.user.name,
            email: res.user.email,
            uid: res.user.uid
          }
          this.$axios.$post('/api/v1/users', { user })
            .then(() => {
              // eslint-disable-next-line no-console
              console.log('アカウント作成', res)
              this.login(res.user)
              this.showMessage({ message: '登録に成功しました', type: 'success', status: true })
              this.loading = false
              this.$router.push('/posts')
            })
            .catch((err) => {
              // eslint-disable-next-line no-console
              console.log('アカウント作成失敗', err)
            })
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.log('サインアップエラー', err)
        })
      this.loading = true
      setTimeout(() => {
        // this.formReset()
        this.loading = false
      }, 1500)
    }
    // formReset () {
    //   this.$refs.form.reset()
    //   this.user = {
    //     name: '',
    //     email: '',
    //     password: ''
    //   }
    // }
  }
}
</script>
