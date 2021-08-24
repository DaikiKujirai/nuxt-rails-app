<template>
  <div>
    <v-btn
      :color="btnColor"
      text
      rounded
      @click.prevent.stop="openDialog"
    >
      削除
      <v-icon v-text="'mdi-delete-empty'" />
    </v-btn>
    <v-dialog
      v-model="dialog"
      width="500"
    >
      <v-card>
        <v-card-title>
          削除します。よろしいですか？
        </v-card-title>
        <v-card-text>
          この操作は取り消せません。
        </v-card-text>
        <v-divider />
        <v-card-actions>
          <v-spacer />
          <v-btn
            rounded
            color="info"
            @click="closeDialog"
          >
            キャンセル
          </v-btn>
          <v-btn
            rounded
            color="error"
            @click="clickOK"
          >
            削除する
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
  props: {
    comment: {
      type: Object,
      required: true
    },
    isPostComment: {
      type: Boolean,
      required: true
    }
  },
  data () {
    return {
      dialog: false
    }
  },
  computed: {
    ...mapGetters({
      post: 'post/post',
      gettersComment: 'comment/comment',
      btnColor: 'btn/color'
    })
  },
  methods: {
    ...mapActions({
      setPost: 'post/setPost',
      setComments: 'comment/setComments',
      flashMessage: 'flash/flashMessage'
    }),
    openDialog () {
      this.dialog = true
    },
    closeDialog () {
      this.dialog = false
    },
    clickOK () {
      this.$axios.$delete(`/api/v1/comments/${this.comment.id}`)
        .then(() => {
          if (this.isPostComment) {
            this.fetchPostContents()
          } else {
            this.fetchCommentContents()
          }
          this.flashMessage({ message: '削除しました', type: 'primary', status: true })
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.log('投稿の削除に失敗', err)
        })
    },
    async fetchPostContents () {
      const url = `/api/v1/posts/${this.post.id}`
      await this.$axios.get(url)
        .then((res) => {
          this.setPost(res.data)
          this.$router.push(`/posts/${res.data.id}`)
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    async fetchCommentContents () {
      const url = `/api/v1/search_comments/${this.gettersComment.id}`
      await this.$axios.get(url)
        .then((res) => {
          this.setComments(res.data)
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.log(err)
        })
    }
  }
}
</script>
