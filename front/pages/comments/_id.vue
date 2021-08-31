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
                @click="toShowUser(user.id)"
              />
              <v-card-text
                style="cursor: pointer;"
                @click.prevent.stop="toShowUser(user.id)"
              >
                {{ user.name }}
              </v-card-text>
            </v-col>
          </v-row>
          <v-row>
            <v-col>
              <v-card-title
                class="card-content"
              >
                {{ comment.content }}
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
                {{ likeCommentsCount }} 件のいいね
              </v-card-text>
            </v-col>
          </v-row>
          <v-divider class="mx-3" />
          <template v-if="isAuthenticated">
            <v-row>
              <v-col>
                <v-card-actions class="justify-space-around">
                  <btn-new-comment-comment
                    :comment="comment"
                    :user="user"
                    :is-index="isIndex"
                    :comments-count="commentsCount"
                    @fetchComment="fetchComment"
                  />
                  <template v-if="comment.user_id !== currentUser.id">
                    <v-btn
                      :color="btnColor"
                      text
                    >
                      <v-icon v-text="'mdi-twitter-retweet'" />
                    </v-btn>
                  </template>
                  <like-comment
                    :comment="comment"
                    :like-comments="likeComments"
                    :is-index="isIndex"
                    @likeCountIncrement="likeCountIncrement"
                    @likeCountDecrement="likeCountDecrement"
                  />
                  <template v-if="comment.user_id === currentUser.id">
                    <btn-edit-comment
                      :comment="comment"
                      @fetchComment="fetchComment"
                    />
                    <btn-delete-comment
                      :comment="comment"
                      :is-index="isIndex"
                    />
                  </template>
                </v-card-actions>
              </v-col>
            </v-row>
            <v-divider class="mx-3" />
            <page-id-comment-comment
              :comment="comment"
              @fetchComment="fetchComment"
            />
          </template>
        </v-card>
      </v-col>
    </v-row>
    <comment-comments
      :comments="comments"
      :like-comments="likeComments"
      @fetchComment="fetchComment"
    />
  </layout-main>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import LayoutMain from '../../components/layout/loggedIn/layoutMain.vue'
import BtnNewCommentComment from '../../components/btn/commentComment/btnNewCommentComment.vue'
import LikeComment from '../../components/btn/like/likeComment.vue'
import BtnEditComment from '../../components/btn/editComment/btnEditComment.vue'
import BtnDeleteComment from '../../components/btn/deleteComment/btnDeleteComment.vue'
import CommentComments from '../../components/comment/commentComments.vue'
import PageIdCommentComment from '../../components/comment/pageIdCommentComment.vue'

export default {
  components: {
    LayoutMain,
    BtnNewCommentComment,
    LikeComment,
    BtnEditComment,
    BtnDeleteComment,
    CommentComments,
    PageIdCommentComment
  },
  data () {
    return {
      comments: [],
      comment: {},
      user: {},
      time: {},
      likeComments: [],
      likeCommentsCount: 0,
      commentsCount: 0,
      isIndex: false,
      src: 'https://picsum.photos/500/500'
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
    this.fetchComment()
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage'
    }),
    async fetchComment () {
      const url = `/api/v1/comments/${this.$route.params.id}`
      await this.$axios.get(url)
        .then((res) => {
          this.comment = res.data
          this.user = res.data.user
          this.time = this.$my.format(this.comment.created_at)
          this.likeComments = this.comment.like_comments
          this.likeCommentsCount = this.comment.like_comments.length
          this.searchAndSetComments()
        })
    },
    async searchAndSetComments () {
      const url = `api/v1/search_comments/${this.comment.id}`
      await this.$axios.get(url)
        .then((res) => {
          this.comments = res.data
          this.commentsCount = res.data.length
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    likeCountIncrement () {
      this.likeCommentsCount++
    },
    likeCountDecrement () {
      this.likeCommentsCount--
    },
    toShowUser (id) {
      this.$router.push(`/users/${id}`)
    }
  }
}
</script>
