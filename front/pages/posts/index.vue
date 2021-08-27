<template>
  <layout-main #layout-main> <!--eslint-disable-line-->
    <home-new-post />
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
                    <btn-edit-post
                      :post="post"
                      :is-index="isIndex"
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
import BtnEditPost from '../../components/btn/editPost/btnEditPost.vue'
import LayoutMain from '../../components/layout/loggedIn/layoutMain.vue'
import BtnNewComment from '../../components/btn/comment/btnNewComment.vue'
import BtnDeletePost from '../../components/btn/deletePost/btnDeletePost.vue'
import LikePost from '../../components/btn/like/likePost.vue'
import HomeNewPost from '../../components/post/homeNewPost.vue'

export default {
  components: {
    LayoutMain,
    BtnNewComment,
    BtnEditPost,
    BtnDeletePost,
    LikePost,
    HomeNewPost
  },
  data () {
    return {
      posts: [],
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
  mounted () {
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
          this.posts = res.data
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    toShow (id) {
      this.$router.push(`posts/${id}`)
    }
  }
}
</script>

<style scoped>
</style>
