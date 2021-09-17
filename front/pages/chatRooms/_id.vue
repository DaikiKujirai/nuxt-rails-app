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
    this.setUser(this.currentUser)
  },
  methods: {
    ...mapActions({
      setBreadcrumbs: 'breadcrumbs/setBreadcrumbs',
      setUser: 'user/setUser'
    })
  }
}
</script>
