<template>
  <div>
    {{ isLikePost }}
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
      likePosts: [],
      likePostIds: [],
      newLike: {},
      likePostCount: 0,
      isLikePost: false
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data',
      btnColor: 'btn/color'
    })
  },
  mounted () {
    this.likePosts = this.post.like_posts
    this.setLikePostIdsAndSearchMyLike()
    this.likePostCount = this.likePosts.length
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
        .then(() => {
          this.likePostCount++
          this.isLikePost = true
          this.likePostIds.push(this.currentUser.id)
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
        .then(() => {
          this.likePostCount--
          this.isLikePost = false
          this.likePostIds.filter(item => item === this.currentUser.id)
          this.flashMessage({ message: 'いいねを取り消しました', type: 'error', status: true })
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    setLikePostIdsAndSearchMyLike () {
      for (let i = 0; i < this.likePosts.length; i++) {
        this.likePostIds.push(this.likePosts[i].user_id)
      }
      if (this.likePostIds.includes(this.currentUser.id)) {
        this.isLikePost = true
      }
    }
  }
}
</script>
