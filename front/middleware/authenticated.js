export default function ({ $auth, store }) {
  console.log($auth)
  if (!store.state.auth.isAuthenticated) {
    return this.$router.push('/auth/login')
  }
}
