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
      <template v-if="isExists">
        <v-badge
          dot
          bordered
          color="error"
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
      isExists: false
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data',
      isExistsUnreadChat: 'chat/isExistsUnreadChat'
    })
  },
  watch: {
    async isExistsUnreadChat (bool) {
      if (bool) {
        await this.fetchContents()
        await this.setIsExistsUnreadChat(false)
      }
    }
  },
  mounted () {
    setTimeout(() => {
      this.fetchContents()
    }, 200)
  },
  methods: {
    ...mapActions({
      setIsExistsUnreadChat: 'chat/setIsExistsUnreadChat'
    }),
    fetchContents () {
      const url = `/api/v1/is_exists_unread_chat/${this.currentUser.id}`
      this.$axios.get(url)
        .then((res) => {
          this.isExists = res.data
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
