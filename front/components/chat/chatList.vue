<template>
  <v-row
    class="d-flex align-center"
    style="cursor: pointer;"
    @click="toChatRoom"
  >
    <v-col
      cols="2"
      class="pr-0"
    >
      <v-img
        :src="chatRoom.partner.avatar.url"
        height="60"
        max-width="60"
        style="border-radius: 50%;"
        class="ml-2 img"
        @click.prevent.stop="toShow('users', chatRoom.partner.id)"
      />
    </v-col>
    <v-col>
      <v-card-title class="pt-0 pl-0">
        {{ chatRoom.partner.name }}
      </v-card-title>
      <v-card-subtitle class="pa-0">
        {{ lastChat }}
      </v-card-subtitle>
    </v-col>
  </v-row>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
  props: {
    chatRoom: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      avatar: '',
      lastChat: ''
    }
  },
  computed: {
    ...mapGetters({
      isUpdate: 'chat/isUpdate'
    })
  },
  watch: {
    async isUpdate (val) {
      if (val.bool && val.userId === this.chatRoom.partner.id) {
        await this.updateChatRooms()
        await this.setIsUpdate({
          bool: false,
          userId: 0
        })
      }
    }
  },
  created () {
    // this.fetchChatLastMessage()
  },
  mounted () {
    setTimeout(() => {
      this.fetchChatLastMessage()
    }, 200)
  },
  methods: {
    ...mapActions({
      setIsUpdate: 'chat/setIsUpdate'
    }),
    fetchChatLastMessage () {
      this.lastChat = this.chatRoom.room.chats.slice(-1)[0].message
      if (this.lastChat.length >= 15) {
        this.sliceMessage()
      }
    },
    // updateChatRooms () {
    //   const url = `/api/v1/chat_rooms/${this.room.partner.id}`
    //   this.$axios.patch(url, this.room)
    //     .then(() => {
    //       this.rollBackPage()
    //       this.fetchContents()
    //       this.identifierIncrement()
    //     })
    //     .catch((err) => {
    //       // eslint-disable-next-line no-console
    //       console.log(err)
    //     })
    // },
    sliceMessage () {
      this.lastChat = this.lastChat.substr(0, 15) + '...'
    },
    fetchContents () {
      this.$emit('fetchContents')
    },
    toChatRoom () {
      this.$router.push(`/chatRooms/${this.chatRoom.partner.id}?uid=${this.chatRoom.partner.uid}`)
    },
    toShow (url, id) {
      this.$router.push(`/${url}/${id}`)
    },
    rollBackPage () {
      this.$emit('rollBackPage')
    },
    identifierIncrement () {
      this.$emit('identifierIncrement')
    }
  }
}
</script>
