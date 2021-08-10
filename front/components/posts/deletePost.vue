<template>
  <div>
    <v-btn
      :color="color"
      text
      rounded
      @click="openDialog"
    >
      削除
      <v-icon>
        mdi-delete-empty
      </v-icon>
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
export default {
  data () {
    return {
      post: {},
      dialog: false,
      color: 'deep-purple lighten-2'
    }
  },
  mounted () {
    this.fetchContents()
  },
  methods: {
    fetchContents () {
      const url = `/api/v1/posts/${this.$route.params.id}`
      this.$axios.get(url)
        .then((res) => {
          // eslint-disable-next-line
          console.log('投稿詳細')
          this.post = res.data
        })
        .catch((err) => {
          console.error(err) // eslint-disable-line
        })
    },
    openDialog () {
      this.dialog = true
    },
    closeDialog () {
      this.dialog = false
    },
    clickOK () {
      this.$axios.$delete(`/api/v1/posts/${this.post.id}`)
        .then((res) => {
          // eslint-disable-next-line no-console
          console.log('投稿を削除しました', res)
          this.$router.push('/posts')
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.log('投稿の削除に失敗', err)
        })
    }
  }
}
</script>
