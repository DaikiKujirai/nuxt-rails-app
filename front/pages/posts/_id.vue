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
                {{ likesCount }} 件のいいね
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
                    :is-index="isIndex"
                    @fetchPost="fetchPost"
                    @fetchCommentsCount="commentsCount = $event"
                    @commentsCountIncrement="commentsCountIncrement"
                    @commentsCountDecrement="commentsCountDecrement"
                  />
                  <template v-if="post.user_id !== currentUser.id">
                    <v-btn
                      :color="btnColor"
                      text
                    >
                      <v-icon v-text="'mdi-twitter-retweet'" />
                    </v-btn>
                  </template>
                  <like
                    :post="post"
                    :likes="likes"
                    :is-index="isIndex"
                    @likesCountIncrement="likesCountIncrement"
                    @likesCountDecrement="likesCountDecrement"
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
            <page-id-comment-form
              :post="post"
              @fetchPost="fetchPost"
              @commentsCountIncrement="commentsCountIncrement"
            />
          </template>
        </v-card>
      </v-col>
    </v-row>
    <comments
      :post="post"
      :user="user"
      :comments="sortComments"
      @fetchPost="fetchPost"
      @commentsCountDecrement="commentsCountDecrement"
    />
  </layout-main>
</template>

<script>
import { mapGetters } from 'vuex'
import LayoutMain from '../../components/layout/loggedIn/layoutMain.vue'
import BtnNewComment from '../../components/btn/comment/btnNewComment.vue'
import Like from '../../components/btn/like/like.vue'
import BtnEditPost from '../../components/btn/editPost/btnEditPost.vue'
import BtnDeletePost from '../../components/btn/deletePost/btnDeletePost.vue'
import PageIdCommentForm from '../../components/comment/pageIdCommentForm.vue'
import Comments from '../../components/comment/comments.vue'

export default {
  components: {
    LayoutMain,
    BtnNewComment,
    Like,
    BtnEditPost,
    BtnDeletePost,
    PageIdCommentForm,
    Comments
  },
  data () {
    return {
      post: {},
      user: {},
      likes: [],
      comments: [],
      commentsCount: 0,
      likesCount: 0,
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
    }),
    sortComments () {
      const userComments = this.comments
      return userComments.sort((a, b) => {
        if (a.created_at > b.created_at) { return -1 }
        if (a.created_at < b.created_at) { return 1 }
        return 0
      })
    }
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
          this.likes = res.data.likes
          this.likesCount = res.data.likes.length
          this.time = this.$my.format(this.post.created_at)
          this.fetchComments()
        })
    },
    async fetchComments () {
      const url = `/api/v1/find_comments/${this.$route.params.id}`
      await this.$axios.get(url)
        .then((res) => {
          this.comments = res.data
        })
    },
    likesCountIncrement () {
      this.likesCount++
    },
    likesCountDecrement () {
      this.likesCount--
    },
    commentsCountIncrement () {
      this.commentsCount++
    },
    commentsCountDecrement () {
      this.commentsCount--
    },
    toShowUser (id) {
      this.$router.push(`/users/${id}`)
    }
  }
}
</script>
