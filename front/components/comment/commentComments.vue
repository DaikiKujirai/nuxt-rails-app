<template>
  <div class="mt-3">
    <v-row
      v-for="comment in comments"
      :key="comment.id"
      class="mb-1"
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
                    :user="comment.user"
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
                    :like-comments="comment.like_comments"
                    :is-index="isIndex"
                  />
                  <template v-if="comment.user_id === currentUser.id">
                    <btn-edit-comment
                      :comment="comment"
                      @fetchComment="fetchComment"
                    />
                    <btn-delete-comment
                      :comment="comment"
                      :is-index="isIndex"
                      @fetchComment="fetchComment"
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
import { mapGetters } from 'vuex'
import BtnNewCommentComment from '../btn/commentComment/btnNewCommentComment.vue'
import LikeComment from '../btn/like/likeComment.vue'
import BtnEditComment from '../btn/editComment/btnEditComment.vue'
import BtnDeleteComment from '../btn/deleteComment/btnDeleteComment.vue'

export default {
  components: {
    BtnNewCommentComment,
    LikeComment,
    BtnEditComment,
    BtnDeleteComment
  },
  props: {
    comments: {
      type: Array,
      required: true
    }
  },
  data () {
    return {
      user: {},
      likeComments: [],
      isIndex: true,
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
  methods: {
    toShow (comment) {
      this.$router.push(`/comments/${comment.id}`)
    },
    fetchComment () {
      this.$emit('fetchComment')
    }
  }
}
</script>
