<template>
  <div>
    <v-tooltip bottom>
      <template #activator="{ on, attrs }">
        <v-btn
          :color="btnColor"
          icon
          v-bind="attrs"
          v-on="on"
          @click.prevent.stop="dialog = true"
        >
          <v-icon v-text="'mdi-lead-pencil'" />
        </v-btn>
      </template>
      <span>編集</span>
    </v-tooltip>
    <v-dialog
      v-model="dialog"
      width="550"
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
            <v-row>
              <v-col class="d-flex">
                <input-file-form
                  @setImageInPostImage="image = $event"
                  @setImageInPreview="preview = $event"
                />
                <v-img
                  :src="preview"
                  height="80px"
                  width="80px"
                  contain
                  class="mb-3"
                />
              </v-col>
            </v-row>
            <v-row>
              <v-col class="text-center pt-0">
                <v-btn
                  :disabled="!isValid || loading"
                  :loading="loading"
                  rounded
                  color="info"
                  @click="updatePost"
                >
                  更新する
                </v-btn>
              </v-col>
            </v-row>
          </v-form>
        </v-container>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import editPostFormContent from '../../post/editPostFormContent.vue'
import InputFileForm from '../../post/InputFileForm.vue'

export default {
  components: {
    editPostFormContent,
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
      editPost: { content: '' },
      image: '',
      preview: ''
    }
  },
  computed: {
    ...mapGetters({
      btnColor: 'btn/color'
    })
  },
  mounted () {
    this.editPost.content = this.post.content
    this.image = this.post.image.url
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage'
    }),
    async updatePost () {
      this.loading = true
      const formData = new FormData()
      formData.append('post[user_id]', this.post.user_id)
      formData.append('post[post_id]', this.post.id)
      formData.append('post[content]', this.editPost.content)
      if (this.image) {
        formData.append('post[image]', this.image)
      }
      await this.$axios.$patch(`/api/v1/posts/${this.post.id}`, formData)
        .then(() => {
          this.rollBackPage()
          if (this.$route.name === 'posts-id' && !this.isList) {
            this.fetchContents()
          } else {
            this.$router.push(`/posts/${this.post.id}`)
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
    fetchContents () {
      this.$emit('fetchContents')
    },
    rollBackPage () {
      this.$emit('rollBackPage')
    }
  }
}
</script>
