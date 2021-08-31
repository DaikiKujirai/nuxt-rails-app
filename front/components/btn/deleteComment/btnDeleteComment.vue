<template>
  <div>
    <v-btn
      :color="btnColor"
      text
      rounded
      @click.prevent.stop="dialog = true"
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
            @click="dialog = false"
          >
            キャンセル
          </v-btn>
          <v-btn
            rounded
            color="error"
            @click="deleteComment"
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
    isIndex: {
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
      btnColor: 'btn/color'
    })
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage'
    }),
    deleteComment () {
      this.$axios.$delete(`/api/v1/comments/${this.comment.id}`)
        .then(() => {
          if (this.$route.name === 'users-id') {
            this.fetchUser()
          } else if (this.$route.name === 'posts-id') {
            this.fetchPost()
          } else if (this.$route.name === 'comments-id' && this.isIndex) {
            this.fetchComment()
          } else {
            this.$router.replace(`/posts/${this.comment.post_id}`)
          }
          this.flashMessage({ message: '削除しました', type: 'primary', status: true })
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.log('投稿の削除に失敗', err)
        })
    },
    fetchPost () {
      this.$emit('fetchPost')
    },
    fetchComment () {
      this.$emit('fetchComment')
    },
    fetchUser () {
      this.$emit('fetchUser')
    }
  }
}
</script>
