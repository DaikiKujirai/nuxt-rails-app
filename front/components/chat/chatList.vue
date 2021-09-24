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
        :src="room.distination_user.avatar.url"
        height="60"
        max-width="60"
        style="border-radius: 50%;"
        class="ml-2 img"
        @click.prevent.stop="toShow('users', room.distination_user.id)"
      />
    </v-col>
    <v-col>
      <v-card-title class="pt-0 pl-0">
        {{ room.distination_user.name }}
      </v-card-title>
      <v-card-subtitle class="pa-0">
        {{ lastChat.message }}
      </v-card-subtitle>
    </v-col>
  </v-row>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import firebase from '~/plugins/firebase'

export default {
  props: {
    room: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      user: {},
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
      if (val.bool && val.userId === this.room.distination_user.id) {
        await this.updateChatRooms()
        await this.setIsUpdate({
          bool: false,
          userId: 0
        })
      }
    }
  },
  created () {
    this.fetchChatLastMessage()
  },
  methods: {
    ...mapActions({
      setIsUpdate: 'chat/setIsUpdate'
    }),
    fetchChatLastMessage () {
      firebase.firestore()
        .collection('rooms')
        .doc(this.room.name)
        .collection('chats')
        .orderBy('createdAt', 'desc')
        .limit(1)
        .onSnapshot((chatsSnapShot) => {
          chatsSnapShot.docChanges().forEach((snapshot) => {
            const docData = snapshot.doc.data()
            const chat = {
              id: snapshot.doc.id,
              ...docData
            }
            if (!!chat.message && chat.message.length > 15) {
              this.sliceMessage(chat)
            }
            this.lastChat = chat
          })
        })
    },
    updateChatRooms () {
      const url = `/api/v1/chat_rooms/${this.user.id}`
      this.$axios.patch(url, this.room)
        .then(() => {
          this.rollBackPage()
          this.fetchContents()
          this.identifierIncrement()
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.log(err)
        })
    },
    sliceMessage (chat) {
      chat.message = chat.message.substr(0, 15) + '...'
    },
    fetchContents () {
      this.$emit('fetchContents')
    },
    toChatRoom () {
      this.$router.push(`/chatRooms/${this.room.distination_user_id}?uid=${this.user.uid}`)
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
