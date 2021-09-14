<template>
  <v-list
    nav
    rounded
  >
    <v-list-item
      two-line
      class="justify-center"
      @click="goHome"
    >
      <v-icon
        size="28"
        class="mr-5"
        v-text="'mdi-home'"
      />
      ホーム
    </v-list-item>
  </v-list>
</template>

<script>

export default {
  methods: {
    goHome () {
      this.$router.push('/posts')
    }
  }
}
</script>
