<template>
  <div>
    <bef-login-form-card #form-card-content> <!--eslint-disable-line-->
      <v-form
        ref="form"
        v-model="isValid"
      >
        <user-form-email
          :email.sync="email"
          :outlined="true"
          no-validation
        />
        <v-btn
          :disabled="!isValid || loading"
          :loading="loading"
          block
          rounded
          color="success"
          class="white--text"
          @click="sendMail"
        >
          送信する
        </v-btn>
      </v-form>
    </bef-login-form-card>
  </div>
</template>

<script>
import { mapActions } from 'vuex'
import BefLoginFormCard from '../../components/layout/befLogin/befLoginFormCard.vue'
import UserFormEmail from '../../components/user/userFormEmail.vue'
import firebase from '~/plugins/firebase'

export default {
  components: {
    BefLoginFormCard,
    UserFormEmail
  },
  layout: 'beforeLogin',
  data () {
    return {
      isValid: false,
      loading: false,
      email: ''
    }
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage'
    }),
    sendMail () {
      this.loading = true
      firebase.auth().languageCode = 'ja'
      firebase.auth().sendPasswordResetEmail(this.email)
        .then(() => {
          this.flashMessage({ message: '確認メールを送信しました', type: 'primary', status: true })
          this.$router.push('/auth/login')
          this.loding = false
        })
        .catch(() => {
          this.flashMessage({ message: '登録されているメールアドレスではありません', type: 'error', status: true })
          this.loading = false
        })
    }
  }
}
</script>
