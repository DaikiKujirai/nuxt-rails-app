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
              :content.sync="post.content"
            />
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
      post: { content: '' }
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
      await this.$axios.$post('/api/v1/posts', this.post)
        .then(() => {
          this.flashMessage({ message: '投稿しました', type: 'primary', status: true })
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
    fetchContents () {
      this.$emit('fetchContents')
    }
  }
}
</script>
