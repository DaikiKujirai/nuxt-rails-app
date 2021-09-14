<template>
  <layout-main #layout-main> <!--eslint-disable-line-->
    <v-row>
      <v-col>
        <v-card
          v-for="notification in notifications"
          :key="notification.id"
          class="mb-4"
        >
          <card-template
            :notification="notification"
          />
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
import CardTemplate from '../../components/notification/cardTemplate.vue'
import InfiniteScroll from '../../components/ui/infiniteScroll.vue'

export default {
  components: {
    layoutMain,
    CardTemplate,
    InfiniteScroll
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
