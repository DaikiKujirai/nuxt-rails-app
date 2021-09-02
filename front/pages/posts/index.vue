<template>
  <layout-main #layout-main> <!--eslint-disable-line-->
    <template v-if="isAuthenticated">
      <home-new-post
        @rollBackPage="rollBackPage"
        @fetchContents="fetchContents"
      />
    </template>
    <template v-if="posts">
      <v-row
        v-for="post in posts"
        :key="post.id"
        class="mb-1"
      >
        <v-col>
          <v-card
            @click="toShow('posts', post.id)"
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
                <v-col cols="7">
                  <v-card-title>
                    {{ post.user_name }}
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
                  <v-card-actions class="justify-space-around">
                    <btn-new-comment
                      :post="post"
                      :is-index="isIndex"
                      @rollBackPage="rollBackPage"
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
                    <template v-if="post.user_id === currentUser.id">
                      <btn-edit-post
                        :post="post"
                        @rollBackPage="rollBackPage"
                        @fetchContents="fetchContents"
                      />
                      <btn-delete-post
                        :post="post"
                        :is-index="isIndex"
                        @rollBackPage="rollBackPage"
                        @fetchContents="fetchContents"
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
    </template>
  </layout-main>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import LayoutMain from '../../components/layout/loggedIn/layoutMain.vue'
import BtnNewComment from '../../components/btn/comment/btnNewComment.vue'
import Like from '../../components/btn/like/like.vue'
import BtnEditPost from '../../components/btn/editPost/btnEditPost.vue'
import BtnDeletePost from '../../components/btn/deletePost/btnDeletePost.vue'
import HomeNewPost from '../../components/post/homeNewPost.vue'

export default {
  components: {
    LayoutMain,
    BtnNewComment,
    Like,
    BtnEditPost,
    BtnDeletePost,
    HomeNewPost
  },
  data () {
    return {
      posts: [],
      user: {},
      kaminari: {},
      page: 1,
      src: 'https://picsum.photos/200/200',
      isIndex: true
    }
  },
  computed: {
    ...mapGetters({
      btnColor: 'btn/color',
      currentUser: 'auth/data',
      isAuthenticated: 'auth/isAuthenticated'
    })
  },
  created () {
    this.fetchContents()
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage'
    }),
    async fetchContents () {
      const url = '/api/v1/posts'
      await this.$axios.get(url)
        .then((res) => {
          this.posts = res.data.posts
          this.kaminari = res.data.kaminari
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    toShow (page, id) {
      this.$router.push(`/${page}/${id}`)
    },
    infiniteHandler () {
      const url = 'api/v1/posts'
      this.page++
      this.$axios.get(url, { params: { page: this.page } })
        .then((res) => {
          setTimeout(() => {
            if (this.page <= res.data.kaminari.pagination.pages) {
              this.posts.push(...res.data.posts)
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
    rollBackPage () {
      this.page = 1
    }
  }
}
</script>

<style>
/* .infinite-scroll {
  display: flex;
  flex-direction: column;
  justify-content: center;
  width: 680px;
  margin: 100px 0;
}

.infinite-scroll-list-item {
  height: 60px;
  margin: 10px 0;
  border-bottom: 1px solid #eaeaea;
  padding-bottom: 10px;
} */
</style>
