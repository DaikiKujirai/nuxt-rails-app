<template>
  <layout-chat #layout-chat > <!--eslint-disable-line-->
    <chat-message />
  </layout-chat>
</template>

<script>
import ChatMessage from '../../components/chat/chatMessage.vue'
import LayoutChat from '../../components/layout/loggedIn/layoutChat.vue'

export default {
  components: {
    ChatMessage,
    LayoutChat
  }
}
</script>
