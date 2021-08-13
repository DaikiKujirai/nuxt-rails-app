<template>
  <v-container fluid>
    ルート
  </v-container>
</template>

<script>
export default {
  beforeCreate () {
    this.$store.$router.push('/posts')
  }
}
</script>
