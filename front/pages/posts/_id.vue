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
        <btn-show-post-comment
          :post="post"
        />
        <v-spacer />
        <btn-edit-post />
        <v-spacer />
        <btn-delete-post />
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
import btnEditPost from '../../components/btn/btnEditPost.vue'
import layoutMain from '../../components/layout/loggedIn/layoutMain.vue'
import postComment from '../../components/comment/postComment.vue'
import btnShowPostComment from '../../components/btn/btnShowPostComment.vue'

export default {
  components: {
    btnDeletePost,
    btnEditPost,
    layoutMain,
    postComment,
    btnShowPostComment
  },
  data () {
    return {
      src: 'https://picsum.photos/200/200'
    }
  },
  computed: {
    ...mapGetters({
      post: 'post/post',
      btnColor: 'btn/color'
    })
  }
}
</script>
