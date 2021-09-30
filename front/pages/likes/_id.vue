<template>
  <layout-main #layout-main> <!--eslint-disable-line-->
    <v-row
      v-for="like in likes"
      :key="like.id"
    >
      <v-col class="pa-2">
        <v-card
          @click="toShow('users', like.user.id)"
        >
          <user-template
            :user="like.user"
          />
        </v-card>
      </v-col>
    </v-row>
    <infinite-scroll
      :page="page"
      :url="url"
      @pushContents="pushContents"
      @pageIncrement="pageIncrement"
    />
  </layout-main>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import LayoutMain from '../../components/layout/loggedIn/layoutMain.vue'
import InfiniteScroll from '../../components/ui/infiniteScroll.vue'
import userTemplate from '../../components/user/userTemplate.vue'

export default {
  components: {
    userTemplate,
    InfiniteScroll,
    LayoutMain
  },
  channels: {
    RoomChannel: {
      connected () {
      },
      received (data) {
        if (data.category === 'chat') {
          this.setIsExistsUnreadChat(true)
        }
        this.setIsActive(true)
        this.pushNotification(data)
      },
      disconnected () {
        // eslint-disable-next-line no-console
        console.log('disconnected')
      }
    }
  },
  async asyncData ({ $axios, params }) {
    const res = await $axios.get(`/api/v1/likes/${params.id}`)
    return { likes: res.data.likes }
  },
  data () {
    return {
      page: 1,
      url: `/api/v1/likes/${this.$route.params.id}`,
      breadcrumbs: 'いいねしたユーザー'
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
      pushNotification: 'notification/pushNotification',
      setIsExistsUnreadChat: 'chat/setIsExistsUnreadChat'
    }),
    async subscribe () {
      await this.$cable.subscribe({
        channel: 'RoomChannel',
        room: this.currentUser.uid,
        uid: `${this.currentUser.uid}`
      })
    },
    rollBackPage () {
      this.page = 1
    },
    pageIncrement () {
      this.page++
    },
    pushContents (res) {
      this.likes.push(...res.data.likes)
    },
    toShow (page, id) {
      this.$router.push(`/${page}/${id}`)
    }
  }
}
</script>
