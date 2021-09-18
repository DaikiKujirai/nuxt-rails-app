<template>
  <v-btn
    :loading="loading"
    block
    color="info"
    class="white--text mt-3"
    @click="guestLogin"
  >
    {{ $t('pages.guest') }}
  </v-btn>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import firebase from '~/plugins/firebase'

export default {
  data () {
    return {
      loading: false
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
    async guestLogin () {
      this.loading = true
      const email = 'guest@example.com'
      const password = 'password'
      await firebase.auth().signInWithEmailAndPassword(email, password)
        .then((res) => {
          this.login(res.user)
          setTimeout(() => {
            this.$router.replace(`/homes/${this.currentUser.id}`)
            this.flashMessage({ message: 'ゲストログインしました', type: 'success', status: true })
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
