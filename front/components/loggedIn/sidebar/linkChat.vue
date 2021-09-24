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
        v-text="'mdi-wechat'"
      />
      <div class="ml-5">
        チャット
      </div>
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
      this.$router.push('/chatRooms')
    }
  }
}
</script>
