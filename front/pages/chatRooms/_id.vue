<template>
  <layout-chat #layout-chat > <!--eslint-disable-line-->
    <chat-message />
  </layout-chat>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import ChatMessage from '../../components/chat/chatMessage.vue'
import LayoutChat from '../../components/layout/loggedIn/layoutChat.vue'

export default {
  components: {
    ChatMessage,
    LayoutChat
  },
  channels: {
    RoomChannel: {
      connected () {
      },
      received (data) {
        this.setIsActive(true)
        this.pushNotification(data)
      },
      disconnected () {
        // eslint-disable-next-line no-console
        console.log('disconnected')
      }
    }
  },
  data () {
    return {
      breadcrumbs: 'チャット'
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data'
    })
  },
  created () {
    this.setBreadcrumbs(this.breadcrumbs)
  },
  mounted () {
    setTimeout(() => {
      this.subscribe()
    }, 0)
  },
  methods: {
    ...mapActions({
      setBreadcrumbs: 'breadcrumbs/setBreadcrumbs',
      setIsActive: 'notification/setIsActive',
      pushNotification: 'notification/pushNotification'
    }),
    async subscribe () {
      await this.$cable.subscribe({
        channel: 'RoomChannel',
        room: this.currentUser.uid,
        uid: `${this.currentUser.uid}`
      })
    }
  }
}
</script>
