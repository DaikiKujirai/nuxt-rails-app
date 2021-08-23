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
          <v-btn
            :color="btnColor"
            text
          >
            <v-icon>
              mdi-heart-outline
            </v-icon>
          </v-btn>
          <v-spacer />
          <btn-last-comment
            :comment="comment"
            :comment-index="i"
          />
          <v-spacer />
          <btn-edit-last-comment
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
import btnDeleteComment from '../btn/btnDeleteComment.vue'
import btnEditLastComment from '../btn/btnEditLastComment.vue'
import btnLastComment from '../btn/btnLastComment.vue'

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
