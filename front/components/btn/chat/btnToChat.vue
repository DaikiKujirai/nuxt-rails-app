<template>
  <v-tooltip bottom>
    <template #activator="{ on, attrs }">
      <v-btn
        icon
        large
        v-bind="attrs"
        v-on="on"
        @click="toChat"
      >
        <v-icon
          v-text="'mdi-email-outline'"
        />
      </v-btn>
    </template>
    <span>メッセージ</span>
  </v-tooltip>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
  props: {
    user: {
      type: Object,
      required: true
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data'
    })
  },
  methods: {
    ...mapActions({
      setFirstDisplayedChatsUser: 'chat/setFirstDisplayedChatsUser'
    }),
    toChat () {
      this.setFirstDisplayedChatsUser(this.user)
      this.$router.push(`/chats/${this.currentUser.id}`)
    }
  }
}
</script>
