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
import ActionCable from 'actioncable'
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
  computed: {
    ...mapGetters({
      currentUser: 'auth/data',
      isAuthenticated: 'auth/isAuthenticated',
      isNewPost: 'post/isNewPost',
      deletePost: 'post/deletePost'
    })
  },
  watch: {
    async isNewPost (bool) {
      if (bool) {
        await window.scrollTo({
          top: 0,
          behavior: 'smooth'
        })
        await setTimeout(() => {
          this.fetchContents()
          this.setIsNewPost(false)
        }, 1000)
      }
    },
    deletePost (val) {
      if (val.bool) {
        const posts = this.posts.filter(post => post.id !== val.post.id)
        this.posts = posts
        this.setDeletePost({ bool: false, post: {} })
      }
    }
  },
  created () {
    this.setBreadcrumbs(this.breadcrumbs)
  },
  mounted () {
    setTimeout(() => {
      const cable = ActionCable.createConsumer('ws://localhost:3000/cable')
      this.channel = cable.subscriptions.create({
        channel: 'RoomChannel',
        uid: this.currentUser.uid
      }, {
        connected () {
          console.log('connected')
        },
        disconnected () {
          console.log('disconnected')
        },
        received (data) {
          console.log('received!!', data)
        }
      })
    }, 0)
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage',
      setIsNewPost: 'post/setIsNewPost',
      setDeletePost: 'post/setDeletePost',
      setBreadcrumbs: 'breadcrumbs/setBreadcrumbs'
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
