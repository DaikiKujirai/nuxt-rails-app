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
      newLike: {}
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
      setLikes: 'like/setLikes',
      flashMessage: 'flash/flashMessage'
    }),
    async likeComment () {
      this.newLike.user_id = this.currentUser.id
      this.newLike.likeable_id = this.comment.id
      this.newLike.likeable_type = 'comment'
      const url = 'api/v1/like_comment'
      await this.$axios.post(url, this.newLike)
        .then((res) => {
          this.setLikes(res.data)
          this.flashMessage({ message: 'いいねしました', type: 'success', status: true })
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    async unLikeComment () {
      const url = `api/v1/unlike_comment/${this.comment.id}`
      await this.$axios.delete(url)
        .then((res) => {
          this.setLikes(res.data)
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
