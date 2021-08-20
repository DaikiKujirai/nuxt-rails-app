<template>
  <div>
    <v-btn
      :color="color"
      text
      rounded
      @click="dialog = true, setPostIdAndCommentId(comment)"
    >
      コメント
      <v-icon>
        mdi-chat-processing-outline
      </v-icon>
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
            {{ userName }}
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
              {{ gettersPost.content }}
            </v-card-subtitle>
            <v-spacer />
            <v-card-text>
              返信先：{{ userName }} さん
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
    }
  },
  data () {
    return {
      dialog: false,
      isValid: false,
      loading: false,
      src: 'https://picsum.photos/500/500',
      color: 'deep-purple lighten-2',
      newComment: { content: '' },
      post: {},
      user: {}
    }
  },
  computed: {
    ...mapGetters({
      gettersPost: 'post/post',
      userPost: 'post/user',
      currentUser: 'auth/user'
    }),
    userName () {
      return this.userPost.name
    }
  },
  methods: {
    ...mapActions({
      setUser: 'post/setUser',
      flashMessage: 'flash/flashMessage'
    }),
    async submitComment () {
      this.loading = true
      this.newComment.user_uid = this.currentUser.uid
      await this.$axios.$post('/api/v1/comments', this.newComment)
        .then((res) => {
          this.loading = false
          this.dialog = false
          this.flashMessage({ message: 'コメントしました', type: 'primary', status: true })
        })
        .catch(() => {
          this.flashMessage({ message: 'コメントに失敗しました', type: 'error', status: true })
        })
    },
    setPostIdAndCommentId (value) {
      this.newComment.post_id = this.gettersPost.id
      this.newComment.comment_id = value.id
    }
  }
}
</script>
