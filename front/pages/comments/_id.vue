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
                    <btn-edit-comment-comment
                      :comment="comment"
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
    <comment-comments />
  </layout-main>
</template>

<script>
import { mapGetters } from 'vuex'
import btnDeleteComment from '../../components/btn/deleteComment/btnDeleteComment.vue'
import btnEditCommentComment from '../../components/btn/editComment/btnEditCommentComment.vue'
import btnNewCommentComment from '../../components/btn/commentComment/btnNewCommentComment.vue'
import commentComments from '../../components/comment/commentComments.vue'
import layoutMain from '../../components/layout/loggedIn/layoutMain.vue'
import likeComment from '../../components/btn/like/likeComment.vue'

export default {
  components: {
    layoutMain,
    btnNewCommentComment,
    btnEditCommentComment,
    commentComments,
    btnDeleteComment,
    likeComment
  },
  data () {
    return {
      isIndex: false,
      src: 'https://picsum.photos/500/500'
    }
  },
  computed: {
    ...mapGetters({
      comment: 'comment/comment',
      currentUser: 'auth/data',
      isAuthenticated: 'auth/isAuthenticated',
      btnColor: 'btn/color'
    })
  }
}
</script>
