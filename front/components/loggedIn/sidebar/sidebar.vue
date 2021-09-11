<template>
  <v-app>
    <v-col
      cols="3"
      class="list"
    >
      <v-list
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
            v-text="'mdi-home'"
          />
          ホーム
        </v-list-item>
      </v-list>
      <v-list
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
            v-text="'mdi-magnify'"
          />
          検索
        </v-list-item>
      </v-list>
      <v-list
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
            v-text="'mdi-bell'"
          />
          通知
        </v-list-item>
      </v-list>
      <v-list
        nav
        rounded
      >
        <v-list-item
          two-line
          class="justify-center"
          @click="toChat"
        >
          <v-icon
            size="28"
            class="mr-5"
            v-text="'mdi-chat-processing-outline'"
          />
          チャット
        </v-list-item>
      </v-list>
      <v-list
        nav
        rounded
      >
        <v-list-item
          two-line
          class="justify-center"
          @click="toFollow(1)"
        >
          <v-icon
            size="28"
            class="mr-5"
            v-text="'mdi-account-details'"
          />
          フォロー
        </v-list-item>
      </v-list>
      <v-list
        nav
        rounded
      >
        <v-list-item
          two-line
          class="justify-center"
          @click="toFollow(0)"
        >
          <v-icon
            size="28"
            class="mr-5"
            v-text="'mdi-account-details-outline'"
          />
          フォロワー
        </v-list-item>
      </v-list>
      <template v-if="isAuthenticated">
        <v-list>
          <v-list-item
            class="justify-center"
          >
            <btn-new-post
              @fetchContents="fetchContents"
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
    fetchContents () {
      this.$emit('fetchContents')
    },
    toFollow (tab) {
      this.$router.push(`/relationships/${this.currentUser.id}?tab=${tab}`)
    },
    toChat () {
      this.$router.push(`/chats/${this.currentUser.id}`)
    }
  }
}
</script>

<style scoped>
  .list {
    position: fixed;
  }
</style>
