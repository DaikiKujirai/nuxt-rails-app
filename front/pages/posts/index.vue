<template>
  <layout-main #layout-main> <!--eslint-disable-line-->
    <v-card
      v-for="post in posts"
      :key="post.id"
      class="mt-3"
      @click="toShow(post.id)"
    >
      <v-row>
        <v-col class="d-flex">
          <v-img
            :src="src"
            max-height="70"
            max-width="70"
            contain
            style="border-radius: 50%;"
          />
          <v-card-text>
            {{ post.user.name }}
          </v-card-text>
          <v-card-text
            class="text-right"
          >
            <v-icon size="16">
              mdi-update
            </v-icon>
            {{ $my.format(post.created_at) }}
          </v-card-text>
        </v-col>
      </v-row>
      <div>
        <v-card-title
          class="card-content"
        >
          {{ post.content }}
        </v-card-title>
      </div>
      <template v-if="isAuthenticated">
        <v-card-actions>
          <v-spacer />
          <btn-new-comment
            :post="post"
          />
          <template v-if="post.user_id !== currentUser.id">
            <v-spacer />
            <v-btn
              :color="btnColor"
              text
            >
              <v-icon v-text="'mdi-twitter-retweet'" />
            </v-btn>
          </template>
          <v-spacer />
          <v-btn
            :color="btnColor"
            text
          >
            <v-icon v-text="'mdi-heart-outline'" />
          </v-btn>
          <template v-if="post.user_id === currentUser.id">
            <v-spacer />
            <btn-edit-post-in-index
              :post="post"
            />
            <v-spacer />
            <btn-delete-post
              :post="post"
              :is-index="isIndex"
            />
          </template>
          <v-spacer />
        </v-card-actions>
      </template>
    </v-card>
  </layout-main>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import btnEditPostInIndex from '../../components/btn/btnEditPostInIndex.vue'
import layoutMain from '../../components/layout/loggedIn/layoutMain.vue'
import btnNewComment from '../../components/btn/btnNewComment.vue'
import btnDeletePost from '../../components/btn/btnDeletePost.vue'

export default {
  components: {
    layoutMain,
    btnNewComment,
    btnEditPostInIndex,
    btnDeletePost
  },
  data () {
    return {
      src: 'https://picsum.photos/200/200',
      isIndex: true
    }
  },
  computed: {
    ...mapGetters({
      posts: 'post/posts',
      btnColor: 'btn/color',
      currentUser: 'auth/data',
      isAuthenticated: 'auth/isAuthenticated'
    })
  },
  mounted () {
    this.fetchContents()
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage',
      setPosts: 'post/setPosts',
      setPost: 'post/setPost'
    }),
    async fetchContents () {
      const url = '/api/v1/posts'
      await this.$axios.get(url)
        .then((res) => {
          this.setPosts(res.data)
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    async toShow (id) {
      const url = `/api/v1/posts/${id}`
      await this.$axios.get(url)
        .then((res) => {
          this.setPost(res.data)
          this.$router.push(`posts/${res.data.id}`)
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    }
  }
}
</script>

<style scope>
</style>
