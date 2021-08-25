<template>
  <div>
    <template
      v-for="(comment, i) in comments"
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
            {{ comment.user.name }}
          </v-card-subtitle>
        </v-col>
        <v-card-text>
          {{ comment.content }}
        </v-card-text>
        <v-card-actions>
          <v-spacer />
          <btn-last-comment
            :comment="comment"
            :comment-index="i"
          />
          <template v-if="comment.user_id !== currentUser.id">
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
          <template v-if="comment.user_id === currentUser.id">
            <v-spacer />
            <btn-edit-last-comment
              :comment="comment"
            />
            <v-spacer />
            <btn-delete-comment
              :comment="comment"
              :is-post-comment="isPostComment"
            />
          </template>
          <v-spacer />
        </v-card-actions>
      </v-col>
    </template>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import btnDeleteComment from '../btn/deleteComment/btnDeleteComment.vue'
import btnEditLastComment from '../btn/editComment/btnEditLastComment.vue'
import btnLastComment from '../btn/commentComment/btnLastComment.vue'

export default {
  components: {
    btnLastComment,
    btnEditLastComment,
    btnDeleteComment
  },
  data () {
    return {
      isPostComment: false,
      src: 'https://picsum.photos/500/500'
    }
  },
  computed: {
    ...mapGetters({
      comments: 'comment/comments',
      currentUser: 'auth/data',
      btnColor: 'btn/color'
    })
  },
  methods: {
    ...mapActions({
      setComments: 'comment/setComments',
      setComment: 'comment/setComment'
    }),
    async toShow (comment) {
      const url = `api/v1/comments/${comment.id}`
      await this.$axios.get(url)
        .then((res) => {
          this.setComment(res.data)
          this.searchAndSetComments(res.data.id)
          this.$router.push(`/comments/${comment.id}`)
        })
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
