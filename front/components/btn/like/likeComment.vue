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
      v-if="likeCount && isIndex"
      class="pl-0"
    >
      {{ likeCount }}
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
      isLike: false
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data',
      btnColor: 'btn/color'
    }),
    likeCount () {
      return this.likeCommentUserIds.length
    }
  },
  mounted () {
    setTimeout(() => {
      this.pushLikeCommentUserIds()
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
