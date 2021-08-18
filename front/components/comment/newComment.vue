<template>
  <div>
    <v-btn
      :color="color"
      text
      rounded
      @click="dialog = true"
    >
      コメント
      <v-icon>
        mdi-chat-processing-outline
      </v-icon>
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
            {{ userName }}
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
              {{ gettersPost.content }}
            </v-card-subtitle>
            <v-spacer />
            <v-card-text>
              返信先：{{ userName }} さん
            </v-card-text>
          </div>
        </div>
        <v-container>
          <v-form
            ref="form"
            v-model="isValid"
          >
            <new-comment-form
              :comment.sync="comment.comment"
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
import newCommentForm from './newCommentForm.vue'

export default {
  components: {
    newCommentForm
  },
  data () {
    return {
      dialog: false,
      isValid: false,
      loading: false,
      src: 'https://picsum.photos/500/500',
      color: 'deep-purple lighten-2',
      comment: {},
      post: {},
      user: {}
    }
  },
  computed: {
    ...mapGetters({
      gettersPost: 'post/post',
      gettersUser: 'post/user'
    }),
    userName () {
      return this.gettersUser.name
    }
  },
  methods: {
    ...mapActions({
      setUser: 'post/setUser'
    }),
    async submitComment () {
      this.loading = true
      await this.$axios.$post('/api/v1/comments', this.comment)
    }
  }
}
</script>
