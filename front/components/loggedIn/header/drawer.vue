<template>
  <v-navigation-drawer
    v-model="drawer"
    temporary
    fixed
    class="mt-14"
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
  </v-navigation-drawer>
</template>

<script>
import { mapGetters } from 'vuex'
import BtnNewPost from '../../btn/newPost/btnNewPost.vue'
import LinkChat from '../sidebar/linkChat.vue'
import LinkFollower from '../sidebar/linkFollower.vue'
import LinkFollowing from '../sidebar/linkFollowing.vue'
import LinkHome from '../sidebar/linkHome.vue'
import linkIndex from '../sidebar/linkIndex.vue'
import LinkNotification from '../sidebar/linkNotification.vue'

export default {
  components: {
    linkIndex,
    LinkHome,
    LinkNotification,
    LinkChat,
    LinkFollower,
    BtnNewPost,
    LinkFollowing
  },
  data () {
    return {
      drawer: false
    }
  },
  computed: {
    ...mapGetters({
      isAuthenticated: 'auth/isAuthenticated'
    })
  },
  methods: {
    toggleDrawer () {
      this.drawer = !this.drawer
    }
  }
}
</script>
