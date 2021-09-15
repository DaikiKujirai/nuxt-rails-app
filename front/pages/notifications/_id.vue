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
            />
          </template>
          <template v-else-if="notification.action === 'chat'">
            <chat-card
              :notification="notification"
            />
          </template>
          <template v-else>
            <like-comment-card
              :notification="notification"
            />
          </template>
        </v-card>
      </v-col>
    </v-row>
    <infinite-scroll
      :page="page"
      :url="`/api/v1/notifications/${currentUser.id}`"
      @pushContents="pushContents"
      @pageIncrement="pageIncrement"
    />
  </layout-main>
</template>

<script>
import { mapGetters } from 'vuex'
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
  data () {
    return {
      notifications: [],
      page: 1
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data'
    })
  },
  mounted () {
    setTimeout(() => {
      this.fetchContents()
    })
  },
  methods: {
    async fetchContents () {
      const url = `/api/v1/notifications/${this.currentUser.id}`
      await this.$axios.get(url)
        .then((res) => {
          this.notifications = res.data.notifications
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    rollBackPage () {
      this.page = 1
    },
    pushContents (res) {
      this.notifications.push(...res.data.notifications)
    },
    pageIncrement () {
      this.page++
    }
  }
}
</script>
