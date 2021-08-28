<template>
  <div>
    <template v-if="!isLike">
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
    },
    likePosts: {
      type: Array,
      required: true
    }
  },
  data () {
    return {
      likePostIds: [],
      newLike: {},
      likePostCount: 0,
      isLike: false
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data',
      btnColor: 'btn/color'
    })
  },
  mounted () {
    setTimeout(() => {
      this.setLikePostIds()
      this.likePostCount = this.likePosts.length
    }, 400)
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
          this.likeCountIncrement()
          this.likePostIds.push(this.currentUser.id)
          this.isLike = true
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
          this.likeCountDecrement()
          this.isLike = false
          const th = this.likePostIds.indexOf(this.currentUser.id)
          this.likePostIds.splice(th, 1)
          this.flashMessage({ message: 'いいねを取り消しました', type: 'error', status: true })
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    // async fetchContents () {
    //   console.log('post', this.post)
    //   const url = `/api/v1/like_posts/${this.post.id}`
    //   await this.$axios.get(url)
    //     .then((res) => {
    //       this.likePosts = res.data
    //       this.likePostCount = this.likePosts.length
    //       this.setLikePostIds()
    //     })
    //     .catch((err) => {
    //       // eslint-disable-next-line no-console
    //       console.error(err)
    //     })
    // },
    setLikePostIds () {
      for (let i = 0; i < this.likePosts.length; i++) {
        this.likePostIds.push(this.likePosts[i].user_id)
      }
      this.searchMyLike()
    },
    searchMyLike () {
      if (this.likePostIds.includes(this.currentUser.id)) {
        this.isLike = true
      }
    },
    likeCountIncrement () {
      this.$emit('likeCountIncrement')
    },
    likeCountDecrement () {
      this.$emit('likeCountDecrement')
    }
  }
}
</script>
