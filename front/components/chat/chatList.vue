<template>
  <v-row
    class="d-flex align-center"
    style="cursor: pointer;"
    @click="toUserRoom"
  >
    <v-col
      cols="2"
      class="pr-0"
    >
      <v-img
        :src="userRoom.partner.avatar.url"
        height="60"
        max-width="60"
        style="border-radius: 50%;"
        class="ml-2 img"
        @click.prevent.stop="toShow('users', userRoom.partner.id)"
      />
    </v-col>
    <v-col>
      <v-card-title class="pt-0 pl-0">
        {{ userRoom.partner.name }}
      </v-card-title>
      <v-card-subtitle class="pa-0">
        {{ userRoom.last_message }}
      </v-card-subtitle>
    </v-col>
    <v-col class="text-center">
      <template v-if="unreadCount">
        <v-badge
          bordered
          color="error"
          :content="unreadCount"
        />
      </template>
    </v-col>
  </v-row>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  props: {
    userRoom: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      avatar: '',
      lastChat: '',
      unreadCount: 0
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data',
      isCatchMessage: 'chat/isCatchMessage'
    })
  },
  watch: {
    isCatchMessage (val) {
      if (val.bool && val.userRoom.id === this.userRoom.id) {
        this.fetchUnreadChatsCount()
      }
    }
  },
  mounted () {
    setTimeout(() => {
      this.fetchUnreadChatsCount()
    })
  },
  methods: {
    fetchUnreadChatsCount () {
      console.log(this.userRoom)
      const url = `/api/v1/find_unread_chats_count_in_room/${this.userRoom.room_id}`
      this.$axios.get(url, {
        partner_id: this.userRoom.partner_id
      })
        .then((res) => {
          this.unreadCount = res.data.length
        })
    },
    toUserRoom () {
      this.$router.push(`/userRooms/${this.userRoom.partner.id}?uid=${this.userRoom.partner.uid}`)
    },
    toShow (url, id) {
      this.$router.push(`/${url}/${id}`)
    },
    rollBackPage () {
      this.$emit('rollBackPage')
    }
  }
}
</script>
