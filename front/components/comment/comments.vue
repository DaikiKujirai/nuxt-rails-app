<template>
  <div class="mt-3">
    <v-row
      v-for="comment in comments"
      :key="comment.id"
      class="mb-1"
    >
      <v-col>
        <v-card
          @click="toShow('posts', comment.id)"
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
                @click.prevent.stop="toShow('users', post.user_id)"
              />
              <v-card-text>
                {{ comment.user_name }}
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
          <v-card-text>
            返信先： {{ user.name }} さん
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
                <v-card-actions class="justify-space-around">
                  <btn-new-comment
                    :post="comment"
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
                    :is-index="isIndex"
                  />
                  <template v-if="comment.user_id === currentUser.id">
                    <btn-edit-post
                      :post="comment"
                      @rollBackPage="rollBackPage"
                      @fetchContents="fetchContents"
                    />
                    <btn-delete-post
                      :post="comment"
                      :is-index="isIndex"
                      @rollBackPage="rollBackPage"
                      @fetchContents="fetchContents"
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
    <infinite-loading
      ref="infiniteLoading"
      spinner="bubbles"
      @infinite="infiniteHandler"
    >
      <div
        slot="no-results"
        class="mt-3"
      >
        データはありません
      </div>
    </infinite-loading>
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
    }
  },
  data () {
    return {
      comments: [],
      isIndex: true,
      page: 1,
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
    async fetchComments () {
      const url = `/api/v1/find_comments/${this.$route.params.id}`
      await this.$axios.get(url)
        .then((res) => {
          this.comments = res.data.comments
        })
    },
    async infiniteHandler () {
      const url = `api/v1/find_comments/${this.$route.params.id}`
      this.page++
      await this.$axios.get(url, { params: { page: this.page } })
        .then((res) => {
          setTimeout(() => {
            if (this.page <= res.data.kaminari.pagination.pages) {
              this.comments.push(...res.data.comments)
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
    },
    fetchContents () {
      this.$emit('fetchContents')
    },
    commentsCountDecrement () {
      this.$emit('commentsCountDecrement')
    },
    rollBackPage () {
      this.page = 1
    }
  }
}
</script>
