<template>
  <div>
    <template v-if="!isLikePost">
      <v-btn
        :color="btnColor"
        text
        rounded
        @click.prevent.stop="likePost"
      >
        <v-icon v-text="'mdi-heart-outline'" />
      </v-btn>
    </template>
    <template v-else>
      <v-btn
        :color="btnColor"
        text
        rounded
        @click.prevent.stop="disLikePost"
      >
        <v-icon v-text="'mdi-heart'" />
      </v-btn>
    </template>
    <template v-if="likePostCount">
      {{ likePostCount }}
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
      newLike: {},
      likePostCount: this.post.like_posts.length
    }
  },
  computed: {
    ...mapGetters({
      btnColor: 'btn/color',
      currentUser: 'auth/data',
      likePostIds: 'like/likePostIds'
    }),
    isLikePost () {
      return this.likePostIds.includes(this.post.id)
    }
  },
  methods: {
    ...mapActions({
      setLikePosts: 'like/setLikePosts',
      flashMessage: 'flash/flashMessage'
    }),
    async likePost () {
      this.newLike.user_id = this.currentUser.id
      this.newLike.post_id = this.post.id
      const url = '/api/v1/like_posts'
      await this.$axios.post(url, this.newLike)
        .then((res) => {
          this.likePostCount++
          this.setLikePosts(res.data)
          this.flashMessage({ message: 'いいねしました', type: 'success', status: true })
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    disLikePost () {
      const url = '/api/v1/like_posts/delete'
      this.$axios.$delete(url, {
        data: {
          user_id: this.currentUser.id,
          post_id: this.post.id
        }
      })
        .then((res) => {
          this.likePostCount--
          this.setLikePosts(res)
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
