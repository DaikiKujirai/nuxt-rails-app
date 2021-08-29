<template>
  <div class="pa-3">
    <v-form
      ref="form"
      v-model="isValid"
    >
      <v-row>
        <v-col class="d-flex">
          <v-img
            :src="src"
            max-height="70"
            max-width="70"
            contain
            style="border-radius: 50%;"
          />
          <page-id-comment-form
            :content.sync="newComment.content"
          />
        </v-col>
      </v-row>
      <v-row>
        <v-col class="d-flex justify-end">
          <v-btn
            :disabled="!isValid || loading"
            :loading="loading"
            color="info"
            rounded
            @click="submitComment"
            v-text="'コメントする'"
          />
        </v-col>
      </v-row>
    </v-form>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import pageIdCommentForm from './pageIdCommentForm.vue'

export default {
  components: {
    pageIdCommentForm
  },
  props: {
    comment: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      isValid: false,
      loading: false,
      newComment: { content: '' },
      src: 'https://picsum.photos/200/200'
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data'
    })
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage'
    }),
    async submitComment () {
      this.loading = true
      this.newComment.user_id = this.currentUser.id
      this.newComment.post_id = this.comment.post_id
      this.newComment.comment_id = this.comment.id
      await this.$axios.$post('/api/v1/comments', this.newComment)
        .then(() => {
          this.flashMessage({ message: 'コメントしました', type: 'primary', status: true })
          this.fetchComment()
          this.loading = false
          this.$refs.form.reset()
        })
        .catch(() => {
          this.flashMessage({ message: 'コメントに失敗しました', type: 'error', status: true })
        })
    },
    fetchComment () {
      this.$emit('fetchComment')
    }
  }
}
</script>
