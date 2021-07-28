<template>
  <div>
    <v-btn
      rounded
      color="info"
      class="open-modal-btn"
      @click="dialog = true"
    >
      +
    </v-btn>
    <v-dialog
      v-model="dialog"
      width="500"
    >
      <v-card>
        <div class="d-flex">
          <v-card-title>
            新規登録
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
            <post-form-title
              :title.sync="params.post.title"
            />
            <post-form-content
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
            {{ params }}
          </v-form>
        </v-container>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import PostFormContent from './postFormContent.vue'
import postFormTitle from './postFormTitle.vue'

export default {
  components: {
    postFormTitle,
    PostFormContent
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
          console.log('投稿しました', res)
          this.showMessage({ message: '投稿しました', type: 'primary', status: true })
          this.loading = false
          this.$router.push('/')
          this.params = { post: { title: '', content: '' } }
          this.dialog = false
        })
        .catch((err) => {
          console.log(err.response)
          this.showMessage({ message: err.response.data.message.join('\n'), type: 'error', status: true })
          this.loading = false
        })
    }
  }
}
</script>
