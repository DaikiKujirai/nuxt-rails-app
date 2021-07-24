<template>
  <div>
    index.vue
  </div>
</template>

<script>
export default {
  layout ({ store }) {
    return store.state.loggedIn ? 'default' : 'welcome'
  }
}
</script>
