<template>
  <div>
    <v-btn
      :color="color"
      text
      rounded
      @click="dialog = true, setPost()"
    >
      編集
      <v-icon>
        mdi-lead-pencil
      </v-icon>
    </v-btn>
    <v-dialog
      v-model="dialog"
      width="500"
    >
      <v-card>
        <div class="d-flex">
          <v-card-title>
            投稿編集
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
            <edit-post-form-title
              :title.sync="post.title"
            />
            <edit-post-form-content
              :content.sync="post.content"
            />
            <v-btn
              :disabled="!isValid || loading"
              :loading="loading"
              block
              color="info"
              @click="updatePost"
            >
              更新する
            </v-btn>
          </v-form>
        </v-container>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import editPostFormContent from './editPostFormContent.vue'
import editPostFormTitle from './editPostFormTitle.vue'

export default {
  components: {
    editPostFormTitle,
    editPostFormContent
  },
  data () {
    return {
      dialog: false,
      isValid: false,
      loading: false,
      color: 'deep-purple lighten-2',
      post: { title: '', content: '' }
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data'
    })
  },
  mounted () {
    this.$nextTick(() => {
      this.$nuxt.$loading.start()
      setTimeout(() => this.$nuxt.$loading.finish(), 500)
    })
  },
  methods: {
    ...mapActions({
      showMessage: 'flash/showMessage'
    }),
    async setPost () {
      const url = `/api/v1/posts/${this.$route.params.id}`
      await this.$axios.get(url)
        .then((res) => {
          this.post.title = res.data.title
          this.post.content = res.data.content
        })
        .catch((err) => {
          console.error(err) // eslint-disable-line
        })
    },
    updatePost () {
      this.loading = true
      this.$axios.$patch(`/api/v1/posts/${this.$route.params.id}`, this.post)
        .then((res) => {
          // eslint-disable-next-line no-console
          console.log('更新しました', res)
          this.loading = false
          this.dialog = false
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.log(err.response)
          this.showMessage({ message: err.response.data.message.join('\n'), type: 'error', status: true })
          this.loading = false
        })
    }
  }
}
</script>
