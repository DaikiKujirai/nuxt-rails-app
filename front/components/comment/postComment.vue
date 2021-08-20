<template>
  <div>
    <template
      v-for="comment in comments"
    >
      <v-col :key="comment.id">
        <v-divider />
        <v-col class="d-flex">
          <v-img
            :src="src"
            max-height="70"
            max-width="70"
            contain
            style="border-radius: 50%;"
          />
          <v-card-subtitle>
            {{ comment.user.name }}
          </v-card-subtitle>
        </v-col>
        <v-card-text>
          {{ comment.content }}
        </v-card-text>
        <v-card-actions>
          <v-btn
            :color="color"
            text
          >
            いいね
            <v-icon>
              mdi-heart-outline
            </v-icon>
          </v-btn>
          <v-spacer />
          <btn-new-comment
            :comment="comment"
          />
          <v-spacer />
          <btnEdit-post />
          <v-spacer />
          <btnDelete-post />
        </v-card-actions>
      </v-col>
    </template>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import btnEditPost from '../btn/btnEditPost.vue'
import btnDeletePost from '../btn/btnDeletePost.vue'
import btnNewComment from '../btn/btnNewComment.vue'

export default {
  components: {
    btnEditPost,
    btnDeletePost,
    btnNewComment
  },
  data () {
    return {
      src: 'https://picsum.photos/500/500',
      color: 'deep-purple lighten-2'
    }
  },
  computed: {
    ...mapGetters({
      comments: 'comment/comments'
    })
  }
}
</script>
