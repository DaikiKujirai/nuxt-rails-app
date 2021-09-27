<template>
  <v-form
    ref="form"
    v-model="isValid"
    class="d-flex align-start mx-2 pa-2"
  >
    <chat-message-form
      :message.sync="message"
      class="mr-2"
      @sendMessage="sendMessage"
    />
    <v-btn
      :disabled="!isValid"
      rounded
      color="success"
      @click="sendMessage"
    >
      送信
    </v-btn>
  </v-form>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import chatMessageForm from './chatMessageForm.vue'
// import firebase from '~/plugins/firebase'

export default {
  components: {
    chatMessageForm
  },
  props: {
    user: {
      type: Object,
      required: true
    },
    roomId: {
      type: Number,
      required: true
    }
  },
  data () {
    return {
      disabled: false,
      isValid: false,
      chat: {},
      message: ''
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data'
    })
  },
  methods: {
    ...mapActions({
      setIsUpdate: 'chat/setIsUpdate'
    }),
    sendMessage () {
      this.chat.message = this.message
      this.chat.user_id = this.currentUser.id
      this.chat.room_id = this.roomId
      const url = '/api/v1/chats'
      this.$axios.post(url, this.chat)
        .then((res) => {
          this.$cable.perform({
            channel: 'RoomChannel',
            action: 'post',
            data: {
              message: this.message
            }
          })
          this.pushChat(res.data)
          this.$refs.form.reset()
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    // sendMessage () {
    //   const chat = {
    //     userId: this.currentUser.uid,
    //     name: this.currentUser.name,
    //     message: this.message,
    //     createdAt: new Date()
    //   }
    //   firebase.firestore()
    //     .collection('rooms')
    //     .doc(this.roomId)
    //     .collection('chats')
    //     .add(chat)
    //     .then(() => {
    //       this.$refs.form.reset()
    //       this.createNotification()
    //     })
    //     .catch((err) => {
    //       // eslint-disable-next-line no-console
    //       console.log(err)
    //     })
    // },
    pushChat (chat) {
      this.$emit('pushChat', chat)
    },
    createNotification () {
      const url = '/api/v1/notifications'
      this.$axios.post(url, {
        chat: {
          id: this.currentUser.id,
          user_id: this.user.id
        }
      })
        .then(() => {
          this.setIsUpdate({
            bool: true,
            userId: this.user.id
          })
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    }
  }
}
</script>
