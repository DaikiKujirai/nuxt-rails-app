<template>
  <v-card>
    <v-app-bar
      dense
      flat
      color="white"
    >
      <v-toolbar-title>
        {{ user.name }}
      </v-toolbar-title>
    </v-app-bar>
    <v-list
      id="chat-display"
      class="overflow-y-auto overflow-x-0"
      color="info"
      height="600"
    >
      <v-list-item
        v-for="(msg, i) in chats"
        :key="i"
      >
        <template v-if="msg.userId != currentUser.uid">
          <balloon-l
            :user-avatar="userAvatar"
            :msg="msg"
          />
        </template>
        <template v-else>
          <balloon-r
            :msg="msg"
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
    />
  </v-card>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import BalloonL from './balloonL.vue'
import BalloonR from './balloonR.vue'
import FormSendMessage from './formSendMessage.vue'
import firebase from '~/plugins/firebase'

export default {
  components: {
    BalloonL,
    BalloonR,
    FormSendMessage
  },
  data () {
    return {
      chats: [],
      roomId: '',
      user: {},
      userAvatar: '',
      isMyChatRoom: false,
      channel: null,
      messages: [],
      cable: {},
      msgBox: '',
      disabled: false,
      isValid: false,
      message: ''
      // date: `${$my(this.msg.createdAt.toDate())}`
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data'
    })
  },
  channels: {
    room_channel_public: {
      connected () {
        console.log('connected')
      }
    }
  },
  created () {
  },
  mounted () {
    this.subscribe()
    setTimeout(() => {
      (this.fetchContents())
    }, 0)
  },
  destroyed () {
    this.chats = []
    this.unsubscribe()
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage'
    }),
    // subscribe () {
    //   console.log('route')
    //   this.$cable.subscribe({
    //     channel: 'RoomChannel',
    //     room: 'public',
    //     uid: this.$route.query.uid
    //   })
    // },
    async subscribe () {
      await this.$cable.connection.connect(() => 'ws://localhost:3000/cable')
      await this.$cable.subscribe({
        channel: 'RoomChannel',
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
      const url = `/api/v1/users/${this.$route.params.id}`
      await this.$axios.get(url)
        .then((res) => {
          this.user = res.data
          this.userAvatar = res.data.avatar.url
          this.setRoomId()
          this.fetchChats()
          if (this.$route.name === 'chats-id') {
            setTimeout(() => {
              this.scrollBottom()
            }, 100)
          }
        })
    },
    async fetchChats () {
      await firebase.firestore()
        .collection('rooms')
        .doc(this.roomId)
        .collection('chats')
        .orderBy('createdAt', 'asc')
        .onSnapshot((chatsSnapShot) => {
          chatsSnapShot.docChanges().forEach((snapshot) => {
            const docData = snapshot.doc.data()
            const chat = {
              id: snapshot.doc.id,
              ...docData
            }
            const isEmpty = this.chats.length === 0
            const isNotAdded = !this.chats.find(c => c.id === chat.id)

            if (isEmpty || isNotAdded) {
              this.chats.push(chat)
              setTimeout(() => {
                this.scrollBottom()
              }, 100)
            }
          })
        })
    },
    setRoomId () {
      this.user.uid > this.currentUser.uid
        ? (this.roomId = this.user.uid + '-' + this.currentUser.uid)
        : (this.roomId = this.currentUser.uid + '-' + this.user.uid)
    },
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
  left: -13px;
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
</style>
