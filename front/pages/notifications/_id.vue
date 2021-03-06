<template>
  <layout-main #layout-main> <!--eslint-disable-line-->
    <v-row>
      <v-col>
        <v-card
          v-for="notification in notifications"
          :key="notification.id"
          style="cursor: pointer;"
          class="mb-4"
        >
          <template v-if="notification.action === 'follow'">
            <follow-card
              :notification="notification"
              :user="notification.visitor"
            />
          </template>
          <template v-else-if="notification.action === 'chat'">
            <chat-card
              :notification="notification"
              :user="notification.visitor"
            />
          </template>
          <template v-else>
            <like-comment-card
              :notification="notification"
              :user="notification.visitor"
              :post="notification.post"
            />
          </template>
        </v-card>
      </v-col>
    </v-row>
    <infinite-scroll
      ref="infinite"
      :page="page"
      :url="`/api/v1/notifications/${$route.params.id}`"
      @pushContents="pushContents"
      @pageIncrement="pageIncrement"
    />
  </layout-main>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import layoutMain from '../../components/layout/loggedIn/layoutMain.vue'
import LikeCommentCard from '../../components/notification/likeCommentCard.vue'
import FollowCard from '../../components/notification/followCard.vue'
import InfiniteScroll from '../../components/ui/infiniteScroll.vue'
import ChatCard from '../../components/notification/chatCard.vue'

export default {
  components: {
    layoutMain,
    LikeCommentCard,
    InfiniteScroll,
    FollowCard,
    ChatCard
  },
  channels: {
    RoomChannel: {
      connected () {
      },
      received (data) {
        if (data.category === 'chat') {
          this.setIsExistsUnreadChat(true)
        }
      },
      disconnected () {
        // eslint-disable-next-line no-console
        console.log('disconnected')
      }
    }
  },
  async asyncData ({ $axios, params }) {
    const res = await $axios.get(`/api/v1/notifications/${params.id}`)
    return { notifications: res.data.notifications }
  },
  data () {
    return {
      page: 1,
      breadcrumbs: '通知'
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
    }, 0)
  },
  methods: {
    ...mapActions({
      setBreadcrumbs: 'breadcrumbs/setBreadcrumbs',
      setIsActive: 'notification/setIsActive',
      setIsExistsUnreadChat: 'chat/setIsExistsUnreadChat'
    }),
    async subscribe () {
      await this.$cable.subscribe({
        channel: 'RoomChannel',
        room: this.currentUser.uid,
        uid: `${this.currentUser.uid}`
      })
    },
    async pushContents (res) {
      await this.notifications.push(...res.data.notifications)
      await this.setIsActive(true)
    },
    pageIncrement () {
      this.page++
    },
    identifierIncrement () {
      this.$refs.infinite.identifierIncrement()
    }
  }
}
</script>
