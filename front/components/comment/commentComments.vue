<template>
  <div>
    <v-row
      v-for="comment in comments"
      :key="comment.id"
    >
      <v-col>
        <v-card
          @click="toShow(comment)"
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
                {{ comment.user.name }}
              </v-card-text>
              <v-card-text
                class="text-right"
              >
                <v-icon
                  size="16"
                  v-text="'mdi-update'"
                />
                {{ $my.format(comment.created_at) }}
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
          <template v-if="isAuthenticated">
            <v-row>
              <v-col>
                <v-card-actions class="justify-space-around">
                  <btn-new-comment-comment
                    :comment="comment"
                    :is-index="isIndex"
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
                  />
                  <template v-if="comment.user_id === currentUser.id">
                    <btn-edit-comment
                      :comment="comment"
                      :is-index="isIndex"
                    />
                    <btn-delete-comment
                      :comment="comment"
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
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import BtnDeleteComment from '../btn/deleteComment/btnDeleteComment.vue'
import LikeComment from '../btn/like/likeComment.vue'
import BtnNewCommentComment from '../btn/commentComment/btnNewCommentComment.vue'
import BtnEditComment from '../btn/editComment/btnEditComment.vue'

export default {
  components: {
    BtnNewCommentComment,
    BtnDeleteComment,
    LikeComment,
    BtnEditComment
  },
  data () {
    return {
      isIndex: true,
      src: 'https://picsum.photos/500/500'
    }
  },
  computed: {
    ...mapGetters({
      comments: 'comment/comments',
      currentUser: 'auth/data',
      isAuthenticated: 'auth/isAuthenticated',
      btnColor: 'btn/color'
    })
  },
  methods: {
    ...mapActions({
      setComments: 'comment/setComments',
      setComment: 'comment/setComment'
    }),
    async toShow (comment) {
      const url = `api/v1/comments/${comment.id}`
      await this.$axios.get(url)
        .then((res) => {
          this.searchAndSetComments(res.data.id)
          this.setComment(res.data)
          this.$router.push(`/comments/${comment.id}`)
        })
    },
    async searchAndSetComments (id) {
      const url = `api/v1/search_comments/${id}`
      await this.$axios.get(url)
        .then((res) => {
          this.setComments(res.data)
          console.log('commentcomment', res.data)
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    }
  }
}
</script>
