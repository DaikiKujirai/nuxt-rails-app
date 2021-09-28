<template>
  <div
    style="height: 550px; overflow-y: auto; overflow-x: hidden;"
  >
    <v-card
      v-for="chatRoom in chatRooms"
      :key="chatRoom.id"
      class="mb-4"
    >
      <chat-list
        :chat-room="chatRoom"
        @fetchContents="fetchContents"
        @rollBackPage="rollBackPage"
        @identifierIncrement="identifierIncrement"
      />
    </v-card>
    <infinite-scroll
      ref="infinite"
      :page="page"
      :url="url"
      :user-id="Number(userId)"
      @pushContents="pushContents"
      @pageIncrement="pageIncrement"
    />
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import InfiniteScroll from '../ui/infiniteScroll.vue'
import ChatList from './chatList.vue'

export default {
  components: {
    ChatList,
    InfiniteScroll
  },
  data () {
    return {
      chatRooms: [],
      page: 1,
      url: '/api/v1/find_my_chat_rooms',
      userId: ''
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data',
      isUpdate: 'chat/isUpdate'
    })
  },
  mounted () {
    setTimeout(() => {
      // this.fetchUrlAndUserId()
      this.fetchContents()
      this.setUser(this.currentUser)
      this.userId = this.currentUser.id
    }, 0)
  },
  methods: {
    ...mapActions({
      setIsUpdate: 'chat/setIsUpdate',
      setUser: 'user/setUser'
    }),
    async fetchContents () {
      await this.$axios.get(this.url, {
        params: {
          user_id: this.currentUser.id
        }
      })
        .then((res) => {
          this.chatRooms = res.data.chat_rooms
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    toChatRoom () {
      this.$refs.list.toChatRoom()
    },
    pageIncrement () {
      this.page++
    },
    rollBackPage () {
      this.page = 1
    },
    pushContents (res) {
      this.chatRooms.push(...res.data.chat_rooms)
    },
    identifierIncrement () {
      this.$refs.infinite.identifierIncrement()
    }
  }
}
</script>
