<template>
  <v-card>
    <template v-if="isMyChatRoom">
      <h1>
        チャットを選択してください
      </h1>
    </template>
    <template v-else>
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
      <v-form
        ref="form"
        v-model="isValid"
        class="d-flex align-start mx-2 pt-2"
      >
        <chat-message-form
          :message.sync="message"
          class="mr-2"
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
  </v-card>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import chatMessageForm from './chatMessageForm.vue'
import BalloonL from './balloonL.vue'
import BalloonR from './balloonR.vue'
import firebase from '~/plugins/firebase'

export default {
  components: {
    chatMessageForm,
    BalloonL,
    BalloonR
  },
  data () {
    return {
      disabled: false,
      isValid: false,
      chats: [],
      roomId: '',
      user: {},
      message: '',
      userAvatar: ''
      // date: `${$my(this.msg.createdAt.toDate())}`
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data',
      isUpdate: 'chat/isUpdate'
    }),
    isMyChatRoom () {
      return this.currentUser.id === this.$route.params.id
    }
  },
  created () {
    this.fetchContents()
  },
  destroyed () {
    this.chats = []
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage',
      setIsUpdate: 'chat/setIsUpdate'
    }),
    async fetchContents () {
      const url = `/api/v1/users/${this.$route.params.id}`
      await this.$axios.get(url)
        .then((res) => {
          this.user = res.data
          this.userAvatar = res.data.avatar.url
          this.setRoomId()
          this.fetchChats()
          setTimeout(() => {
            this.scrollBottom()
          }, 100)
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
    },
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
          this.$refs.form.reset()
          this.createNotification()
          setTimeout(() => {
            this.scrollBottom()
          }, 100)
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
  width: 60px;
  height: auto;
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
