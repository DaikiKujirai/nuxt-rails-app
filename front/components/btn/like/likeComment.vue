<template>
  <div>
    <template v-if="!isLike">
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
        @click.prevent.stop="disLikeComment"
      >
        <v-icon v-text="'mdi-heart'" />
      </v-btn>
    </template>
    <template
      v-if="likeCommentCount && isIndex"
      class="pl-0"
    >
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
    },
    likeComments: {
      type: Array,
      required: true
    },
    isIndex: {
      type: Boolean,
      required: true
    }
  },
  data () {
    return {
      likeCommentUserIds: [],
      newLike: {},
      likeCommentCount: 0,
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
      this.pushLikeCommentUserIds()
      this.likeCommentCount = this.likeComments.length
    }, 400)
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage'
    }),
    async likeComment () {
      this.newLike.user_id = this.currentUser.id
      this.newLike.comment_id = this.comment.id
      const url = '/api/v1/like_comments'
      await this.$axios.post(url, this.newLike)
        .then(() => {
          this.likeCommentCount++
          this.likeCountIncrement()
          this.likeCommentUserIds.push(this.currentUser.id)
          this.isLike = true
          this.flashMessage({ message: 'いいねしました', type: 'success', status: true })
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    disLikeComment () {
      const url = '/api/v1/like_comments/delete'
      this.$axios.$delete(url, {
        data: {
          user_id: this.currentUser.id,
          comment_id: this.comment.id
        }
      })
        .then(() => {
          this.likeCommentCount--
          this.likeCountDecrement()
          this.isLike = false
          const th = this.likeCommentUserIds.indexOf(this.currentUser.id)
          this.likeCommentUserIds.splice(th, 1)
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
    pushLikeCommentUserIds () {
      for (let i = 0; i < this.likeComments.length; i++) {
        this.likeCommentUserIds.push(this.likeComments[i].user_id)
      }
      this.searchMyLike()
    },
    searchMyLike () {
      if (this.likeCommentUserIds.includes(this.currentUser.id)) {
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
