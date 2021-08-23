<template>
  <div>
    <template
      v-for="(comment, i) in post.comments"
    >
      <v-col
        :key="comment.id"
        style="cursor: pointer;"
        @click="toShow(comment)"
      >
        <v-divider />
        <v-col class="d-flex">
          <v-img
            :src="src"
            max-height="70"
            max-width="70"
            contain
            style="border-radius: 50%;"
          />
          <v-card-subtitle>
            <!-- {{ comment.user.name }} -->
          </v-card-subtitle>
        </v-col>
        <v-card-text>
          {{ comment.content }}
        </v-card-text>
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
          <btn-new-comment-comment
            :comment="comment"
            :comment-index="i"
          />
          <v-spacer />
          <btn-edit-comment
            :comment="comment"
          />
          <v-spacer />
          <btn-delete-comment
            :comment="comment"
            :is-post-comment="isPostComment"
          />
          <v-spacer />
        </v-card-actions>
      </v-col>
    </template>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import btnEditComment from '../btn/btnEditComment.vue'
import btnNewCommentComment from '../btn/btnNewCommentComment.vue'
import btnDeleteComment from '../btn/btnDeleteComment.vue'

export default {
  components: {
    btnEditComment,
    btnDeleteComment,
    btnNewCommentComment
  },
  props: {
    post: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      isPostComment: true,
      src: 'https://picsum.photos/500/500'
    }
  },
  computed: {
    ...mapGetters({
      comments: 'comment/comments',
      btnColor: 'btn/color'
    })
  },
  methods: {
    ...mapActions({
      setComment: 'comment/setComment',
      setComments: 'comment/setComments'
    }),
    async toShow (comment) {
      await this.searchAndSetComments(comment.id)
      await this.setComment(comment)
      this.$router.push(`/comments/${comment.id}`)
    },
    async searchAndSetComments (id) {
      const url = `api/v1/search_comments/${id}`
      await this.$axios.get(url)
        .then((res) => {
          this.setComments(res.data)
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    }
  }
}
</script>
