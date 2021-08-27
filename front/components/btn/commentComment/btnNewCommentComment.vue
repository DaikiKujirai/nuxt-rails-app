<template>
  <div>
    <v-btn
      :color="btnColor"
      text
      rounded
      @click.prevent.stop="dialog = true"
    >
      <v-icon v-text="'mdi-chat-processing-outline'" />
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
    <template v-if="commentsCount && isIndex">
      {{ commentsCount }}
    </template>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import newCommentForm from '../../comment/newCommentForm.vue'

export default {
  components: {
    newCommentForm
  },
  props: {
    comment: {
      type: Object,
      required: true
    },
    isIndex: {
      type: Boolean,
      required: true
    }
  },
  data () {
    return {
      dialog: false,
      isValid: false,
      loading: false,
      newComment: { content: '' },
      src: 'https://picsum.photos/200/200',
      commentsCount: 0
    }
  },
  computed: {
    ...mapGetters({
      post: 'post/post',
      currentUser: 'auth/data',
      btnColor: 'btn/color'
    })
  },
  created () {
    this.searchCommentsAndsetCommentsCount()
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage',
      setComments: 'comment/setComments'
    }),
    async submitComment () {
      this.loading = true
      this.newComment.user_id = this.currentUser.id
      this.newComment.post_id = this.post.id
      this.newComment.comment_id = this.comment.id
      await this.$axios.$post('/api/v1/comments', this.newComment)
        .then((res) => {
          this.loading = false
          if (this.isIndex) {
            this.commentsCount++
          } else {
            console.log(res)
            this.searchCommentsAndsetCommentsCount()
          }
          this.dialog = false
          this.flashMessage({ message: 'コメントしました', type: 'primary', status: true })
          this.$refs.form.reset()
        })
        .catch(() => {
          this.flashMessage({ message: 'コメントに失敗しました', type: 'error', status: true })
        })
    },
    async searchCommentsAndsetCommentsCount () {
      const url = `api/v1/search_comments/${this.comment.id}`
      await this.$axios.get(url)
        .then((res) => {
          if (!this.isIndex) {
            console.log(res)
            this.setComments(res.data)
            console.log('btncommentcomment', res.data)
          }
          this.commentsCount = res.data.length
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
