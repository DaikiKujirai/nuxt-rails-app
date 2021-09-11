<template>
  <v-row>
    <v-col class="pa-0">
      <v-card-actions class="justify-space-around">
        <btn-new-comment
          ref="child"
          :post="post"
          :is-list="isList"
          @rollBackPage="rollBackPage"
          @fetchContents="fetchContents"
        />
        <template v-if="post.user_id !== currentUser.id">
          <v-btn
            :color="btnColor"
            text
          >
            <v-icon v-text="'mdi-repeat-variant'" />
          </v-btn>
        </template>
        <btn-like
          :post="post"
          :is-list="isList"
          @likesCountIncrement="likesCountIncrement"
          @likesCountDecrement="likesCountDecrement"
        />
        <template v-if="post.user_id === currentUser.id">
          <btn-edit-post
            :post="post"
            :is-list="isList"
            @rollBackPage="rollBackPage"
            @fetchContents="fetchContents"
          />
          <btn-delete-post
            :post="post"
            :is-list="isList"
            @rollBackPage="rollBackPage"
            @fetchContents="fetchContents"
          />
        </template>
      </v-card-actions>
    </v-col>
  </v-row>
</template>

<script>
import { mapGetters } from 'vuex'
import BtnNewComment from '../../btn/comment/btnNewComment.vue'
import BtnDeletePost from '../../btn/deletePost/btnDeletePost.vue'
import BtnEditPost from '../../btn/editPost/btnEditPost.vue'
import BtnLike from '../../btn/like/btnLike.vue'

export default {
  components: {
    BtnLike,
    BtnNewComment,
    BtnEditPost,
    BtnDeletePost
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
      commentsCount: 0
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data',
      isAuthenticated: 'auth/isAuthenticated',
      btnColor: 'btn/color'
    })
  },
  methods: {
    fetchContents () {
      this.$emit('fetchContents')
    },
    fetchComments () {
      this.$refs.child.fetchComments()
    },
    rollBackPage () {
      this.$emit('rollBackPage')
    },
    likesCountIncrement () {
      this.$emit('likesCountIncrement')
    },
    likesCountDecrement () {
      this.$emit('likesCountDecrement')
    }
  }
}
</script>
