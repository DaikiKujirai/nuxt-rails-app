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
            {{ comment.user.name }}
          </v-card-title>
        </v-col>
      </v-row>
      <v-card-title>
        {{ comment.content }}
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
        <btn-new-comment-comment-comment
          :comment="comment"
        />
        <v-spacer />
        <btn-edit-comment-comment
          :comment="comment"
        />
        <v-spacer />
        <btn-delete-post />
        <v-spacer />
      </v-card-actions>
      <comment-comments />
    </v-card>
  </layout-main>
</template>

<script>
import { mapGetters } from 'vuex'
import btnDeletePost from '../../components/btn/btnDeletePost.vue'
import btnEditCommentComment from '../../components/btn/btnEditCommentComment.vue'
import btnNewCommentCommentComment from '../../components/btn/btnNewCommentCommentComment.vue'
import commentComments from '../../components/comment/commentComments.vue'
import layoutMain from '../../components/layout/loggedIn/layoutMain.vue'

export default {
  components: {
    layoutMain,
    btnNewCommentCommentComment,
    btnEditCommentComment,
    btnDeletePost,
    commentComments
  },
  data () {
    return {
      src: 'https://picsum.photos/500/500'
    }
  },
  computed: {
    ...mapGetters({
      comment: 'comment/comment',
      btnColor: 'btn/color'
    })
  }
}
</script>
