<template>
  <layout-main #layout-main> <!--eslint-disable-line-->
    <v-row class="mt-2">
      <v-col>
        <v-card>
          <v-row>
            <v-col
              class="d-flex"
            >
              <v-img
                :src="src"
                max-height="70"
                max-width="70"
                contain
                style="border-radius: 50%; cursor: pointer;"
                class="ml-3"
                @click.prevent.stop="toShowUser(post.user_id)"
              />
              <v-card-title
                style="cursor: pointer;"
                @click.prevent.stop="toShowUser(post.user_id)"
              >
                {{ user.name }}
              </v-card-title>
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
          <v-row>
            <v-col>
              <v-card-text>
                <v-icon
                  size="16"
                  v-text="'mdi-update'"
                />
                {{ time }}
              </v-card-text>
            </v-col>
          </v-row>
          <v-divider class="mx-3" />
          <v-row>
            <v-col class="d-flex text-center">
              <v-card-text>
                0 件のリツイート
              </v-card-text>
              <v-card-text>
                {{ commentsCount }} 件のコメント
              </v-card-text>
              <v-card-text>
                {{ likeCount }} 件のいいね
              </v-card-text>
            </v-col>
          </v-row>
          <v-divider class="mx-3" />
          <template v-if="isAuthenticated">
            <v-row>
              <v-col>
                <v-card-actions class="justify-space-around">
                  <btn-new-comment
                    :post="post"
                    :user="user"
                    :comments="comments"
                    :is-index="isIndex"
                    @fetchPost="fetchPost"
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
                    :like-posts="likePosts"
                    :like-post-count="likeCount"
                    @likeCountIncrement="likeCountIncrement"
                    @likeCountDecrement="likeCountDecrement"
                  />
                  <template v-if="post.user_id === currentUser.id">
                    <btn-edit-post
                      :post="post"
                      :is-index="isIndex"
                      @fetchPost="fetchPost"
                    />
                    <btn-delete-post
                      :post="post"
                      :is-index="isIndex"
                      @fetchPost="fetchPost"
                    />
                  </template>
                </v-card-actions>
                <v-divider class="mx-3" />
              </v-col>
            </v-row>
            <page-id-post-comment-form
              :post="post"
              @fetchPost="fetchPost"
            />
          </template>
        </v-card>
      </v-col>
    </v-row>
    <post-comment
      :post="post"
      :user="user"
      @fetchPost="fetchPost"
    />
  </layout-main>
</template>

<script>
import { mapGetters } from 'vuex'
import LayoutMain from '../../components/layout/loggedIn/layoutMain.vue'
import BtnNewComment from '../../components/btn/comment/btnNewComment.vue'
import LikePost from '../../components/btn/like/likePost.vue'
import BtnEditPost from '../../components/btn/editPost/btnEditPost.vue'
import BtnDeletePost from '../../components/btn/deletePost/btnDeletePost.vue'
import PostComment from '../../components/comment/postComments.vue'
import PageIdPostCommentForm from '../../components/comment/pageIdPostComment.vue'

export default {
  components: {
    LayoutMain,
    BtnNewComment,
    LikePost,
    BtnEditPost,
    PostComment,
    BtnDeletePost,
    PageIdPostCommentForm
  },
  data () {
    return {
      post: {},
      user: {},
      comments: [],
      likePosts: [],
      commentsCount: 0,
      likeCount: 0,
      time: '',
      src: 'https://picsum.photos/200/200',
      isIndex: false
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data',
      isAuthenticated: 'auth/isAuthenticated',
      btnColor: 'btn/color'
    })
  },
  created () {
    this.fetchPost()
  },
  methods: {
    async fetchPost () {
      const url = `/api/v1/posts/${this.$route.params.id}`
      await this.$axios.get(url)
        .then((res) => {
          this.post = res.data
          this.user = res.data.user
          this.comments = res.data.comments
          this.commentsCount = res.data.comments.length
          this.likePosts = res.data.like_posts
          this.likeCount = res.data.like_posts.length
          this.time = this.$my.format(this.post.created_at)
        })
    },
    likeCountIncrement () {
      this.likeCount++
    },
    likeCountDecrement () {
      this.likeCount--
    },
    toShowUser (id) {
      this.$router.push(`/users/${id}`)
    }
  }
}
</script>
