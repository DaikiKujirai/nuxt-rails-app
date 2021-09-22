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
import firebase from '~/plugins/firebase'

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
      type: String,
      required: true
    }
  },
  data () {
    return {
      disabled: false,
      isValid: false,
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
      const chat = {
        userId: this.currentUser.uid,
        name: this.currentUser.name,
        message: this.message,
        createdAt: new Date()
      }
      firebase.firestore()
        .collection('rooms')
        .doc(this.roomId)
        .collection('chats')
        .add(chat)
        .then(() => {
          this.$cable.perform({
            channel: 'RoomChannel',
            action: 'post',
            data: {
              message: this.message
            }
          })
          this.$refs.form.reset()
          this.createNotification()
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.log(err)
        })
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
