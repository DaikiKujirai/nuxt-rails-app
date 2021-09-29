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
import { mapGetters } from 'vuex'
import chatMessageForm from './chatMessageForm.vue'

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
    sendMessage () {
      this.chat.message = this.message
      this.chat.current_user_id = this.currentUser.id
      this.chat.user = this.user
      this.chat.room_id = this.roomId
      const url = '/api/v1/chats'
      this.$axios.post(url, this.chat)
        .then((res) => {
          this.pushChat(res.data)
          this.$refs.form.reset()
          setTimeout(() => {
            this.scrollBottom()
          }, 0)
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    pushChat (chat) {
      this.$emit('pushChat', chat)
    },
    scrollBottom () {
      this.$emit('scrollBottom')
    }
  }
}
</script>
