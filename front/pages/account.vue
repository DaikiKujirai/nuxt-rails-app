<template>
  <v-container>
    <nuxt-child />
  </v-container>
</template>

<script>
export default {
  layout: 'loggedIn',
  validate ({ route }) {
    return route.name !== 'account'
  }
}
</script>
