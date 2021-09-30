<template>
  <layout-main #layout-main> <!--eslint-disable-line-->
    <v-row class="mt-2">
      <v-col>
        <v-card>
          <v-row>
            <v-col
              class="d-flex"
            >
              <v-img
                :src="post.user.avatar.url"
                height="70"
                max-width="70"
                style="border-radius: 50%; cursor: pointer;"
                class="ml-3 img"
                @click.prevent.stop="toShow('users', post.user_id)"
              />
              <v-card-title
                style="cursor: pointer;"
                @click.prevent.stop="toShow('users', post.user_id)"
              >
                {{ post.user.name }}
              </v-card-title>
            </v-col>
          </v-row>
          <v-row>
            <v-col>
              <v-card-title
                class="card-content"
              >
                {{ post.content }}
              </v-card-title>
              <template
                v-if="post.image"
                class="text-center"
              >
                <v-img
                  :src="post.image.url"
                  max-height="400"
                  max-width="400"
                  contain
                  class="ma-3"
                />
              </template>
            </v-col>
          </v-row>
          <v-row>
            <v-col>
              <v-card-text>
                <v-icon
                  size="16"
                  v-text="'mdi-update'"
                />
                {{ $my.format(post.created_at) }}
              </v-card-text>
            </v-col>
          </v-row>
          <v-divider class="mx-3" />
          <v-row>
            <v-col class="d-flex text-center pa-0">
              <v-card-text>
                {{ commentsCount }} 件のコメント
              </v-card-text>
              <v-card-text
                class="likes"
                style="cursor: pointer;"
                @click="toShow('likes', $route.params.id)"
              >
                {{ likesCountPagePostId }} 件のいいね
              </v-card-text>
            </v-col>
          </v-row>
          <v-divider class="mx-3 mb-1" />
          <template v-if="isAuthenticated">
            <actions
              :post="post"
              :user="post.user"
              :likes="post.likes"
              :is-list="isList"
              @fetchContents="fetchContents"
            />
            <v-divider class="mx-3 mt-1" />
            <page-id-comment-form
              :post="post"
              @fetchContents="fetchContents"
            />
          </template>
        </v-card>
      </v-col>
    </v-row>
    <comments
      ref="child"
      :post="post"
      @fetchContents="fetchContents"
    />
  </layout-main>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import LayoutMain from '../../components/layout/loggedIn/layoutMain.vue'
import PageIdCommentForm from '../../components/comment/pageIdCommentForm.vue'
import Comments from '../../components/comment/comments.vue'
import Actions from '../../components/loggedIn/mainCard/actions.vue'

export default {
  components: {
    LayoutMain,
    PageIdCommentForm,
    Comments,
    Actions
  },
  async asyncData ({ $axios, params }) {
    const res = await $axios.get(`/api/v1/posts/${params.id}`)
    return { post: res.data, commentsCount: res.data.comments.length }
  },
  channels: {
    RoomChannel: {
      connected () {
      },
      received (data) {
        if (data.category === 'chat') {
          this.setIsExistsUnreadChat(true)
        }
        this.setIsActive(true)
        this.pushNotification(data)
      },
      disconnected () {
        // eslint-disable-next-line no-console
        console.log('disconnected')
      }
    }
  },
  data () {
    return {
      isList: false,
      breadcrumbs: 'の投稿'
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data',
      isAuthenticated: 'auth/isAuthenticated',
      likesCountPagePostId: 'like/likesCountPagePostId',
      updatePost: 'post/updatePost',
      deletePost: 'post/deletePost',
      isNewComment: 'post/isNewComment'
    })
  },
  watch: {
    async updatePost (val) {
      if (val.bool && val.post.id === this.post.id) {
        this.post = await val.post
        this.setUpdatePost = await { bool: false, post: {} }
      }
    },
    deletePost (val) {
      if (val.bool) {
        this.commentsCount--
      }
    },
    async isNewComment (bool) {
      if (bool) {
        await this.commentsCount++
        await this.setIsNewComment(false)
      }
    }
  },
  created () {
    this.setUser(this.post.user)
    this.setBreadcrumbs(this.breadcrumbs)
  },
  mounted () {
    setTimeout(() => {
      if (!this.isAuthenticated) {
        this.$router.push('/auth/login')
      }
      this.subscribe()
    }, 0)
  },
  methods: {
    ...mapActions({
      setUser: 'user/setUser',
      setUpdatePost: 'post/setUpdatePost',
      setBreadcrumbs: 'breadcrumbs/setBreadcrumbs',
      setIsActive: 'notification/setIsActive',
      pushNotification: 'notification/pushNotification',
      setIsNewComment: 'post/setIsNewComment',
      setIsExistsUnreadChat: 'chat/setIsExistsUnreadChat'
    }),
    async subscribe () {
      await this.$cable.subscribe({
        channel: 'RoomChannel',
        room: this.currentUser.uid,
        uid: `${this.currentUser.uid}`
      })
    },
    async fetchContents () {
      const url = `/api/v1/posts/${this.$route.params.id}`
      await this.$axios.get(url)
        .then((res) => {
          this.post = res.data
          this.user = res.data.user
          this.setUser(res.data.user)
          this.fetchComments()
        })
    },
    fetchComments () {
      this.$refs.child.fetchComments()
    },
    toShow (page, id) {
      this.$router.push(`/${page}/${id}`)
    }
  }
}
</script>

<style scoped>
  .likes:hover {
    opacity: 0.7;
    text-decoration: underline;
  }
</style>
