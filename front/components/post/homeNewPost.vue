<template>
  <v-row>
    <v-col>
      <v-card class="pa-3">
        <v-form
          ref="form"
          v-model="isValid"
        >
          <v-row>
            <v-col class="d-flex pb-0">
              <v-img
                :src="currentUser.avatar.url"
                height="70"
                max-width="70"
                style="border-radius: 50%; cursor: pointer;"
                class="img"
                @click="toMyPage"
              />
              <home-new-post-form-content
                :content.sync="content"
                @submitPost="submitPost"
              />
            </v-col>
          </v-row>
          <v-row>
            <v-col class="d-flex justify-end align-end pt-0">
              <input-file-form
                @setImageInPostImage="image = $event"
                @setImageInPreview="preview = $event"
              />
              <v-img
                :src="preview"
                height="80px"
                width="80px"
                contain
                class="mr-3"
              />
              <v-btn
                :disabled="!isValid || loading"
                :loading="loading"
                color="info"
                rounded
                @click="submitPost"
                v-text="'ツイートする'"
              />
            </v-col>
          </v-row>
        </v-form>
      </v-card>
    </v-col>
  </v-row>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import homeNewPostFormContent from './homeNewPostForm.vue'
import InputFileForm from './InputFileForm.vue'

export default {
  components: {
    homeNewPostFormContent,
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
      flashMessage: 'flash/flashMessage'
    }),
    async submitPost () {
      this.loading = true
      const formData = new FormData()
      formData.append('post[user_id]', this.currentUser.id)
      formData.append('post[content]', this.content)
      if (this.image) {
        formData.append('post[image]', this.image)
      }
      await this.$axios.post('/api/v1/posts', formData)
        .then(() => {
          this.flashMessage({ message: '投稿しました', type: 'primary', status: true })
          this.rollBackPage()
          this.fetchContents()
          this.loading = false
          this.dialog = false
          this.$refs.form.reset()
        })
        .catch(() => {
          this.flashMessage({ message: '失敗しました', type: 'error', status: true })
          this.loading = false
        })
    },
    toMyPage () {
      this.$router.push(`/users/${this.currentUser.id}`)
    },
    rollBackPage () {
      this.$emit('rollBackPage')
    },
    fetchContents () {
      this.$emit('fetchContents')
    }
  }
}
</script>

<style scoped>
  .img:hover {
    opacity: 0.7;
  }
</style>
