<template>
  <div
    style="height: 550px; overflow-y: auto; overflow-x: hidden;"
  >
    <v-card
      v-for="userRoom in userRooms"
      :key="userRoom.id"
      class="mb-4"
    >
      <chat-list
        ref="room"
        :user-room="userRoom"
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
      userRooms: [],
      page: 1,
      url: '',
      userId: ''
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data',
      isCatchMessage: 'chat/isCatchMessage'
    })
  },
  watch: {
    async isCatchMessage (bool) {
      if (bool) {
        await this.fetchContents()
        await this.identifierIncrement()
        await this.setIsCatchMessage(false)
      }
    }
  },
  mounted () {
    setTimeout(() => {
      this.setUser(this.currentUser)
      this.userId = this.currentUser.id
      this.url = `/api/v1/user_rooms/${this.currentUser.id}`
      this.fetchContents()
    }, 0)
  },
  methods: {
    ...mapActions({
      setUser: 'user/setUser',
      setIsCatchMessage: 'chat/setIsCatchMessage'
    }),
    async fetchContents () {
      await this.$axios.get(this.url)
        .then((res) => {
          this.userRooms = res.data.user_rooms
          // this.fetchUnreadChatsCount()
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    // fetchUnreadChatsCount () {
    //   this.$refs.room.fetchUnreadChatsCount()
    // },
    touserRoom () {
      this.$refs.list.touserRoom()
    },
    pageIncrement () {
      this.page++
    },
    rollBackPage () {
      this.page = 1
    },
    pushContents (res) {
      this.userRooms.push(...res.data.user_rooms)
    },
    identifierIncrement () {
      this.$refs.infinite.identifierIncrement()
    }
  }
}
</script>
