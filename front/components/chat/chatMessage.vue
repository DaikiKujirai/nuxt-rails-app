<template>
  <v-card>
    <v-card
      flat
      class="d-flex align-center"
    >
      <img
        :src="user.avatar.url"
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
      height="600"
    >
      <v-list-item
        v-for="chat in chats"
        :key="chat.id"
      >
        <template v-if="chat.user_id != currentUser.id">
          <balloon-l
            :user-avatar="userAvatar"
            :message="chat.message"
          />
        </template>
        <template v-else>
          <balloon-r
            :message="chat.message"
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
    />
  </v-card>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import BalloonL from './balloonL.vue'
import BalloonR from './balloonR.vue'
import FormSendMessage from './formSendMessage.vue'
// import firebase from '~/plugins/firebase'

export default {
  components: {
    BalloonL,
    BalloonR,
    FormSendMessage
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
      // date: `${$my(this.msg.createdAt.toDate())}`
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
  channels: {
    RoomChannel: {
      connected () {
        console.log('connected', this)
      },
      rejected () {
        console.log('rejected')
      },
      received (data) {
        console.log('received', data)
      },
      disconnected () {
        console.log('disconnected')
      }
    }
  },
  mounted () {
    this.subscribe()
    setTimeout(() => {
      this.fetchContents()
    }, 0)
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage'
    }),
    subscribe () {
      this.$cable.subscribe({
        channel: 'RoomChannel',
        room: this.$route.query.uid,
        uid: this.$route.query.uid
      })
    },
    unsubscribe () {
      this.$cable.unsubscribe({
        channel: 'RoomChannel',
        uid: this.$route.query.uid
      })
    },
    async fetchContents () {
      const url = `/api/v1/chats/${this.$route.params.id}`
      await this.$axios.get(url, {
        params: {
          user_id: this.currentUser.id
        }
      })
        .then((res) => {
          this.chats = res.data.chats
          this.roomId = res.data.room_id
          this.user = res.data.user
          this.userAvatar = res.data.user.avatar.url
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    pushChat (chat) {
      this.chats.push(chat)
    },
    // async fetchContents () {
    //   const url = `/api/v1/users/${this.$route.params.id}`
    //   await this.$axios.get(url)
    //     .then((res) => {
    //       this.user = res.data
    //       this.userAvatar = res.data.avatar.url
    //       this.fetchChats()
    //       if (this.$route.name === 'chatRooms-id') {
    //         setTimeout(() => {
    //           this.scrollBottom()
    //         }, 100)
    //       }
    //     })
    // },
    // async fetchChats () {
    //   await firebase.firestore()
    //     .collection('rooms')
    //     .doc(this.roomId)
    //     .collection('chats')
    //     .orderBy('createdAt', 'asc')
    //     .onSnapshot((chatsSnapShot) => {
    //       chatsSnapShot.docChanges().forEach((snapshot) => {
    //         const docData = snapshot.doc.data()
    //         const chat = {
    //           id: snapshot.doc.id,
    //           ...docData
    //         }
    //         const isEmpty = this.chats.length === 0
    //         const isNotAdded = !this.chats.find(c => c.id === chat.id)

    //         if (isEmpty || isNotAdded) {
    //           this.chats.push(chat)
    //           setTimeout(() => {
    //             this.scrollBottom()
    //           }, 100)
    //         }
    //       })
    //     })
    // },
    scrollBottom () {
      const chatBack = document.getElementById('chat-display')
      chatBack.scrollTop = chatBack.scrollHeight
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
