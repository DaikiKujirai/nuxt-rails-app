<template>
  <v-avatar
    color="black"
    size="34"
    class="my-app-logo"
  >
    <v-icon
      class="white--text text-subtitle-2"
      @click="toTopPage"
      v-text="'mdi-twitter'"
    />
  </v-avatar>
</template>

<script>
export default {
  methods: {
    toTopPage () {
      this.$router.push('/posts')
    }
  }
}
</script>

<style scoped>
  .my-app-logo {
    margin-right: 8px;
    cursor: pointer;
  }
</style>
