<template>
  <div>
    <template v-if="!isLikeComment">
      <v-btn
        :color="btnColor"
        text
        rounded
        @click.prevent.stop="likeComment"
      >
        <v-icon v-text="'mdi-heart-outline'" />
      </v-btn>
    </template>
    <template v-else>
      <v-btn
        :color="btnColor"
        text
        rounded
        @click.prevent.stop="unLikeComment"
      >
        <v-icon v-text="'mdi-heart'" />
      </v-btn>
    </template>
    <template v-if="likeCommentCount">
      {{ likeCommentCount }}
    </template>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
  props: {
    comment: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      newLike: {},
      likeCommentCount: this.comment.like_comments.length
    }
  },
  computed: {
    ...mapGetters({
      btnColor: 'btn/color',
      currentUser: 'auth/data',
      likeCommentIds: 'like/likeCommentIds'
    }),
    isLikeComment () {
      return this.likeCommentIds.includes(this.comment.id)
    }
  },
  methods: {
    ...mapActions({
      setLikeComments: 'like/setLikeComments',
      flashMessage: 'flash/flashMessage'
    }),
    async likeComment () {
      this.newLike.user_id = this.currentUser.id
      this.newLike.comment_id = this.comment.id
      const url = 'api/v1/like_comments'
      await this.$axios.post(url, this.newLike)
        .then((res) => {
          this.likeCommentCount++
          this.setLikeComments(res.data)
          this.flashMessage({ message: 'いいねしました', type: 'success', status: true })
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    async unLikeComment () {
      const url = 'api/v1/like_comments/delete'
      await this.$axios.$delete(url, {
        data: {
          user_id: this.currentUser.id,
          comment_id: this.comment.id
        }
      })
        .then((res) => {
          this.likeCommentCount--
          this.setLikeComments(res)
          this.flashMessage({ message: 'いいねを取り消しました', type: 'error', status: true })
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    }
  }
}
</script>
