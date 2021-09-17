<template>
  <v-list
    nav
    rounded
  >
    <v-list-item
      two-line
      class="justify-center"
      @click="toChat"
    >
      <v-icon
        size="28"
        class="mr-5"
        v-text="'mdi-wechat'"
      />
      チャット
    </v-list-item>
  </v-list>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  computed: {
    ...mapGetters({
      currentUser: 'auth/data'
    })
  },
  methods: {
    toChat () {
      this.$router.push(`/chatRooms/${this.currentUser.id}`)
    }
  }
}
</script>
