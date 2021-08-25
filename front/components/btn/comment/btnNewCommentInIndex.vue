<template>
  <div>
    <v-btn
      :color="btnColor"
      text
      rounded
      @click.prevent.stop="dialog = true, setPostId()"
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
            {{ post.user.name }}
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
              返信先：{{ post.user.name }} さん
            </v-card-text>
          </div>
        </div>
        <v-container>
          <v-form
            ref="form"
            v-model="isValid"
          >
            <new-comment-form
              :content.sync="newComment.content"
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
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import newCommentForm from '../../comment/newCommentForm.vue'

export default {
  components: {
    newCommentForm
  },
  props: {
    post: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      dialog: false,
      isValid: false,
      loading: false,
      newComment: { content: '' },
      src: 'https://picsum.photos/200/200'
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data',
      btnColor: 'btn/color'
    })
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage',
      setPosts: 'post/setPosts'
    }),
    setPostId () {
      this.newComment.post_id = this.post.id
    },
    async submitComment () {
      this.loading = true
      this.newComment.user_id = this.currentUser.id
      await this.$axios.$post('/api/v1/comments', this.newComment)
        .then(() => {
          this.loading = false
          this.fetchContents()
          this.dialog = false
          this.flashMessage({ message: 'コメントしました', type: 'primary', status: true })
          this.$refs.form.reset()
        })
        .catch(() => {
          this.flashMessage({ message: 'コメントに失敗しました', type: 'error', status: true })
        })
    },
    async fetchContents () {
      const url = 'api/v1/posts'
      await this.$axios.get(url)
        .then((res) => {
          this.setPosts(res.data)
        })
    }
  }
}
</script>

<style scoped>
</style>
