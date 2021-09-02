<template>
  <v-tab-item class="mb-2">
    <v-row
      v-for="post in posts"
      :key="post.id"
      style="cursor: pointer;"
      @click="toShow('posts', post.id)"
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
                  :is-index="isIndex"
                />
                <template v-if="user.id === currentUser.id">
                  <btn-edit-post
                    :post="post"
                    :is-index="isIndex"
                    @fetchContents="fetchContents"
                  />
                  <!-- <btn-delete-post
                    :post="post"
                    :is-index="isIndex"
                    @fetchContents="fetchContents"
                  /> -->
                </template>
              </v-card-actions>
            </v-col>
          </v-row>
        </template>
      </v-col>
    </v-row>
    <infinite-loading
      ref="infiniteLoading"
      spinner="bubbles"
      @infinite="infiniteHandler"
    >
      <div
        slot="no-results"
        class="mt-3"
      >
        <v-divider class="mb-3" />
        データはありません
      </div>
    </infinite-loading>
  </v-tab-item>
</template>

<script>
import { mapGetters } from 'vuex'
import BtnNewComment from '../../btn/comment/btnNewComment.vue'
import Like from '../../btn/like/like.vue'
import BtnEditPost from '../../btn/editPost/btnEditPost.vue'
// import BtnDeletePost from '../../btn/deletePost/btnDeletePost.vue'

export default {
  components: {
    BtnNewComment,
    Like,
    BtnEditPost
    // BtnDeletePost
  },
  props: {
    user: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      posts: [],
      page: 1,
      kaminari: {},
      src: 'https://picsum.photos/200/200',
      isIndex: true
    }
  },
  computed: {
    ...mapGetters({
      isAuthenticated: 'auth/isAuthenticated',
      currentUser: 'auth/data',
      btnColor: 'btn/color'
    })
  },
  methods: {
    async fetchContents () {
      const url = `/api/v1/show_user_posts/${this.user.id}`
      await this.$axios.get(url)
        .then((res) => {
          this.posts = res.data.user_posts
          this.kaminari = res.data.kaminari
        })
    },
    infiniteHandler () {
      const url = `api/v1/show_user_posts/${this.user.id}`
      this.page++
      this.$axios.get(url, { params: { page: this.page } })
        .then((res) => {
          setTimeout(() => {
            if (this.page <= res.data.kaminari.pagination.pages) {
              this.posts.push(...res.data.user_posts)
              this.$refs.infiniteLoading.stateChanger.loaded()
            } else {
              this.$refs.infiniteLoading.stateChanger.complete()
            }
          }, 800)
        })
        .catch(() => {
          this.$refs.infiniteLoading.stateChanger.complete()
        })
    },

    toShow (page, id) {
      this.$router.push(`/${page}/${id}`)
    }
  }
}
</script>
