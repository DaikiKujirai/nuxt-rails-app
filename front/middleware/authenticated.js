export default function ({ store }) {
  if (!store.state.auth.user) {
    return this.$router.push('/auth/login')
  }
}
