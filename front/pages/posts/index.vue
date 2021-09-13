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
        class="mb-1"
      >
        <v-col>
          <v-card
            @click="toShow('posts', post.id)"
          >
            <post-card
              :post="post"
            />
            <template v-if="isAuthenticated">
              <actions
                :post="post"
                :is-list="isList"
                @fetchContents="fetchContents"
                @rollBackPage="rollBackPage"
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
      url: '/api/v1/posts',
      isList: true
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data',
      isAuthenticated: 'auth/isAuthenticated',
      isPost: 'post/isPost'
    })
  },
  watch: {
    isPost (val) {
      if (val) {
        this.fetchContents()
        this.setIsPost(false)
      }
    }
  },
  created () {
    this.fetchContents()
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage',
      setIsPost: 'post/setIsPost'
    }),
    async fetchContents () {
      await this.$axios.get(this.url)
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
    }
  }
}
</script>
