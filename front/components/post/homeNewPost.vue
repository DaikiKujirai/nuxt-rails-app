<template>
  <v-row>
    <v-col>
      <v-card class="pa-3">
        <v-form
          ref="form"
          v-model="isValid"
        >
          <v-row>
            <v-col class="d-flex">
              <v-img
                :src="src"
                max-height="70"
                max-width="70"
                contain
                style="border-radius: 50%;"
              />
              <home-new-post-form-content
                :content.sync="post.content"
              />
            </v-col>
          </v-row>
          <v-row>
            <v-col class="d-flex justify-end">
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

export default {
  components: { homeNewPostFormContent },
  data () {
    return {
      dialog: false,
      isValid: false,
      loading: false,
      post: { content: '' },
      src: 'https://picsum.photos/200/200'
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
      this.post.user_id = this.currentUser.id
      await this.$axios.post('/api/v1/posts', this.post)
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
    rollBackPage () {
      this.$emit('rollBackPage')
    },
    fetchContents () {
      this.$emit('fetchContents')
    }
  }
}
</script>
