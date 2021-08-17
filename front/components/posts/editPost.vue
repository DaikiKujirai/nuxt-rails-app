<template>
  <div>
    <v-btn
      :color="color"
      text
      rounded
      @click="dialog = true, setPostContent()"
    >
      編集
      <v-icon>
        mdi-lead-pencil
      </v-icon>
    </v-btn>
    <v-dialog
      v-model="dialog"
      width="500"
    >
      <v-card>
        <div class="d-flex">
          <v-card-title>
            投稿編集
          </v-card-title>
          <v-spacer />
          <v-btn
            icon
            @click="dialog = false"
          >
            ✖︎
          </v-btn>
        </div>
        <v-container>
          <v-form
            ref="form"
            v-model="isValid"
          >
            <edit-post-form-content
              :content.sync="post.content"
            />
            <v-btn
              :disabled="!isValid || loading"
              :loading="loading"
              block
              color="info"
              @click="updatePost"
            >
              更新する
            </v-btn>
          </v-form>
        </v-container>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import { mapActions } from 'vuex'
import editPostFormContent from './editPostFormContent.vue'

export default {
  components: {
    editPostFormContent
  },
  data () {
    return {
      dialog: false,
      isValid: false,
      loading: false,
      color: 'deep-purple lighten-2',
      post: {}
    }
  },
  computed: {
    postContent () {
      // return this.$store.state.post.content
      return this.post.content
    }
  },
  mounted () {
    this.setPostContent()
  },
  methods: {
    ...mapActions({
      showMessage: 'flash/showMessage',
      setPost: 'post/setPost'
    }),
    async setPostContent () {
      const url = `/api/v1/posts/${this.$route.params.id}`
      await this.$axios.get(url)
        .then((res) => {
          this.post = res.data
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    async updatePost () {
      this.loading = true
      await this.$axios.$patch(`/api/v1/posts/${this.$route.params.id}`, this.post)
        .then((res) => {
          this.setPost(res)
          this.showMessage({ message: '更新しました', type: 'primary', status: true })
          this.loading = false
          this.dialog = false
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.log(err.response)
          this.showMessage({ message: err.response.data.message.join('\n'), type: 'error', status: true })
          this.loading = false
        })
    }
  }
}
</script>
