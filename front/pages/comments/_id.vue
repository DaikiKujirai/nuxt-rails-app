<template>
  <layout-main #layout-main> <!--eslint-disable-line-->
    <v-row>
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
                style="border-radius: 50%;"
                class="ml-3"
              />
              <v-card-text>
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
                <!-- {{ likeCount }} 件のいいね -->
              </v-card-text>
            </v-col>
          </v-row>
          <v-divider class="mx-3" />
          <template v-if="isAuthenticated">
            <v-row>
              <v-col>
                <v-card-actions class="justify-space-around">
                  <!-- <btn-new-comment-comment
                    :comment="comment"
                    :is-index="isIndex"
                  /> -->
                  <template v-if="comment.user_id !== currentUser.id">
                    <v-btn
                      :color="btnColor"
                      text
                    >
                      <v-icon v-text="'mdi-twitter-retweet'" />
                    </v-btn>
                  </template>
                  <!-- <like-comment
                    :comment="comment"
                  /> -->
                  <template v-if="comment.user_id === currentUser.id">
                    <!-- <btn-edit-comment
                      :comment="comment"
                      :is-index="isIndex"
                    /> -->
                    <!-- <btn-delete-comment
                      :comment="comment"
                      :is-index="isIndex"
                    /> -->
                  </template>
                </v-card-actions>
              </v-col>
            </v-row>
          </template>
        </v-card>
      </v-col>
    </v-row>
    <!-- <comment-comments /> -->
  </layout-main>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import LayoutMain from '../../components/layout/loggedIn/layoutMain.vue'
// import BtnDeleteComment from '../../components/btn/deleteComment/btnDeleteComment.vue'
// import BtnEditComment from '../../components/btn/editComment/btnEditComment.vue'
// import BtnNewCommentComment from '../../components/btn/commentComment/btnNewCommentComment.vue'
// import CommentComments from '../../components/comment/commentComments.vue'
// import LikeComment from '../../components/btn/like/likeComment.vue'

export default {
  components: {
    LayoutMain
    // BtnNewCommentComment,
    // BtnEditComment,
    // CommentComments,
    // BtnDeleteComment,
    // LikeComment
  },
  data () {
    return {
      comment: {},
      user: {},
      time: {},
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
  mounted () {
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
        })
    }
  }
}
</script>
