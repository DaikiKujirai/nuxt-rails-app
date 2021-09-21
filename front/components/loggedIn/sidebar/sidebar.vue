<template>
  <v-app>
    <v-col
      sm="3"
      md="3"
      class="list"
    >
      <link-index />
      <template v-if="isAuthenticated">
        <link-home />
        <link-notification />
        <link-chat />
        <link-following />
        <link-follower />
        <btn-new-post />
      </template>
    </v-col>
  </v-app>
</template>

<script>
import { mapGetters } from 'vuex'
import BtnNewPost from '../../btn/newPost/btnNewPost.vue'
import LinkHome from './linkHome.vue'
import LinkNotification from './linkNotification.vue'
import LinkChat from './linkChat.vue'
import LinkFollowing from './linkFollowing.vue'
import LinkFollower from './linkFollower.vue'
import LinkIndex from './linkIndex.vue'

export default {
  components: {
    BtnNewPost,
    LinkHome,
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
