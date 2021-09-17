<template>
  <div
    style="height: 600px;"
  >
    <v-card
      v-for="room in chatRooms"
      :key="room.id"
      class="mb-4"
      @click="toShow('chats', room.distination_user_id)"
    >
      <chat-list
        :room="room"
        @fetchContents="fetchContents"
      />
    </v-card>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import ChatList from './chatList.vue'

export default {
  components: {
    ChatList
  },
  data () {
    return {
      chatRooms: []
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data',
      isUpdate: 'chat/isUpdate'
    })
  },
  created () {
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
          user_id: this.$route.params.id,
          page_name: this.$route.name
        }
      })
        .then((res) => {
          this.chatRooms = res.data
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    toShow (url, id) {
      this.$router.push(`/${url}/${id}`)
    }
  }
}
</script>
