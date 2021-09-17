<template>
  <v-app>
    <v-col
      cols="3"
      class="list"
    >
      <link-index />
      <link-search />
      <template v-if="isAuthenticated">
        <link-home />
        <link-notification />
        <link-chat />
        <link-following />
        <link-follower />
        <v-list>
          <v-list-item
            class="justify-center"
          >
            <btn-new-post />
          </v-list-item>
        </v-list>
      </template>
    </v-col>
  </v-app>
</template>

<script>
import { mapGetters } from 'vuex'
import LinkHome from './linkHome.vue'
import LinkSearch from './linkSearch.vue'
import LinkNotification from './linkNotification.vue'
import LinkChat from './linkChat.vue'
import LinkFollowing from './linkFollowing.vue'
import LinkFollower from './linkFollower.vue'
import LinkIndex from './linkIndex.vue'
import BtnNewPost from '~/components/btn/newPost/btnNewPost.vue'

export default {
  components: {
    BtnNewPost,
    LinkHome,
    LinkSearch,
    LinkNotification,
    LinkChat,
    LinkFollowing,
    LinkFollower,
    LinkIndex
  },
  computed: {
    ...mapGetters({
      isAuthenticated: 'auth/isAuthenticated'
    })
  }
}
</script>

<style scoped>
  .list {
    position: fixed;
  }
</style>
