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
          :color="btnColor"
          text
        >
          いいね
          <v-icon>
            mdi-heart-outline
          </v-icon>
        </v-btn>
        <v-spacer />
        <btn-new-comment
          :is-show-comment-count="false"
          :post="post"
        />
        <v-spacer />
        <btn-edit-post />
        <v-spacer />
        <btn-delete-post />
      </v-card-actions>
      <post-comment />
    </v-card>
  </layout-main>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

import btnNewComment from '../../components/btn/btnNewComment.vue'
import btnDeletePost from '../../components/btn/btnDeletePost.vue'
import btnEditPost from '../../components/btn/btnEditPost.vue'
import layoutMain from '../../components/layout/loggedIn/layoutMain.vue'
import postComment from '../../components/comment/postComment.vue'

export default {
  components: {
    btnDeletePost,
    btnEditPost,
    btnNewComment,
    layoutMain,
    postComment
  },
  data () {
    return {
      post: {},
      user: {},
      src: 'https://picsum.photos/200/200'
    }
  },
  computed: {
    ...mapGetters({
      gettersPost: 'post/post',
      postUser: 'post/user',
      btnColor: 'btn/color'
    }),
    userName () {
      return this.postUser.name
    }
  },
  created () {
    this.post = this.gettersPost
  },
  methods: {
    ...mapActions({
      setPost: 'post/setPost',
      setUser: 'post/setUser',
      setComments: 'comment/setComments'
    })
  }
}
</script>
