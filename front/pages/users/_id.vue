<template>
  <layout-main #layout-main> <!--eslint-disable-line-->
    <v-row>
      <v-col>
        <v-card>
          <v-row>
            <v-col>
              <v-img
                :src="src"
                height="250"
              />
            </v-col>
          </v-row>
          <v-row class="mt-0">
            <v-col
              class="d-flex"
            >
              <v-img
                :src="src"
                max-height="70"
                max-width="70"
                contain
                style="border-radius: 50%;"
                class="ml-3 mt-0"
              />
              <v-card-title>
                {{ user.name }}
              </v-card-title>
              <v-col
                class="text-right mr-2"
              >
                <v-btn
                  color="success"
                  outlined
                  rounded
                >
                  プロフィール編集
                </v-btn>
              </v-col>
            </v-col>
          </v-row>
          <v-row>
            <v-col>
              <v-card-title
                class="card-content"
              >
                {{ user.introduction }}
              </v-card-title>
            </v-col>
          </v-row>
          <template v-if="isAuthenticated">
            <v-row>
              <v-col>
                <v-card-actions>
                  <v-btn
                    :color="btnColor"
                    text
                    rounded
                    @click="toFollow"
                  >
                    フォロー
                  </v-btn>
                  <v-btn
                    :color="btnColor"
                    text
                    rounded
                    @click="toFollower"
                  >
                    フォロワー
                  </v-btn>
                </v-card-actions>
              </v-col>
            </v-row>
          </template>
        </v-card>
        <page-id-user-tab
          class="mt-1"
          :user="user"
          :posts="posts"
          :comments="comments"
          :likes="likes"
          @fetchUser="fetchUser"
        />
      </v-col>
    </v-row>
  </layout-main>
</template>

<script>
import { mapGetters } from 'vuex'
import pageIdUserTab from '../../components/user/pageIdUserTab.vue'

export default {
  components: {
    pageIdUserTab
  },
  data: () => {
    return {
      user: {},
      posts: [],
      comments: [],
      likes: [],
      params: {
        user_id: 0,
        like_post_ids: [],
        like_comment_ids: []
      },
      src: 'https://picsum.photos/500/500'
    }
  },
  computed: {
    ...mapGetters({
      isAuthenticated: 'auth/isAuthenticated',
      btnColor: 'btn/color'
    })
  },
  created () {
    this.fetchUser()
  },
  methods: {
    fetchUser () {
      const url = `/api/v1/users/${this.$route.params.id}`
      this.$axios.get(url)
        .then((res) => {
          this.user = res.data
          this.posts = res.data.posts
          this.comments = res.data.comments
          this.params.user_id = res.data.id
          this.setLikePostIds(res.data.like_posts)
          this.setLikeCommentIds(res.data.like_comments)
          this.fetchLikes()
        })
        .catch((err) => {
          console.error(err) // eslint-disable-line
        })
    },
    setLikePostIds (likePosts) {
      for (let i = 0; i < likePosts.length; i++) {
        this.params.like_post_ids.push(likePosts[i].post_id)
      }
    },
    setLikeCommentIds (likeComments) {
      for (let i = 0; i < likeComments.length; i++) {
        this.params.like_comment_ids.push(likeComments[i].comment_id)
      }
    },
    async fetchLikes () {
      const likes = this.params
      const url = '/api/v1/search_likes'
      await this.$axios.get(url, { params: likes })
        .then((res) => {
          this.likes = res.data
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    toFollow () {
      // eslint-disable-next-line no-console
      console.log('toFolow')
    },
    toFollower () {
      // eslint-disable-next-line no-console
      console.log('toFolower')
    }
  }
}
</script>
