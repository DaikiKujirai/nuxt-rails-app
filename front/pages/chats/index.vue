<template>
  <layout-chat #layout-chat> <!--eslint-disable-line-->
    <overline>
      チャットを選択してください
    </overline>
  </layout-chat>
</template>

<script>
import LayoutChat from '../../components/layout/loggedIn/layoutChat.vue'

export default {
  components: {
    LayoutChat
  }
}
