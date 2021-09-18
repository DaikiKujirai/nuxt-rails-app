<template>
  <layout-main #layout-main> <!--eslint-disable-line-->
    <template v-if="isAuthenticated">
      <home-new-post
        @fetchContents="fetchContents"
      />
    </template>
    <template v-if="posts">
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
              />
            </template>
          </v-card>
        </v-col>
      </v-row>
      <infinite-scroll
        :page="page"
        :url="url"
        @pushContents="pushContents"
        @pageIncrement="pageIncrement"
      />
    </template>
  </layout-main>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import LayoutMain from '../components/layout/loggedIn/layoutMain.vue'
import Actions from '../components/loggedIn/mainCard/actions.vue'
import HomeNewPost from '../components/post/homeNewPost.vue'
import PostCard from '../components/post/postCard.vue'
import InfiniteScroll from '../components/ui/infiniteScroll.vue'

export default {
  components: {
    HomeNewPost,
    LayoutMain,
    PostCard,
    Actions,
    InfiniteScroll
  },
  async asyncData ({ $axios, params }) {
    console.log(params.id)
    const res = await $axios.get(`/api/v1/home/${params.id}`)
    return { posts: res.data.posts }
  },
  data () {
    return {
      posts: [],
      page: 1,
      url: '/api/v1/',
      isList: true,
      breadcrumbs: 'ホーム'
    }
  },
  // async fetch ({ $axios, store }) {
  //   // console.log(context)
  //   const res = await $axios.get('/api/v1/', {
  //     params: {
  //       user_id: store.state.auth.data.id
  //     }
  //   })
  //   return { posts: res.data.posts }
  // },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data',
      isAuthenticated: 'auth/isAuthenticated',
      isNewPost: 'post/isNewPost',
      deletePost: 'post/deletePost'
    })
  },
  watch: {
    isNewPost (bool) {
      if (bool) {
        this.fetchContents()
        this.setIsNewPost(false)
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
  mounted () {
    this.setBreadcrumbs(this.breadcrumbs)
    this.fetchContents()
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage',
      setIsNewPost: 'post/setIsNewPost',
      setDeletePost: 'post/setDeletePost',
      setBreadcrumbs: 'breadcrumbs/setBreadcrumbs'
    }),
    async fetchContents () {
      await this.$axios.get(this.url, {
        params: {
          user_id: this.currentUser.id
        }
      })
        .then((res) => {
          this.posts = res.data.posts
        })
        .catch((err) => {
          this.flashMessage({ message: err.errors.messages, type: 'error', status: true })
        })
    },
    toShow (page, id) {
      this.$router.push(`/${page}/${id}`)
    },
    pageIncrement () {
      this.page++
    },
    pushContents (res) {
      this.posts.push(...res.data.posts)
    }
  }
}
</script>
