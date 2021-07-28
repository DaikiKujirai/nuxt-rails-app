<template>
  <v-container fluid>
    <div
      v-for="(p, i) in recentPosts"
      :key="i"
    >
      {{ p.title }}
      {{ p.content }}
    </div>
  </v-container>
</template>

<script>
export default {
  layout ({ store }) {
    return store.state.loggedIn ? 'loggedIn' : 'welcome'
  },
  computed: {
    recentPosts () {
      const copyPosts = Array.from(this.$store.state.posts)
      return copyPosts.sort((a, b) => {
        if (a.updatedAt > b.updatedAt) { return -1 }
        if (a.updatedAt < b.updatedAt) { return 1 }
        return 0
      })
    }
  }
}
</script>
