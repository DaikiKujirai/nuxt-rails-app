<template>
  <div>
    <v-btn
      :color="color"
      text
      @click="dialog = true"
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
              :title.sync="params.post.title"
            />
            <edit-post-form-content
              :content.sync="params.post.content"
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
import EditPostFormContent from './editPostFormContent.vue'
import EditPostFormTitle from './editPostFormTitle.vue'

export default {
  components: {
    EditPostFormTitle,
    EditPostFormContent
  },
  data () {
    return {
      dialog: false,
      isValid: false,
      loading: false,
      params: { post: { title: '', content: '' } },
      color: 'deep-purple lighten-2'
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
    async updatePost () {
      this.loading = true
      await this.$axios.$post('/api/v1/posts', this.params)
        .then((res) => {
          console.log('投稿しました', res)
          this.showMessage({ message: '投稿しました', type: 'primary', status: true })
          this.loading = false
          this.$router.push('/posts')
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
