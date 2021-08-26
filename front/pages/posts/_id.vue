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
                    <btn-edit-post-in-id
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
    <post-comment
      :post="post"
    />
  </layout-main>
</template>

<script>
import { mapGetters } from 'vuex'
import BtnDeletePost from '../../components/btn/deletePost/btnDeletePost.vue'
import LayoutMain from '../../components/layout/loggedIn/layoutMain.vue'
import PostComment from '../../components/comment/postComment.vue'
import BtnEditPostInId from '../../components/btn/editPost/btnEditPostInId.vue'
import LikePost from '../../components/btn/like/likePost.vue'
import BtnNewComment from '../../components/btn/comment/btnNewComment.vue'

export default {
  components: {
    BtnDeletePost,
    LayoutMain,
    PostComment,
    BtnEditPostInId,
    LikePost,
    BtnNewComment
  },
  middleware: 'authenticated',
  data () {
    return {
      src: 'https://picsum.photos/200/200',
      isIndex: false
    }
  },
  computed: {
    ...mapGetters({
      post: 'post/post',
      currentUser: 'auth/data',
      isAuthenticated: 'auth/isAuthenticated',
      btnColor: 'btn/color'
    })
  }
}
</script>
