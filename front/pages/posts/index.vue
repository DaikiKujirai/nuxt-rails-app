<template>
  <layout-main #layout-main> <!--eslint-disable-line-->
    <template v-if="isAuthenticated">
      <home-new-post
        @rollBackPage="rollBackPage"
        @fetchContents="fetchContents"
      />
    </template>
    <v-row
      v-for="post in posts"
      :key="post.id"
      class="pb-1"
    >
      <v-col>
        <v-card
          @click="toShow('posts', post.id)"
        >
          <post-card
            :post="post"
            :user="post.user"
          />
          <template v-if="isAuthenticated">
            <actions
              :post="post"
              :user="post.user"
              :likes="post.likes"
              :is-list="isList"
              @fetchContents="fetchContents"
              @rollBackPage="rollBackPage"
            />
          </template>
        </v-card>
      </v-col>
    </v-row>
    <infinite-scroll
      ref="infinite"
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
import HomeNewPost from '../../components/post/homeNewPost.vue'
import Actions from '../../components/loggedIn/mainCard/actions.vue'
import PostCard from '../../components/post/postCard.vue'
import InfiniteScroll from '../../components/ui/infiniteScroll.vue'

export default {
  components: {
    LayoutMain,
    HomeNewPost,
    Actions,
    PostCard,
    InfiniteScroll
  },
  async asyncData ({ $axios }) {
    const res = await $axios.get('/api/v1/posts')
    return { posts: res.data.posts }
  },
  data () {
    return {
      page: 1,
      url: '/api/v1/posts',
      isList: true,
      breadcrumbs: '全ての投稿',
      channel: ''
    }
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
  computed: {
    ...mapGetters({
      currentUser: 'auth/data',
      isAuthenticated: 'auth/isAuthenticated',
      isNewPost: 'post/isNewPost',
      deletePost: 'post/deletePost',
      isCatchMessage: 'chat/isCatchMessage',
      reacquireData: 'post/reacquireData'
    })
  },
  watch: {
    async isNewPost (bool) {
      if (bool) {
        await window.scrollTo({
          top: 0,
          behavior: 'auto'
        })
        await this.fetchContents()
        await this.setIsNewPost(false)
      }
    },
    deletePost (val) {
      if (val.bool) {
        this.posts = this.posts.filter(post => post.id !== val.post.id)
        this.setDeletePost({ bool: false, post: {} })
      }
    },
    async reacquireData (bool) {
      console.log(bool)
      if (bool) {
        await window.scrollTo({
          top: 0,
          behavior: 'auto'
        })
        await this.fetchContents()
        await this.setReacquireData(false)
      }
    }
  },
  created () {
    this.setBreadcrumbs(this.breadcrumbs)
  },
  mounted () {
    if (this.isAuthenticated) {
      setTimeout(() => {
        this.subscribe()
      }, 0)
    }
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage',
      setIsNewPost: 'post/setIsNewPost',
      setDeletePost: 'post/setDeletePost',
      setBreadcrumbs: 'breadcrumbs/setBreadcrumbs',
      setIsActive: 'notification/setIsActive',
      pushNotification: 'notification/pushNotification',
      setIsExistsUnreadChat: 'chat/setIsExistsUnreadChat',
      setReacquireData: 'post/setReacquireData'
    }),
    async fetchContents () {
      await this.$axios.get(this.url)
        .then((res) => {
          this.rollBackPage()
          this.posts = res.data.posts
          this.identifierIncrement()
        })
        .catch((err) => {
          this.flashMessage({ message: err.errors.messages, type: 'error', status: true })
        })
    },
    async subscribe () {
      await this.$cable.subscribe({
        channel: 'RoomChannel',
        room: this.currentUser.uid,
        uid: `${this.currentUser.uid}`
      })
    },
    toShow (page, id) {
      this.$router.push(`/${page}/${id}`)
    },
    rollBackPage () {
      this.page = 1
    },
    pageIncrement () {
      this.page++
    },
    pushContents (res) {
      this.posts.push(...res.data.posts)
    },
    identifierIncrement () {
      this.$refs.infinite.identifierIncrement()
    }
  }
}
</script>
