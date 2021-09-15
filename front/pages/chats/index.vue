<template>
  <layout-chat #layout-chat> <!--eslint-disable-line-->
    <h1>
      チャットを選択してください
    </h1>
  </layout-chat>
</template>

<script>
import LayoutChat from '../../components/layout/loggedIn/layoutChat.vue'

export default {
  components: {
    LayoutChat
  }
}
