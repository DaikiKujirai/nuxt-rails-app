<template>
  <v-tab-item class="mb-2">
    <v-row
      v-for="post in userPosts"
      :key="post.id"
      style="cursor: pointer;"
      @click="toShowPost(post.id)"
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
                {{ user.name }}
              </v-card-title>
            </v-col>
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
              <v-card-actions class="justify-space-around pa-0">
                <btn-new-comment
                  :post="post"
                  :user="user"
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
                <like
                  :post="post"
                  :likes="post.likes"
                  :is-index="isIndex"
                />
                <template v-if="user.id === currentUser.id">
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
    </v-row>
  </v-tab-item>
</template>

<script>
import { mapGetters } from 'vuex'
import BtnNewComment from '../../btn/comment/btnNewComment.vue'
import Like from '../../btn/like/like.vue'
// import BtnDeletePost from '../../btn/deletePost/btnDeletePost.vue'
// import BtnEditPost from '../../btn/editPost/btnEditPost.vue'

export default {
  components: {
    BtnNewComment,
    Like
    // BtnEditPost,
    // BtnDeletePost
  },
  props: {
    user: {
      type: Object,
      required: true
    },
    posts: {
      type: Array,
      required: true
    },
    likes: {
      type: Array,
      required: true
    }
  },
  data () {
    return {
      userPostLikes: [],
      src: 'https://picsum.photos/200/200',
      isIndex: true
    }
  },
  computed: {
    ...mapGetters({
      isAuthenticated: 'auth/isAuthenticated',
      currentUser: 'auth/data',
      btnColor: 'btn/color'
    }),
    userPosts () {
      const userPosts = this.posts
      return userPosts.sort((a, b) => {
        if (a.created_at > b.created_at) { return -1 }
        if (a.created_at < b.created_at) { return 1 }
        return 0
      })
    }
  },
  methods: {
    toShowPost (id) {
      this.$router.push(`/posts/${id}`)
    },
    fetchUser () {
      this.$emit('fetchUser')
    }
  }
}
</script>
