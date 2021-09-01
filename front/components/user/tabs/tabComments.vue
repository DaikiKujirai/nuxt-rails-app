<template>
  <v-tab-item>
    <v-row
      v-for="comment in userComments"
      :key="comment.id"
      @click="toShowComment(comment.id)"
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
                {{ comment.user.name }}
              </v-card-title>
            </v-col>
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
        <v-card-text>
          返信先： {{ comment.user.name }} さん
        </v-card-text>
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
              <v-card-actions class="justify-space-around ma-0 pa-0">
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
                <template v-if="user.id === currentUser.id">
                  <btn-edit-post
                    :post="comment"
                    :is-index="isIndex"
                    @fetchUser="fetchUser"
                  />
                  <btn-delete-post
                    :post="comment"
                    :is-index="isIndex"
                    @fetchUser="fetchUser"
                  />
                </template>
              </v-card-actions>
            </v-col>
          </v-row>
        </template>
      </v-col>
    </v-row>
  </v-tab-item>
</template>

<script>
import { mapGetters } from 'vuex'
import BtnNewComment from '../../btn/comment/btnNewComment.vue'
import Like from '../../btn/like/like.vue'
import BtnDeletePost from '../../btn/deletePost/btnDeletePost.vue'
import BtnEditPost from '../../btn/editPost/btnEditPost.vue'

export default {
  components: {
    BtnNewComment,
    Like,
    BtnDeletePost,
    BtnEditPost
  },
  props: {
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
      isAuthenticated: 'auth/isAuthenticated',
      currentUser: 'auth/data',
      btnColor: 'btn/color'
    }),
    userComments () {
      const userComments = this.comments
      return userComments.sort((a, b) => {
        if (a.created_at > b.created_at) { return -1 }
        if (a.created_at < b.created_at) { return 1 }
        return 0
      })
    }
  },
  methods: {
    toShowComment (id) {
      this.$router.push(`/comments/${id}`)
    },
    fetchUser () {
      this.$emit('fetchUser')
    }
  }
}
</script>
