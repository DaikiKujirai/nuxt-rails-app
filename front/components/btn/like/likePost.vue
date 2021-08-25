<template>
  <div>
    <template v-if="!isLikePost">
      <v-btn
        :color="btnColor"
        text
        @click.prevent.stop="likePost"
      >
        <v-icon v-text="'mdi-heart-outline'" />
      </v-btn>
    </template>
    <template v-else>
      <v-btn
        :color="btnColor"
        text
        @click.prevent.stop="unLikePost"
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
    post: {
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
      likePostIds: 'like/likePostIds',
      likeCommentIds: 'like/likeCommentIds'
    }),
    isLikePost () {
      return this.likePostIds.includes(this.post.id)
    }
  },
  methods: {
    ...mapActions({
      setLikes: 'like/setLikes',
      flashMessage: 'flash/flashMessage'
    }),
    async likePost () {
      this.newLike.user_id = this.currentUser.id
      this.newLike.likeable_id = this.post.id
      this.newLike.likeable_type = 'post'
      const url = 'api/v1/like_post'
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
    async unLikePost () {
      const url = `api/v1/unlike_post/${this.post.id}`
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
