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
                :src="avatar"
                max-height="70"
                max-width="70"
                contain
                style="border-radius: 50%; cursor: pointer;"
                class="ml-3 img"
                @click.prevent.stop="toShow('users', post.user_id)"
              />
              <v-card-title
                style="cursor: pointer;"
                @click.prevent.stop="toShow('users', post.user_id)"
              >
                {{ user.name }}
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
                {{ time }}
              </v-card-text>
            </v-col>
          </v-row>
          <v-divider class="mx-3" />
          <v-row>
            <v-col class="d-flex text-center pa-0">
              <v-card-text>
                0 件のリツイート
              </v-card-text>
              <v-card-text>
                {{ commentsCountPagePostId }} 件のコメント
              </v-card-text>
              <v-card-text>
                {{ likesCountPagePostId }} 件のいいね
              </v-card-text>
            </v-col>
          </v-row>
          <v-divider class="mx-3 mb-1" />
          <template v-if="isAuthenticated">
            <actions
              :post="post"
              :is-list="isList"
              @rollBackPage="rollBackPage"
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
import { mapGetters } from 'vuex'
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
  data () {
    return {
      post: {},
      user: {},
      avatar: '',
      time: '',
      isList: false
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data',
      isAuthenticated: 'auth/isAuthenticated',
      commentsCountPagePostId: 'post/commentsCountPagePostId',
      likesCountPagePostId: 'like/likesCountPagePostId'
    })
  },
  created () {
    this.fetchContents()
  },
  methods: {
    async fetchContents () {
      const url = `/api/v1/posts/${this.$route.params.id}`
      await this.$axios.get(url)
        .then((res) => {
          this.post = res.data.post
          this.user = res.data.user
          this.avatar = res.data.user.avatar.url
          this.time = this.$my.format(this.post.created_at)
          this.fetchComments()
        })
    },
    fetchComments () {
      this.$refs.child.fetchComments()
    },
    rollBackPage () {
      this.$refs.child.rollBackPage()
    },
    toShow (page, id) {
      this.$router.push(`/${page}/${id}`)
    }
  }
}
</script>
