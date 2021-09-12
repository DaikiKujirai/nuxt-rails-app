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
      id="chat-height"
      color="info"
      max-height="600"
    >
      <v-list-item
        v-for="(msg, i) in chats"
        :key="i"
      >
        <v-col v-if="msg.userId != currentUser.uid">
          <div class="balloon_l">
            <div class="face_icon">
              <v-avatar
                size="60"
              >
                <img
                  :src="userAvatar"
                  contain
                >
              </v-avatar>
            </div>
            <p class="says">
              {{ msg.message }}
            </p>
          </div>
        </v-col>
        <v-col v-else>
          <div class="balloon_r">
            <p class="says-current">
              {{ msg.message }}
              <!-- {{ msg.createdAt }} -->
            </p>
          </div>
        </v-col>
      </v-list-item>
    </v-list>
    <!-- form送信部分 -->
    <v-divider
      id="scroll-inner"
    />
    <div class="ma-0 pa-0 d-flex flex-row align-baseline">
      <v-text-field
        ref="form"
        v-model="message"
        label="メッセージを入力"
        type="text"
        outlined
        dense
        rounded
      />
      <v-btn
        class="ma-2 pa-2"
        outlined
        rounded
        color="success"
        @click="sendMessage"
      >
        送信
      </v-btn>
    </div>
  </v-card>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import firebase from '~/plugins/firebase'

export default {
  data () {
    return {
      user: {},
      message: '',
      userAvatar: '',
      roomId: ''
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data',
      chats: 'chat/chats'
      // firstDisplayedChatsUser: 'chat/firstDisplayedChatsUser'
    })
  },
  created () {
    this.fetchContents()
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage',
      fetchChats: 'chat/fetchChats'
    }),
    async fetchContents () {
      const url = `/api/v1/users/${this.$route.params.id}`
      await this.$axios.get(url)
        .then((res) => {
          this.user = res.data
          this.userAvatar = res.data.avatar.url
          this.setRoomId()
          this.fetchChats(this.roomId)
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    setRoomId () {
      this.user.uid > this.currentUser.uid
        ? (this.roomId = this.user.uid + '-' + this.currentUser.uid)
        : (this.roomId = this.currentUser.uid + '-' + this.user.uid)
    },
    scrollBottom () {
      const chatBack = document.getElementById('chat-height')
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
          // this.fetchNewMessage()
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.log(err)
        })
    }
  }
}
</script>

<style scoped>
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
