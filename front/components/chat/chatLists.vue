<template>
  <div
    style="height: 550px; overflow-y: auto; overflow-x: hidden;"
  >
    <v-card
      v-for="room in chatRooms"
      :key="room.id"
      class="mb-4"
    >
      <chat-list
        :room="room"
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
      url: '',
      userId: 0
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
      this.fetchUrlAndUserId()
      this.fetchContents()
      this.setUser(this.currentUser)
    }, 0)
  },
  methods: {
    ...mapActions({
      setIsUpdate: 'chat/setIsUpdate',
      setUser: 'user/setUser'
    }),
    fetchUrlAndUserId () {
      if (this.$route.name === 'chatRooms') {
        this.userId = this.currentUser.id
        this.url = `/api/v1/chat_rooms/${this.currentUser.id}`
      } else {
        this.userId = this.$route.params.id
        this.url = `/api/v1/chat_rooms/${this.$route.params.id}`
      }
    },
    async fetchContents () {
      const url = `/api/v1/chat_rooms/${this.currentUser.id}`
      await this.$axios.get(url, {
        params: {
          user_id: this.userId
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
