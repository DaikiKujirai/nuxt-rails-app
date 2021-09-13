<template>
  <v-row class="d-flex align-center">
    <v-col
      cols="2"
      class="pr-0"
    >
      <v-img
        :src="avatar"
        max-height="60"
        max-width="60"
        contain
        style="border-radius: 50%;"
      />
    </v-col>
    <v-col>
      <v-card-title class="pt-0 pl-0">
        {{ user.name }}
      </v-card-title>
      <v-card-subtitle class="pa-0">
        {{ lastChat.message }}
      </v-card-subtitle>
    </v-col>
  </v-row>
</template>

<script>
import { mapActions } from 'vuex'
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
  created () {
    this.fetchContents()
  },
  beforeDestroy () {
    this.sortChatRooms(this.room)
  },
  methods: {
    ...mapActions({
      setIsSort: 'chat/setIsSort'
    }),
    fetchContents () {
      const url = `/api/v1/users/${this.room.distination_user_id}`
      this.$axios.get(url)
        .then((res) => {
          this.user = res.data
          this.avatar = res.data.avatar.url
          this.fetchChatLastMessage()
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
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
            if (chat.message.length > 15) {
              this.sliceMessage(chat)
            }
            this.lastChat = chat
          })
        })
    },
    sliceMessage (chat) {
      chat.message = chat.message.substr(0, 15) + '...'
    }
  },
  sortChatRooms (room) {
    this.$emit('sortChatRooms', room)
  }
}
</script>
