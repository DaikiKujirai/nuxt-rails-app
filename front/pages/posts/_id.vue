<template>
  <layout-main #layout-main> <!--eslint-disable-line-->
    <v-card>
      <v-row>
        <v-col class="d-flex">
          <v-img
            :src="src"
            max-height="70"
            max-width="70"
            style="border-radius: 50%;"
            contain
            class="ml-3"
          />
          <v-card-title>
            {{ userName }}
          </v-card-title>
        </v-col>
      </v-row>
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
      <v-divider />
      <post-comment />
    </v-card>
  </layout-main>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

import newCommentForm from '../../components/comment/newComment.vue'
import deletePost from '../../components/post/deletePost.vue'
import editPost from '../../components/post/editPost.vue'
import layoutMain from '../../components/layout/loggedIn/layoutMain.vue'
import postComment from '../../components/comment/postComment.vue'

export default {
  components: {
    editPost,
    deletePost,
    newCommentForm,
    layoutMain,
    postComment
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
      setUser: 'post/setUser',
      setComments: 'comment/setComments'
    }),
    fetchContents () {
      const url = `/api/v1/posts/${this.$route.params.id}`
      this.$axios.get(url)
        .then((res) => {
          this.post = res.data
          this.user = res.data.user
          this.setPost(res.data)
          this.setUser(res.data.user)
          this.setComments(res.data.comments)
          console.log(res.data.comments)
        })
        .catch((err) => {
          console.error(err) // eslint-disable-line
        })
    }
  }
}
</script>
