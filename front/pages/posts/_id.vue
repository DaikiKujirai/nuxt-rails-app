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
            {{ post.user.name }}
          </v-card-title>
        </v-col>
      </v-row>
      <v-card-title>
        {{ post.content }}
      </v-card-title>
      <v-card-actions>
        <v-spacer />
        <btn-show-post-comment
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
          <btn-edit-post-in-id
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
      <post-comment
        :post="post"
      />
    </v-card>
  </layout-main>
</template>

<script>
import { mapGetters } from 'vuex'
import btnDeletePost from '../../components/btn/btnDeletePost.vue'
import layoutMain from '../../components/layout/loggedIn/layoutMain.vue'
import postComment from '../../components/comment/postComment.vue'
import btnShowPostComment from '../../components/btn/btnNewPostComment.vue'
import btnEditPostInId from '../../components/btn/btnEditPostInId.vue'

export default {
  components: {
    btnDeletePost,
    layoutMain,
    postComment,
    btnShowPostComment,
    btnEditPostInId
  },
  middleware: 'authenticated',
  data () {
    return {
      src: 'https://picsum.photos/200/200',
      isIndex: false
    }
  },
  computed: {
    ...mapGetters({
      post: 'post/post',
      currentUser: 'auth/data',
      btnColor: 'btn/color'
    })
  }
}
</script>
