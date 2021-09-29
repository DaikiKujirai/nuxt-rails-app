<template>
  <v-card>
    <v-card
      flat
      class="d-flex align-center"
    >
      <img
        :src="userAvatar"
        height="50"
        width="50"
        class="ml-2"
      >
      <v-card-title>
        {{ user.name }}
      </v-card-title>
    </v-card>
    <v-list
      id="chat-display"
      class="overflow-y-auto overflow-x-0"
      :color="color"
      height="550"
    >
      <v-list-item
        v-for="chat in chats"
        :key="chat.id"
      >
        <template v-if="chat.user_id != currentUser.id">
          <balloon-l
            :user-avatar="userAvatar"
            :chat="chat"
          />
        </template>
        <template v-else>
          <balloon-r
            :chat="chat"
          />
        </template>
      </v-list-item>
    </v-list>
    <v-divider
      id="scroll-inner"
    />
    <form-send-message
      :user="user"
      :room-id="roomId"
      @pushChat="pushChat"
      @scrollBottom="scrollBottom"
    />
  </v-card>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import BalloonL from './balloonL.vue'
import BalloonR from './balloonR.vue'
import FormSendMessage from './formSendMessage.vue'

export default {
  components: {
    BalloonL,
    BalloonR,
    FormSendMessage
  },
  channels: {
    RoomChannel: {
      connected () {
      },
      received (data) {
        this.setIsCatchMessage(true)
        switch (data.category) {
          case 'read':
            this.patchCheckedTrue()
            break
          case 'read_all':
            this.chats = data.chats
            break
        }
        if (Number(this.$route.params.id) === data.notification_data.user_id) {
          this.updateChecked(data.notification_data)
          this.chats.push(data.notification_data)
          setTimeout(() => {
            this.scrollBottom()
          }, 0)
        }
      },
      disconnected () {
        // eslint-disable-next-line no-console
        console.log('disconnected')
      }
    }
  },
  data () {
    return {
      chats: [],
      newChat: {},
      roomId: 0,
      user: {},
      userAvatar: '',
      isMyChatRoom: false,
      messages: [],
      disabled: false,
      isValid: false,
      message: ''
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data'
    }),
    color () {
      return this.$vuetify.theme.dark ? ('#1e1e1e') : ('info')
    }
  },
  mounted () {
    setTimeout(() => {
      this.fetchContents()
      this.subscribe()
    }, 0)
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage',
      pushNotification: 'notification/pushNotification',
      setIsCatchMessage: 'chat/setIsCatchMessage'
    }),
    async subscribe () {
      await this.$cable.subscribe({
        channel: 'RoomChannel',
        room: this.currentUser.uid,
        uid: `${this.currentUser.uid}`
      })
    },
    async fetchContents () {
      const url = `/api/v1/chats/${this.$route.params.id}`
      await this.$axios.get(url, {
        params: {
          user_id: this.currentUser.id,
          uid: this.$route.query.uid
        }
      })
        .then((res) => {
          this.chats = res.data.chats
          this.roomId = res.data.room_id
          this.user = res.data.user
          this.userAvatar = res.data.user.avatar.url
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
      this.chats.push(chat)
      this.scrollBottom()
    },
    scrollBottom () {
      const chatBack = document.getElementById('chat-display')
      chatBack.scrollTop = chatBack.scrollHeight
    },
    updateChecked (chat) {
      const url = `/api/v1/chats/${chat.id}`
      this.$axios.patch(url, {
        uid: this.user.uid
      })
    },
    patchCheckedTrue () {
      this.chats.slice(-1)[0].checked = true
    }
  }
}
</script>

<style>
#chat-display {
  overflow: hidden;
}
.balloon_l,
.balloon_r {
  display: flex;
  justify-content: flex-start;
  align-items: flex-start;
}
.balloon_r {
  justify-content: flex-end;
}
.face_icon img {
  width: 50px;
  height: 50px;
  border-radius: 50%
}
.balloon_l .face_icon {
  margin-right: 10px;
}
.says {
  max-width: 300px;
  display: flex;
  flex-wrap: wrap;
  position: relative;
  padding: 10px;
  border-radius: 30px;
  background: #f6f6f4;
  box-sizing: border-box;
  margin: 0 !important;
  line-height: 1.3;
}
.says-current {
  max-width: 300px;
  display: flex;
  flex-wrap: wrap;
  position: relative;
  padding: 10px;
  border-radius: 30px;
  background: #8DE055;
  box-sizing: border-box;
  margin: 0 !important;
  line-height: 1.3;
  /*   align-items: center; */
}
.other {
  background: #EDF1EE;
}
.says p {
  margin: 8px 0 0 !important;
}
.says p:first-child {
  margin-top: 0 !important;
}
.says:after {
  content: "";
  position: absolute;
  border: 5px solid transparent;
  transform: rotate(20deg);
}
.says-current:after {
  content: "";
  position: absolute;
  border: 5px solid transparent;
  transform: rotate(-35deg);
  margin-top: -10px;
}
.balloon_l .says:after {
  left: -15px;
  border-right: 20px solid #f6f6f4;
}
.balloon_r .says-current:after {
  right: -13px;
  border-left: 20px solid #8DE055;
}
.chat-back {
  background-color: #96b0d6;
}
.card-text {
  padding: 0;
}
.says-dark {
  max-width: 300px;
  display: flex;
  flex-wrap: wrap;
  position: relative;
  padding: 10px;
  border-radius: 30px;
  background: grey;
  box-sizing: border-box;
  margin: 0 !important;
  line-height: 1.3;
}
.says-current-dark {
  max-width: 300px;
  display: flex;
  flex-wrap: wrap;
  position: relative;
  padding: 10px;
  border-radius: 30px;
  background: #1c9cef;
  box-sizing: border-box;
  margin: 0 !important;
  line-height: 1.3;
  /*   align-items: center; */
}
.other-dark {
  background: #EDF1EE;
}
.says-dark p {
  margin: 8px 0 0 !important;
}
.says-dark p:first-child {
  margin-top: 0 !important;
}
.says-dark:after {
  content: "";
  position: absolute;
  border: 5px solid transparent;
  transform: rotate(20deg);
}
.says-current-dark:after {
  content: "";
  position: absolute;
  border: 5px solid transparent;
  transform: rotate(-35deg);
  margin-top: -10px;
}
</style>
