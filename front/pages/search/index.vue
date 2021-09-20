<template>
  <layout-main #layout-main> <!--eslint-disable-line-->
    <template v-if="isAuthenticated">
      <home-new-post
        @rollBackPage="rollBackPage"
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
        :user-id="currentUser.id"
        @pushContents="pushContents"
        @pageIncrement="pageIncrement"
      />
    </template>
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
  data () {
    return {
      posts: [],
      page: 1,
      url: '/api/v1/search',
      isList: true,
      breadcrumbs: 'で検索',
      q: this.searchWord
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data',
      isAuthenticated: 'auth/isAuthenticated',
      isNewPost: 'post/isNewPost',
      deletePost: 'post/deletePost',
      searchWord: 'search/searchWord',
      fetchSearchContents: 'search/fetchSearchContents',
      searchPageName: 'search/searchPageName'
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
          this.rollBackPage()
          this.fetchContents()
          this.identifierIncrement()
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
    },
    async fetchSearchContents (bool) {
      if (bool) {
        await window.scrollTo({
          top: 0,
          behavior: 'smooth'
        })
        await setTimeout(() => {
          this.rollBackPage()
          this.fetchContents()
          this.identifierIncrement()
          this.setSearchContents(false)
        }, 1000)
      }
    }
  },
  created () {
    this.setBreadcrumbs(this.breadcrumbs)
  },
  mounted () {
    setTimeout(() => {
      this.fetchContents()
    }, 0)
  },
  destroyed () {
    this.setSearchWord('')
    this.setSearchPageName('')
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage',
      setIsNewPost: 'post/setIsNewPost',
      setDeletePost: 'post/setDeletePost',
      setBreadcrumbs: 'breadcrumbs/setBreadcrumbs',
      setSearchWord: 'search/setSearchWord',
      setSearchContents: 'search/setFetchSearchContents',
      setSearchPageName: 'search/setSearchPageName'
    }),
    async fetchContents () {
      await this.$axios.get(this.url, {
        params: {
          q: this.searchWord,
          page_name: this.searchPageName,
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
