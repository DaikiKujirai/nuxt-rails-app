<template>
  <layout-chat #layout-chat > <!--eslint-disable-line-->
    <v-card class="mt-15">
      <v-card-title>
        チャットを選択してください
      </v-card-title>
    </v-card>
  </layout-chat>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import LayoutChat from '../../components/layout/loggedIn/layoutChat.vue'

export default {
  components: {
    LayoutChat
  },
  channels: {
    RoomChannel: {
      connected () {
      },
      received (data) {
        this.setIsActive(true)
        this.pushNotification(data)
      },
      disconnected () {
        // eslint-disable-next-line no-console
        console.log('disconnected')
      }
    }
  },
  data () {
    return {
      breadcrumbs: 'チャット',
      userId: 0
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data'
    })
  },
  created () {
    this.setBreadcrumbs(this.breadcrumbs)
  },
  mounted () {
    setTimeout(() => {
      this.subscribe()
    })
  },
  methods: {
    ...mapActions({
      setBreadcrumbs: 'breadcrumbs/setBreadcrumbs'
    }),
    async subscribe () {
      await this.$cable.subscribe({
        channel: 'RoomChannel',
        room: this.currentUser.uid,
        uid: `${this.currentUser.uid}`
      })
    }
  }
}
</script>
