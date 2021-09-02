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
    post: {
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
    async clickOK () {
      await this.$axios.$delete(`/api/v1/posts/${this.post.id}`)
        .then(() => {
          if (this.$route.name === 'posts-id' && this.isIndex) {
            this.fetchContents()
            this.commentsCountDecrement()
          } else if (this.$route.name === 'posts-id' && !this.isIndex) {
            this.$router.replace('/posts')
          } else {
            this.fetchContents()
          }
          this.dialog = false
          this.flashMessage({ message: '削除しました', type: 'primary', status: true })
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.log('投稿の削除に失敗', err)
        })
    },
    fetchContents () {
      this.$emit('fetchContents')
    },
    commentsCountDecrement () {
      this.$emit('commentsCountDecrement')
    }
  }
}
</script>
