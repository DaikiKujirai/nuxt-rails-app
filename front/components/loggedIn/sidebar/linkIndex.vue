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
import { mapActions } from 'vuex'

export default {
  methods: {
    ...mapActions({
      setReacquireData: 'post/setReacquireData'
    }),
    toIndex () {
      this.$route.name !== 'posts'
        ? (this.$router.push('/posts'))
        : (this.setReacquireData(true))
    }
  }
}
</script>
