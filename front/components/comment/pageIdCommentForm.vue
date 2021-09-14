<template>
  <div class="pa-3">
    <v-form
      ref="form"
      v-model="isValid"
    >
      <v-row>
        <v-col class="d-flex">
          <v-img
            :src="currentUser.avatar.url"
            max-height="70"
            max-width="70"
            contain
            style="border-radius: 50%; cursor: pointer;"
            class="img"
            @click.prevent.stop="toShow('users', currentUser.id)"
          />
          <page-id-post-comment-form
            :content.sync="content"
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
            @click="submitComment"
            v-text="'コメントする'"
          />
        </v-col>
      </v-row>
    </v-form>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import InputFileForm from '../post/InputFileForm.vue'
import pageIdPostCommentForm from './pageIdCommentFormContent.vue'

export default {
  components: {
    pageIdPostCommentForm,
    InputFileForm
  },
  props: {
    post: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      isValid: false,
      loading: false,
      image: '',
      preview: '',
      content: ''
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
      commentsCountPagePostIdIncrement: 'post/commentsCountPagePostIdIncrement'
    }),
    async submitComment () {
      this.loading = true
      const formData = new FormData()
      formData.append('post[user_id]', this.currentUser.id)
      formData.append('post[content]', this.content)
      formData.append('post[post_id]', this.post.id)
      if (this.image) {
        formData.append('post[image]', this.image)
      }
      await this.$axios.$post('/api/v1/create_comment', formData)
        .then(() => {
          this.commentsCountPagePostIdIncrement()
          this.fetchContents()
          this.flashMessage({ message: 'コメントしました', type: 'primary', status: true })
          this.loading = false
          this.$refs.form.reset()
        })
        .catch(() => {
          this.loading = false
          this.flashMessage({ message: 'コメントに失敗しました', type: 'error', status: true })
        })
    },
    fetchContents () {
      this.$emit('fetchContents')
    },
    commentsCountIncrement () {
      this.$emit('commentsCountIncrement')
    },
    toShow (url, id) {
      this.$router.push(`/${url}/${id}`)
    }
  }
}
</script>
