<template>
  <v-container
    fluid
  >
    <v-row>
      <sidebar />
      <v-col
        cols="4"
        offset="3"
      >
        <v-row>
          <v-col
            class="breadcrumbs"
            cols="4"
          >
            <v-card class="d-flex align-center">
              <v-btn
                icon
                class="ml-3"
                @click="pageBack"
              >
                <v-icon
                  size="40"
                  v-text="'mdi-arrow-left'"
                />
              </v-btn>
              <breadcrumbs />
            </v-card>
          </v-col>
        </v-row>
        <v-main>
          <div class="mt-5">
            <chat-list />
          </div>
        </v-main>
      </v-col>
      <v-col cols="5">
        <chat-message />
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex'
import ChatList from '../../components/chat/chatList.vue'
import ChatMessage from '../../components/chat/chatMessage.vue'
import Sidebar from '../../components/loggedIn/sidebar/sidebar.vue'
import Breadcrumbs from '../../components/loggedIn/ui/breadcrumbs.vue'
// import firebase from '~/plugins/firebase'

export default {
  components: {
    Sidebar,
    Breadcrumbs,
    ChatList,
    ChatMessage
  },
  data () {
    return {
      user: {},
      channelId: ''
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data',
      firstDisplayedChatsUser: 'chat/firstDisplayedChatsUser'
    })
  },
  mounted () {
    // if (this.firstDisplayedChatsUser) {
    //   this.user = this.firstDisplayedChatsUser
    // }
    // this.setChannelId()
    // this.fetchContents()
  },
  methods: {
    // setChannelId () {
    //   this.user.uid > this.currentUser.uid
    //     ? (this.channelId = this.user.uid + '-' + this.currentUser.uid)
    //     : (this.channelId = this.currentUser.uid + '-' + this.user.uid)
    // },
    pageBack () {
      this.$router.go(-1)
    }
  }
}
</script>

<style scoped>
  .breadcrumbs {
    position: fixed;
    z-index: 1;
    padding-top: 0;
  }
</style>
