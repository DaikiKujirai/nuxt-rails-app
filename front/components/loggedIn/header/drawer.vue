<template>
  <v-navigation-drawer
    v-model="drawer"
    temporary
  >
    <link-index />
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
  </v-navigation-drawer>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
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
  computed: {
    ...mapGetters({
      isAuthenticated: 'auth/isAuthenticated',
      drawer: 'drawer/drawer'
    })
  },
  methods: {
    ...mapActions({
      setDrawer: 'drawer/serDrawer'
    })
  }
}
</script>
