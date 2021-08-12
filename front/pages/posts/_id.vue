<template>
  <v-container
    class="mt-3"
  >
    <v-row>
      <sidebar />
      <v-col
        cols="6"
        offset="2"
      >
        <v-card
          align="center"
          class="pt-4"
        >
          <v-img
            :src="src"
            max-height="500"
            max-width="500"
            contain
          />
          <v-card-title>
            {{ postTitle }}
          </v-card-title>
          <v-card-text>
            {{ postContent }}
          </v-card-text>
          <v-card-actions>
            <v-btn
              :color="color"
              text
            >
              いいね
              <v-icon>
                mdi-heart-outline
              </v-icon>
            </v-btn>
            <v-btn
              :color="color"
              text
            >
              コメント
              <v-icon>
                mdi-chat-processing-outline
              </v-icon>
            </v-btn>
            <v-spacer />
            <edit-post />
            <delete-post />
          </v-card-actions>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import sidebar from '../../components/loggedIn/sidebar/sidebar.vue'
import deletePost from '../../components/posts/deletePost.vue'
import editPost from '../../components/posts/editPost.vue'

export default {
  components: {
    editPost,
    deletePost,
    sidebar
  },
  layout: 'loggedIn',
  data () {
    return {
      post: {},
      src: 'https://picsum.photos/500/500',
      color: 'deep-purple lighten-2'
    }
  },
  computed: {
    postTitle () {
      // eslint-disable-next-line no-console
      console.log('タイトル')
      return this.post.title
    },
    postContent () {
      // eslint-disable-next-line no-console
      console.log('コンテント')
      return this.post.content
    }
  },
  mounted () {
    this.fetchContents()
  },
  methods: {
    fetchContents () {
      const url = `/api/v1/posts/${this.$route.params.id}`
      this.$axios.get(url)
        .then((res) => {
          // eslint-disable-next-line
          console.log('投稿詳細')
          this.post = res.data
        })
        .catch((err) => {
          console.error(err) // eslint-disable-line
        })
    }
  }
}
</script>
