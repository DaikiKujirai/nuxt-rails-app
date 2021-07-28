<template>
  <div />
</template>

<script>
export default {
  layout: 'logout',
  async middleware ({ store, redirect, from }) {
    await store.dispatch('logout')
    if (from.name !== 'index') { return redirect('/') }
  },
  beforeCreate () {
    this.$router.replace('/')
  }
}
</script>
