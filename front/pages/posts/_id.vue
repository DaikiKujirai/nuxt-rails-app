<template>
  <v-container
    fluid
    class="mt-3"
  >
    <v-row>
      <sidebar />
      <v-col
        cols="6"
        offset="3"
      >
        <v-card
          class="pt-4"
        >
          <div class="d-flex">
            <v-img
              :src="src"
              max-height="90"
              max-width="90"
              style="border-radius: 50%;"
              contain
            />
            <v-card-title>
              {{ userName }}
            </v-card-title>
          </div>
          <v-card-title>
            {{ gettersPost.content }}
          </v-card-title>
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
            <new-comment-form />
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
import { mapGetters, mapActions } from 'vuex'
import sidebar from '../../components/loggedIn/sidebar/sidebar.vue'
import newCommentForm from '../../components/comment/newComment.vue'
import deletePost from '../../components/post/deletePost.vue'
import editPost from '../../components/post/editPost.vue'

export default {
  components: {
    editPost,
    deletePost,
    sidebar,
    newCommentForm
  },
  data () {
    return {
      post: {},
      user: {},
      src: 'https://picsum.photos/500/500',
      color: 'deep-purple lighten-2'
    }
  },
  computed: {
    ...mapGetters({
      gettersPost: 'post/post'
    }),
    userName () {
      return this.user.name
    }
  },
  mounted () {
    this.fetchContents()
  },
  methods: {
    ...mapActions({
      setPost: 'post/setPost',
      setUser: 'post/setUser'
    }),
    fetchContents () {
      const url = `/api/v1/posts/${this.$route.params.id}`
      this.$axios.get(url)
        .then((res) => {
          this.post = res.data
          this.user = res.data.user
          this.setPost(res.data)
          this.setUser(res.data.user)
        })
        .catch((err) => {
          console.error(err) // eslint-disable-line
        })
    }
  }
}
</script>
