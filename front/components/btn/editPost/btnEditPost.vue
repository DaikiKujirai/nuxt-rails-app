<template>
  <div>
    <v-btn
      :color="btnColor"
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
import { mapGetters, mapActions } from 'vuex'
import editPostFormContent from '../../post/editPostFormContent.vue'

export default {
  components: {
    editPostFormContent
  },
  props: {
    post: {
      type: Object,
      required: true
    },
    isIndex: {
      type: Boolean,
      required: true
    }
  },
  data () {
    return {
      dialog: false,
      isValid: false,
      loading: false,
      editPost: { content: '' }
    }
  },
  computed: {
    ...mapGetters({
      btnColor: 'btn/color'
    })
  },
  mounted () {
    this.editPost.content = this.post.content
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage'
    }),
    async updatePost () {
      this.loading = true
      await this.$axios.$patch(`/api/v1/posts/${this.post.id}`, this.editPost)
        .then(() => {
          if (this.$route.name === 'users-id') {
            this.fetchUser()
          } else if (this.isIndex) {
            this.fetchPosts()
          } else {
            this.fetchPost()
          }
          this.flashMessage({ message: '更新しました', type: 'primary', status: true })
          this.loading = false
          this.dialog = false
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.log(err.response)
          this.flashMessage({ message: '更新に失敗しました', type: 'error', status: true })
          this.loading = false
        })
    },
    fetchPosts () {
      this.$emit('fetchPosts')
    },
    fetchPost () {
      this.$emit('fetchPost')
    },
    fetchUser () {
      this.$emit('fetchUser')
    }
  }
}
</script>
