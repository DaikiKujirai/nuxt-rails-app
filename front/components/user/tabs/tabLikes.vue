<template>
  <v-tab-item class="mb-2">
    <!-- <v-row
      v-for="like in userLikes"
      :key="like.id"
      style="cursor: pointer;"
      @click="toShow('posts', like.post_id)"
    >
      <v-col>
        <v-divider />
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
              class="ml-3 mt-3"
            />
            <v-col cols="7">
              <v-card-title>
                {{ like.post.post_user_name }}
              </v-card-title>
            </v-col>
            <v-card-text
              class="text-right"
            >
              <v-icon
                size="16"
                v-text="'mdi-update'"
              />
              {{ $my.format(like.post.created_at) }}
            </v-card-text>
          </v-col>
        </v-row>
        <v-row>
          <v-col>
            <v-card-title
              class="card-content"
            >
              {{ like.post.content }}
            </v-card-title>
          </v-col>
        </v-row>
        <template v-if="isAuthenticated">
          <v-row>
            <v-col>
              <v-card-actions class="justify-space-around pa-0">
                <template v-if="postOrComment.comment_id">
                  <btn-new-comment-comment
                    :comment="postOrComment"
                    :user="postOrComment.user"
                    :is-index="isIndex"
                  />
                </template>
                <template v-else>
                  <btn-new-comment
                    :post="postOrComment"
                    :user="postOrComment.user"
                    :comments="postOrComment.comments"
                    :is-index="isIndex"
                  />
                </template>
                <template v-if="like.post.user_id !== currentUser.id">
                  <v-btn
                    :color="btnColor"
                    text
                  >
                    <v-icon v-text="'mdi-twitter-retweet'" />
                  </v-btn>
                </template>
                <like-post
                  :post="post"
                  :like-posts="post.like_posts"
                />
                <template v-if="like.post.user_id === currentUser.id">
                  <btn-edit-post
                    :post="post"
                    :is-index="isIndex"
                    @fetchUser="fetchUser"
                  />
                  <btn-delete-post
                    :post="post"
                    :is-index="isIndex"
                    @fetchUser="fetchUser"
                  />
                </template>
              </v-card-actions>
            </v-col>
          </v-row>
        </template>
      </v-col>
    </v-row> -->
  </v-tab-item>
</template>

<script>
import { mapGetters } from 'vuex'
// import BtnNewComment from '../../btn/comment/btnNewComment.vue'
// import btnNewCommentComment from '../../btn/commentComment/btnNewCommentComment.vue'

export default {
  components: {
    // btnNewCommentComment,
    // BtnNewComment
  },
  props: {
  },
  data () {
    return {
      isIndex: true,
      src: 'https://picsum.photos/500/500'
    }
  },
  computed: {
    ...mapGetters({
      isAuthenticated: 'auth/isAuthenticated',
      currentUser: 'auth/data'
    })
    // userLikes () {
    //   const userLikes = this.likes
    //   return userLikes.sort((a, b) => {
    //     if (a.created_at > b.created_at) { return -1 }
    //     if (a.created_at < b.created_at) { return 1 }
    //     return 0
    //   })
    // }
  },
  methods: {
    toShow (page, id) {
      this.$router.push(`/${page}/${id}`)
    }
  }
}
</script>
