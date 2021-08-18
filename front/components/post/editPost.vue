<template>
  <div>
    <v-btn
      :color="color"
      text
      rounded
      @click="dialog = true"
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
import { mapGetters, mapActions } from 'vuex'
import editPostFormContent from './editPostFormContent.vue'

export default {
  components: {
    editPostFormContent
  },
  // props: [
  //   'userName',
  //   'post'
  // ],
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
    ...mapGetters({
      gettersPost: 'post/post'
    }),
    params () {
      return this.post
    }
  },
  mounted () {
    this.setPostContent()
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage',
      setPost: 'post/setPost'
    }),
    setPostContent () {
      const url = `/api/v1/posts/${this.$route.params.id}`
      this.$axios.get(url)
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
          this.flashMessage({ message: '更新しました', type: 'primary', status: true })
          this.loading = false
          this.dialog = false
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.log(err.response)
          this.flashMessage({ message: err.response.data.message.join('\n'), type: 'error', status: true })
          this.loading = false
        })
    }
  }
}
</script>
