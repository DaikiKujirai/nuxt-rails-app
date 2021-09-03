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
                :is-index="isIndex"
                @fetchContents="fetchContents"
                @rollBackPage="rollBackPage"
              />
            </template>
          </v-card>
        </v-col>
      </v-row>
      <infinite-scroll
        :posts="posts"
        :page="page"
        :url="url"
        @pushPosts="pushPosts"
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

export default {
  components: {
    LayoutMain,
    HomeNewPost,
    Actions,
    PostCard
  },
  data () {
    return {
      posts: [],
      page: 1,
      url: '/api/v1/posts',
      src: 'https://picsum.photos/200/200',
      isIndex: true
    }
  },
  computed: {
    ...mapGetters({
      btnColor: 'btn/color',
      currentUser: 'auth/data',
      isAuthenticated: 'auth/isAuthenticated'
    })
  },
  created () {
    this.fetchContents()
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage'
    }),
    async fetchContents () {
      const url = '/api/v1/posts'
      await this.$axios.get(url)
        .then((res) => {
          this.posts = res.data.posts
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
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
    pushPosts (res) {
      this.posts.push(...res.data.posts)
    }
  }
}
</script>
