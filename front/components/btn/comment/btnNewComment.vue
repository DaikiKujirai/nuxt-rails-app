<template>
  <div>
    <v-btn
      :color="btnColor"
      icon
      class="pl-1"
      @click.prevent.stop="dialog = true"
    >
      <v-icon v-text="'mdi-chat-processing-outline'" />
      &nbsp;
    </v-btn>
    <v-dialog
      v-model="dialog"
      width="500"
    >
      <v-card class="pa-2">
        <div class="d-flex">
          <v-spacer />
          <v-btn
            icon
            @click="dialog = false"
          >
            ✖︎
          </v-btn>
        </div>
        <div class="d-flex">
          <v-img
            :src="src"
            max-height="60"
            max-width="60"
            contain
            style="border-radius: 50%;"
            class="ml-2"
          />
          <v-card-title>
            {{ post.user_name }}
          </v-card-title>
        </div>
        <div class="d-flex">
          <v-divider
            vertical
            inset
            class="ml-9"
          />
          <div>
            <v-card-subtitle>
              {{ post.content }}
            </v-card-subtitle>
            <v-spacer />
            <v-card-text>
              返信先：{{ post.user_name }} さん
            </v-card-text>
          </div>
        </div>
        <v-container>
          <v-form
            ref="form"
            v-model="isValid"
          >
            <new-comment-form
              :content.sync="content"
            />
            <input-file-form
              @setImageInPostImage="image = $event"
            />
            <v-btn
              :disabled="!isValid || loading"
              :loading="loading"
              block
              color="info"
              @click="submitComment"
            >
              投稿する
            </v-btn>
          </v-form>
        </v-container>
      </v-card>
    </v-dialog>
    <template v-if="isList && commentsCount">
      {{ commentsCount }}
    </template>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import newCommentForm from '../../btn/comment/newCommentForm.vue'
import InputFileForm from '../../post/InputFileForm.vue'

export default {
  components: {
    newCommentForm,
    InputFileForm
  },
  props: {
    post: {
      type: Object,
      required: true
    },
    isList: {
      type: Boolean,
      required: true
    }
  },
  data () {
    return {
      dialog: false,
      isValid: false,
      loading: false,
      comments: [],
      commentsCount: 0,
      content: '',
      image: '',
      src: 'https://picsum.photos/200/200'
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data',
      btnColor: 'btn/color',
      commentsCountPagePostId: 'post/commentsCountPagePostId'
    })
  },
  mounted () {
    this.$nextTick(() => {
      this.fetchComments()
    })
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage',
      setCommentsCountPagePostId: 'post/setCommentsCountPagePostId',
      commentsCountPagePostIdIncrement: 'post/commentsCountPagePostIdIncrement',
      commentsCountPagePostIdDecrement: 'post/commentsCountPagePostIdDecrement'
    }),
    async fetchComments () {
      const url = `/api/v1/find_comments/${this.post.id}`
      await this.$axios.get(url)
        .then((res) => {
          this.comments = res.data.comments
          this.commentsCount = res.data.kaminari.pagination.count
          if (this.$route.name === 'posts-id' && this.post.id === Number(this.$route.params.id)) {
            this.setCommentsCountPagePostId(this.commentsCount)
          }
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    async submitComment () {
      this.loading = true
      const formData = new FormData()
      formData.append('post[user_id]', this.currentUser.id)
      formData.append('post[post_id]', this.post.id)
      formData.append('post[content]', this.content)
      if (this.image) {
        formData.append('post[image]', this.image)
      }
      await this.$axios.$post('/api/v1/posts', formData)
        .then(() => {
          this.rollBackPage()
          this.loading = false
          this.dialog = false
          this.flashMessage({ message: 'コメントしました', type: 'primary', status: true })
          this.$refs.form.reset()
          if (this.isList) {
            this.$router.push(`/posts/${this.post.id}`)
          } else {
            this.commentsCountPagePostIdIncrement()
            this.fetchContents()
          }
        })
        .catch(() => {
          this.flashMessage({ message: 'コメントに失敗しました', type: 'error', status: true })
        })
    },
    fetchContents () {
      this.$emit('fetchContents')
    },
    rollBackPage () {
      this.$emit('rollBackPage')
    }
  }
}
</script>
