<template>
  <v-card>
    <v-text-field
      v-model="message"
      class="mx-15 px-10"
    />
    {{ message }}
    <v-btn
      @click="sendMessage"
    >
      送信
    </v-btn>
    <!-- <v-row v-for="chat in chats" :key="chat.id" dense>
      <v-col v-if="chat.userId !== currentUser.uid">
        <div v-if="currentUser.id !== buyerUser.id" class="balloon_l">
          <div class="face_icon">
            <v-avatar v-if="buyerUser.avatar_url !== null ">
              <v-img :src="buyerUser.avatar_url" />
            </v-avatar>
            <v-avatar v-else>
              <v-img :src="image" />
            </v-avatar>
            <div>
              {{ chat.name }}
            </div>
          </div>
          <p class="says other">
            {{ chat.body }}
          </p>
        </div>
        <div v-else class="balloon_l">
          <div class="face_icon">
            <v-avatar v-if="sellerUser.avatar_url !== null ">
              <v-img :src="sellerUser.avatar_url" />
            </v-avatar>
            <v-avatar v-else>
              <v-img :src="image" />
            </v-avatar>
            <div>
              {{ sellerUser.name }}
            </div>
          </div>
          <p class="says other">
            {{ chat.body }}
          </p>
        </div>
      </v-col>
      <v-col v-else>
        <div class="balloon_r">
          <div class="face_icon">
            <v-avatar v-if="currentUser.avatar.url !== null ">
              <v-img :src="currentUser.avatar.url" />
            </v-avatar>
            <v-avatar v-else>
              <v-img :src="image" />
            </v-avatar>
            <div>
              {{ currentUser.name }}
            </div>
          </div>
          <p class="says">
            {{ chat.body }}
          </p>
        </div>
      </v-col>
    </v-row> -->
  </v-card>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
  // async asyncData ({ store, params }) {
  //   const roomId = params.id
  //   const unsubscribe = await store.dispatch('chats/subscribe', { roomId })
  //   return {
  //     unsubscribe
  //   }
  // },
  props: {
    channelId: {
      type: String,
      required: true
    }
  },
  data () {
    return {
      user: {},
      message: ''
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data',
      chats: 'chat/chats',
      firstDisplayedChatsUser: 'chat/firstDisplayedChatsUser'
    })
  },
  created () {
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage'
    }),
    sendMessage () {
      // const chat = {
      //   message: this.message,
      //   createdAt: new Date()
      // }
      // firebase.firestore()
      //   .collection('rooms')
      //   .doc(this.channelId)
      //   .collection('chats')
      //   .add(chat)
      //   .then((res) => {
      //     console.log(res)
      //   })
      //   .catch((err) => {
      //     console.log(err)
      //   })
    }
  }
}
</script>

<style scoped>
h2 {
  clear: both;
  background: #43a047;
  box-shadow: 0px 2px 5px rgba(0,0,0,0.2);
  padding: 10px 10px 10px 20px;
  border-radius: 10px;
  color: #FFF;
}
.card-title {
  background: red;
}
.balloon_l,
.balloon_r {
  margin: 10px 0;
  display: flex;
  justify-content: flex-start;
  align-items: flex-start;
}
.balloon_r {
  justify-content: flex-end;
}
.face_icon img {
  width: 80px;
  height: auto;
}
.balloon_r .face_icon {
  margin-left: 25px;
}
.balloon_l .face_icon {
  margin-right: 25px;
}
.balloon_r .face_icon {
  order: 2 !important;
}
.says {
  max-width: 300px;
  display: flex;
  flex-wrap: wrap;
  position: relative;
  padding: 10px;
  border-radius: 12px;
  background: #8DE055;
  box-sizing: border-box;
  margin: 0 !important;
  line-height: 1.5;
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
  border: 10px solid transparent;
  margin-top: -3px;
}
.balloon_l .says:after {
  left: -26px;
  border-right: 22px solid #EDF1EE;
}
.balloon_r .says:after {
  right: -26px;
  border-left: 22px solid #8DE055;
}
.chat-back {
  background-color: #96b0d6;
}
.card-text {
  padding: 0;
}
</style>
