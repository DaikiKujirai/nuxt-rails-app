<template>
  <div
    style="height: 600px;"
  >
    <v-card
      v-for="room in chatRooms"
      :key="room.id"
      class="mb-4"
    >
      <chat-list
        :room="room"
        @fetchContents="fetchContents"
      />
    </v-card>
    <infinite-scroll
      ref="infinite"
      :page="page"
      :url="url"
      :user-id="Number($route.params.id)"
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
  data ({ $route }) {
    return {
      chatRooms: [],
      page: 1,
      url: `/api/v1/chat_rooms/${$route.params.id}`
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
      this.fetchContents()
      this.setUser(this.currentUser)
    }, 0)
  },
  methods: {
    ...mapActions({
      setIsUpdate: 'chat/setIsUpdate',
      setUser: 'user/setUser'
    }),
    async fetchContents () {
      const url = `/api/v1/chat_rooms/${this.currentUser.id}`
      await this.$axios.get(url, {
        params: {
          current_user_id: this.currentUser.id,
          user_id: this.$route.params.id
        }
      })
        .then((res) => {
          this.rollBackPage()
          this.chatRooms = res.data.chat_rooms
          this.identifierIncrement()
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
