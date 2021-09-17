<template>
  <div>
    <v-btn
      large
      rounded
      color="info"
      class="mb-5"
      @click="dialog = true"
    >
      投稿する
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
            <new-post-form-content
              :content.sync="content"
            />
            <v-row>
              <v-col class="d-flex">
                <input-file-form
                  @setImageInPostImage="image = $event"
                  @setImageInPreview="preview = $event"
                />
                <v-img
                  :src="preview"
                  height="80px"
                  width="80px"
                  contain
                  class="mb-3"
                />
              </v-col>
            </v-row>
            <v-btn
              :disabled="!isValid || loading"
              :loading="loading"
              block
              color="info"
              @click="submitPost"
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
import InputFileForm from '../../post/InputFileForm.vue'
import newPostFormContent from './newPostFormContent.vue'

export default {
  components: {
    newPostFormContent,
    InputFileForm
  },
  data () {
    return {
      dialog: false,
      isValid: false,
      loading: false,
      content: '',
      image: '',
      preview: ''
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data'
    })
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage',
      setIsNewPost: 'post/setIsNewPost'
    }),
    async submitPost () {
      this.loading = true
      const formData = new FormData()
      formData.append('post[user_id]', this.currentUser.id)
      formData.append('post[content]', this.content)
      if (this.image) {
        formData.append('post[image]', this.image)
      }
      await this.$axios.$post('/api/v1/posts', formData)
        .then(() => {
          this.flashMessage({ message: '投稿しました', type: 'primary', status: true })
          if (this.$route.name === 'posts') {
            this.setIsNewPost(true)
          } else {
            this.$router.push('/posts')
          }
          this.loading = false
          this.dialog = false
          this.$refs.form.reset()
        })
        .catch(() => {
          this.flashMessage({ message: '失敗しました', type: 'error', status: true })
          this.loading = false
        })
    }
  }
}
</script>
