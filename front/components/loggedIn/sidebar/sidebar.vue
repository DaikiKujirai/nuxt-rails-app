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
      <template v-if="isAuthenticated">
        <v-list>
          <v-list-item
            class="justify-center"
          >
            <btn-new-post
              @fetchPosts="fetchPosts"
            />
          </v-list-item>
        </v-list>
      </template>
    </v-col>
  </v-app>
</template>

<script>
import { mapGetters } from 'vuex'
import BtnNewPost from '~/components/btn/newPost/btnNewPost.vue'

export default {
  components: {
    BtnNewPost
  },
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
  computed: {
    ...mapGetters({
      isAuthenticated: 'auth/isAuthenticated',
      currentUser: 'auth/data'
    })
  },
  methods: {
    goHome () {
      this.$router.push('/posts')
    },
    fetchPosts () {
      this.$emit('fetchPosts')
    }
  }
}
</script>

<style scoped>
  .list {
    position: fixed;
  }
</style>
