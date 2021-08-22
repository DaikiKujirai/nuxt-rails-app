<template>
  <v-app>
    <v-col
      cols="3"
      class="list"
    >
      <v-list
        v-for="(menu, i) in menus"
        :key="`menu-btn-${i}`"
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
            v-text="menu.icon"
          />
          {{ $t(`menus.${menu.title}`) }}
        </v-list-item>
      </v-list>
    </v-col>
  </v-app>
</template>

<script>
import { mapActions } from 'vuex'

export default {
  data () {
    return {
      menus: [
        { title: 'posts', icon: 'mdi-home' },
        { title: 'search', icon: 'mdi-magnify' },
        { title: 'notification', icon: 'mdi-bell' },
        { title: 'chat', icon: 'mdi-chat-processing-outline' },
        { title: 'follow', icon: 'mdi-account-details' },
        { title: 'follower', icon: 'mdi-account-details-outline' }
      ]
    }
  },
  methods: {
    ...mapActions({
      setPosts: 'post/setPosts'
    }),
    async goHome () {
      const url = '/api/v1/posts'
      await this.$axios.get(url)
        .then((res) => {
          this.setPosts(res.data)
          this.$router.push('/posts')
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    }
  }
}
</script>

<style scoped>
  .list {
    position: fixed;
  }
</style>
