<template>
  <div
    style="height: 600px;"
  >
    <v-card
      v-for="room in chatRooms"
      :key="room.id"
      class="mb-4"
      @click="toShow('chatRooms', room.distination_user_id)"
    >
      <chat-list
        :room="room"
        @fetchContents="fetchContents"
      />
    </v-card>
    <infinite-scroll
      :page="page"
      :url="url"
      :current-user-id="Number(currentUser.id)"
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
    this.fetchContents()
  },
  methods: {
    ...mapActions({
      setIsUpdate: 'chat/setIsUpdate'
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
          this.chatRooms = res.data.chat_rooms
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    toShow (url, id) {
      this.$router.push(`/${url}/${id}`)
    },
    pageIncrement () {
      this.page++
    },
    pushContents (res) {
      console.log(res)
      this.chatRooms.push(...res.data.chat_rooms)
    }
  }
}
</script>
