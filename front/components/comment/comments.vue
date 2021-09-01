<template>
  <div class="mt-3">
    <v-row
      v-for="comment in comments"
      :key="comment.id"
      class="mb-1"
    >
      <v-col>
        <v-card
          @click="toShowComment(comment.id)"
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
                @click.prevent.stop="toShowUser(post.user_id)"
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
                  <btn-new-comment
                    :post="comment"
                    :user="user"
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
                  <like
                    :post="comment"
                    :likes="comment.likes"
                    :is-index="isIndex"
                  />
                  <template v-if="comment.user_id === currentUser.id">
                    <btn-edit-post
                      :post="comment"
                      @fetchPost="fetchPost"
                    />
                    <btn-delete-post
                      :post="comment"
                      :is-index="isIndex"
                      @fetchPost="fetchPost"
                      @commentsCountDecrement="commentsCountDecrement"
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
import BtnNewComment from '../btn/comment/btnNewComment.vue'
import Like from '../btn/like/like.vue'
import BtnEditPost from '../btn/editPost/btnEditPost.vue'
import BtnDeletePost from '../btn/deletePost/btnDeletePost.vue'

export default {
  components: {
    BtnNewComment,
    Like,
    BtnEditPost,
    BtnDeletePost
  },
  props: {
    post: {
      type: Object,
      required: true
    },
    user: {
      type: Object,
      required: true
    },
    comments: {
      type: Array,
      required: true
    }
  },
  data () {
    return {
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
    toShowComment (id) {
      this.$router.push(`/posts/${id}`)
    },
    toShowUser (id) {
      this.$router.push(`/users/${id}`)
    },
    fetchPost () {
      this.$emit('fetchPost')
    },
    commentsCountDecrement () {
      this.$emit('commentsCountDecrement')
    }
  }
}
</script>
