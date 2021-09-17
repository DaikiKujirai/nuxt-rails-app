<template>
  <v-list
    nav
    rounded
  >
    <v-list-item
      two-line
      class="justify-center"
      @click="toIndex"
    >
      <v-icon
        size="28"
        class="mr-5"
        v-text="'mdi-note-text-outline'"
      />
      全ての投稿
    </v-list-item>
  </v-list>
</template>

<script>

export default {
  methods: {
    toIndex () {
      this.$router.push('/posts')
    }
  }
}
</script>
