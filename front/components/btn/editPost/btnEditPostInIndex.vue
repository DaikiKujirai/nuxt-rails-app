<template>
  <div>
    <v-btn
      :color="color"
      text
      rounded
      @click.prevent.stop="dialog = true"
    >
      編集
      <v-icon v-text="'mdi-lead-pencil'" />
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
            <edit-post-form-content
              :content.sync="editPost.content"
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
import { mapActions } from 'vuex'
import editPostFormContent from '../../post/editPostFormContent.vue'

export default {
  components: {
    editPostFormContent
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
      color: 'deep-purple lighten-2',
      editPost: { content: '' }
    }
  },
  created () {
    this.editPost.content = this.post.content
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage',
      setPost: 'post/setPost'
    }),
    async updatePost () {
      this.loading = true
      await this.$axios.$patch(`/api/v1/posts/${this.post.id}`, this.editPost)
        .then((res) => {
          this.setPost(res)
          this.flashMessage({ message: '更新しました', type: 'primary', status: true })
          this.loading = false
          this.dialog = false
          this.$router.push(`posts/${res.id}`)
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.log(err.response)
          this.flashMessage({ message: err.response.data.message.join('\n'), type: 'error', status: true })
          this.loading = false
        })
    }
  }
}
</script>
