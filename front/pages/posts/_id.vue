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
        <v-btn
          :color="btnColor"
          text
        >
          <v-icon>
            mdi-heart-outline
          </v-icon>
        </v-btn>
        <v-spacer />
        <btn-show-post-comment
          :post="post"
        />
        <v-spacer />
        <btn-edit-post-in-id
          :post="post"
        />
        <v-spacer />
        <btn-delete-post
          :post="post"
          :is-index="isIndex"
        />
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
  data () {
    return {
      src: 'https://picsum.photos/200/200',
      isIndex: false
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
