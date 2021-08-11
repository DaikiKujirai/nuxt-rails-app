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
            <new-post-form-title
              :title.sync="params.post.title"
            />
            <new-post-form-content
              :content.sync="params.post.content"
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
import newPostFormTitle from './newPostFormTitle.vue'

export default {
  components: {
    newPostFormTitle,
    newPostFormContent
  },
  data () {
    return {
      dialog: false,
      isValid: false,
      loading: false,
      params: { post: { title: '', content: '' } }
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data'
    })
  },
  methods: {
    ...mapActions({
      showMessage: 'flash/showMessage'
    }),
    async newPost () {
      this.loading = true
      await this.$axios.$post('/api/v1/posts', this.params)
        .then((res) => {
          // eslint-disable-next-line no-console
          console.log('投稿しました', res)
          this.showMessage({ message: '投稿しました', type: 'primary', status: true })
          this.loading = false
          this.$router.push('/posts')
          this.dialog = false
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.log('投稿エラー', err.response)
          this.showMessage({ message: err.response.data.message.join('\n'), type: 'error', status: true })
          this.loading = false
        })
    }
  }
}
</script>
