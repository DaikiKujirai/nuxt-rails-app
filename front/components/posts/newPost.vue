<template>
  <div>
    <v-btn
      rounded
      color="info"
      class="open-modal-btn mr-2"
      @click="dialog = true"
    >
      新規投稿
    </v-btn>
    {{ posts }}
    <v-dialog
      v-model="dialog"
      width="500"
    >
      <v-card>
        <div class="d-flex">
          <v-card-title>
            新規投稿
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
            <new-post-form-content
              :content.sync="post.content"
            />
            <v-btn
              :disabled="!isValid || loading"
              :loading="loading"
              block
              color="info"
              @click="newPost"
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
import newPostFormContent from './newPostFormContent.vue'

export default {
  components: {
    newPostFormContent
  },
  data () {
    return {
      dialog: false,
      isValid: false,
      loading: false,
      post: { user_uid: '', content: '' }
    }
  },
  computed: {
    ...mapGetters({
      user: 'auth/user',
      posts: 'post/posts'
    })
  },
  methods: {
    ...mapActions({
      showMessage: 'flash/showMessage',
      setPosts: 'post/setPosts'
    }),
    fetchContents () {
      this.$axios.get('/api/v1/posts')
        .then((res) => {
          console.log(res)
          this.setPosts(res.data)
        })
    },
    async newPost () {
      this.loading = true
      this.post.user_uid = this.user.uid
      await this.$axios.$post('/api/v1/posts', this.post)
        .then((res) => {
          this.showMessage({ message: '投稿しました', type: 'primary', status: true })
          console.log(res)
          this.fetchContents()
          this.loading = false
          this.$router.push('/posts')
          this.dialog = false
        })
        .catch((err) => {
          this.showMessage({ message: err.response.data.message.join('\n'), type: 'error', status: true })
          this.loading = false
        })
    }
  }
}
</script>
