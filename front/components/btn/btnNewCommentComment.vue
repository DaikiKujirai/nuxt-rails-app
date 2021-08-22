<template>
  <div>
    <v-btn
      :color="btnColor"
      text
      rounded
      @click.prevent.stop="dialog = true, setPostIdAndCommentId(comment)"
    >
      <v-icon>
        mdi-chat-processing-outline
      </v-icon>
      <template v-if="commentsCommentsCount">
        &nbsp;
        {{ commentsCommentsCount }}
      </template>
    </v-btn>
    <v-dialog
      v-model="dialog"
      width="500"
    >
      <v-card class="pa-2">
        <div class="d-flex">
          <v-spacer />
          <v-btn
            icon
            @click="dialog = false"
          >
            ✖︎
          </v-btn>
        </div>
        <div class="d-flex">
          <v-img
            :src="src"
            max-height="60"
            max-width="60"
            contain
            style="border-radius: 50%;"
            class="ml-2"
          />
          <v-card-title>
            {{ comment.user.name }}
          </v-card-title>
        </div>
        <div class="d-flex">
          <v-divider
            vertical
            inset
            class="ml-9"
          />
          <div>
            <v-card-subtitle>
              {{ comment.content }}
            </v-card-subtitle>
            <v-spacer />
            <v-card-text>
              返信先：{{ comment.user.name }} さん
            </v-card-text>
          </div>
        </div>
        <v-container>
          <v-form
            ref="form"
            v-model="isValid"
          >
            <new-comment-form
              :content.sync="newComment.content"
            />
            <v-btn
              :disabled="!isValid || loading"
              :loading="loading"
              block
              color="info"
              @click="submitComment"
            >
              投稿する
            </v-btn>
          </v-form>
        </v-container>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import newCommentForm from '../comment/newCommentForm.vue'

export default {
  components: {
    newCommentForm
  },
  props: {
    comment: {
      type: Object,
      required: true
    },
    commentIndex: {
      type: Number,
      default: 0
    }
  },
  data () {
    return {
      dialog: false,
      isValid: false,
      loading: false,
      newComment: { content: '' },
      src: 'https://picsum.photos/200/200',
      commentsCommentsCount: 0
    }
  },
  computed: {
    ...mapGetters({
      post: 'post/post',
      currentUser: 'auth/user',
      btnColor: 'btn/color'
    })
  },
  created () {
    this.searchCommentsCount(this.post.comments[this.commentIndex].id)
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage',
      setPost: 'post/setPost'
    }),
    async fetchContents (id) {
      const url = `api/v1/posts/${id}`
      await this.$axios.get(url)
        .then((res) => {
          this.setPost(res.data)
        })
    },
    async submitComment () {
      this.loading = true
      this.newComment.user_uid = this.currentUser.uid
      await this.$axios.$post('/api/v1/comments', this.newComment)
        .then((res) => {
          this.loading = false
          this.fetchContents(res.post_id)
          this.searchCommentsCount(res.comment_id)
          this.dialog = false
          this.flashMessage({ message: 'コメントしました', type: 'primary', status: true })
        })
        .catch(() => {
          this.flashMessage({ message: 'コメントに失敗しました', type: 'error', status: true })
        })
    },
    setPostIdAndCommentId (comment) {
      this.newComment.post_id = this.post.id
      this.newComment.comment_id = comment.id
    },
    async searchCommentsCount (id) {
      const url = `api/v1/search_comments/${id}`
      await this.$axios.get(url)
        .then((res) => {
          this.commentsCommentsCount = res.data.length
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    }
  }
}
</script>

<style scoped>
</style>
