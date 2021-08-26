<template>
  <layout-main #layout-main> <!--eslint-disable-line-->
    <v-row
      v-for="post in posts"
      :key="post.id"
    >
      <v-col>
        <v-card
          @click="toShow(post.id)"
        >
          <v-row>
            <v-col
              class="d-flex"
            >
              <v-img
                :src="src"
                max-height="70"
                max-width="70"
                contain
                style="border-radius: 50%;"
                class="ml-3"
              />
              <v-card-text>
                {{ post.user.name }}
              </v-card-text>
              <v-card-text
                class="text-right"
              >
                <v-icon
                  size="16"
                  v-text="'mdi-update'"
                />
                {{ $my.format(post.created_at) }}
              </v-card-text>
            </v-col>
          </v-row>
          <v-row>
            <v-col>
              <v-card-title
                class="card-content"
              >
                {{ post.content }}
              </v-card-title>
            </v-col>
          </v-row>
          <template v-if="isAuthenticated">
            <v-row>
              <v-col>
                <v-card-actions class="justify-space-around">
                  <btn-new-comment
                    :post="post"
                    :is-index="isIndex"
                  />
                  <template v-if="post.user_id !== currentUser.id">
                    <v-btn
                      :color="btnColor"
                      text
                    >
                      <v-icon v-text="'mdi-twitter-retweet'" />
                    </v-btn>
                  </template>
                  <like-post
                    :post="post"
                  />
                  <template v-if="post.user_id === currentUser.id">
                    <btn-edit-post-in-index
                      :post="post"
                    />
                    <btn-delete-post
                      :post="post"
                      :is-index="isIndex"
                    />
                  </template>
                </v-card-actions>
              </v-col>
            </v-row>
          </template>
        </v-card>
      </v-col>
    </v-row>
  </layout-main>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import btnEditPostInIndex from '../../components/btn/editPost/btnEditPostInIndex.vue'
import layoutMain from '../../components/layout/loggedIn/layoutMain.vue'
import btnNewComment from '../../components/btn/comment/btnNewComment.vue'
import btnDeletePost from '../../components/btn/deletePost/btnDeletePost.vue'
import likePost from '../../components/btn/like/likePost.vue'

export default {
  components: {
    layoutMain,
    btnNewComment,
    btnEditPostInIndex,
    btnDeletePost,
    likePost
  },
  data () {
    return {
      src: 'https://picsum.photos/200/200',
      isIndex: true
    }
  },
  computed: {
    ...mapGetters({
      posts: 'post/posts',
      btnColor: 'btn/color',
      currentUser: 'auth/data',
      isAuthenticated: 'auth/isAuthenticated',
      likePosts: 'like/likePosts'
    })
  },
  mounted () {
    this.fetchContents()
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage',
      setPosts: 'post/setPosts',
      setPost: 'post/setPost',
      setLikePosts: 'like/setLikePosts',
      setLikeComments: 'like/setLikeComments'
    }),
    async fetchContents () {
      const url = '/api/v1/posts'
      await this.$axios.get(url)
        .then((res) => {
          this.setPosts(res.data)
          if (this.isAuthenticated) {
            this.setCurrentUserData()
          }
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    async setCurrentUserData () {
      const url = `/api/v1/users/${this.currentUser.id}`
      await this.$axios.get(url)
        .then((res) => {
          this.setLikePosts(res.data.like_posts)
          this.setLikeComments(res.data.like_comments)
        })
    },
    async toShow (id) {
      const url = `/api/v1/posts/${id}`
      await this.$axios.get(url)
        .then((res) => {
          this.setPost(res.data)
          this.$router.push(`posts/${id}`)
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    }
  }
}
</script>

<style scope>
</style>
