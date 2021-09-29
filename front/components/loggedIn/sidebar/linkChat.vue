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
      <template v-if="count">
        <v-badge
          bordered
          color="error"
          :content="count"
        />
      </template>
    </v-list-item>
  </v-list>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
  data () {
    return {
      count: 0
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data',
      isCatchMessage: 'chat/isCatchMessage'
    })
  },
  watch: {
    isCatchChat (bool) {
      if (bool) {
        this.fetchContents()
        this.setIsCatchMessage(false)
      }
    }
  },
  methods: {
    ...mapActions({
      setIsCatchMessage: 'chat/setIsCatchMessage'
    }),
    fetchContents () {
      const url = `/api/v1/find_unread_chats_count_in_sidebar/${this.currentUser.id}`
      this.$axios.get(url)
        .then((res) => {
          this.count = res.data.length
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    toChat () {
      this.$router.push('/userRooms')
    }
  }
}
</script>
