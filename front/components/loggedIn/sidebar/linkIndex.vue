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
        v-text="'mdi-note-text-outline'"
      />
      <div
        class="ml-5"
      >
        全ての投稿
      </div>
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
