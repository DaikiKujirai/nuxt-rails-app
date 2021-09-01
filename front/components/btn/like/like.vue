<template>
  <div>
    <template v-if="!isLike">
      <v-btn
        :color="btnColor"
        text
        rounded
        @click.prevent.stop="like"
      >
        <v-icon v-text="'mdi-heart-outline'" />
      </v-btn>
    </template>
    <template v-else>
      <v-btn
        :color="btnColor"
        text
        rounded
        @click.prevent.stop="disLike"
      >
        <v-icon v-text="'mdi-heart'" />
      </v-btn>
    </template>
    <template v-if="likesCount && isIndex">
      {{ likesCount }}
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
    likes: {
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
      likeUserIds: [],
      newLike: {},
      isLike: false
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data',
      btnColor: 'btn/color'
    }),
    likesCount () {
      return this.likeUserIds.length
    }
  },
  mounted () {
    setTimeout(() => {
      this.setLikeUserIds()
    }, 400)
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage'
    }),
    async like () {
      this.newLike.user_id = this.currentUser.id
      this.newLike.post_id = this.post.id
      const url = '/api/v1/likes'
      await this.$axios.post(url, this.newLike)
        .then(() => {
          this.likesCountIncrement()
          this.likeUserIds.push(this.currentUser.id)
          this.isLike = true
          this.flashMessage({ message: 'いいねしました', type: 'success', status: true })
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    disLike () {
      const url = '/api/v1/likes/delete'
      this.$axios.$delete(url, {
        data: {
          user_id: this.currentUser.id,
          post_id: this.post.id
        }
      })
        .then(() => {
          this.likesCountDecrement()
          this.isLike = false
          const th = this.likeUserIds.indexOf(this.currentUser.id)
          this.likeUserIds.splice(th, 1)
          this.flashMessage({ message: 'いいねを取り消しました', type: 'error', status: true })
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    setLikeUserIds () {
      for (let i = 0; i < this.likes.length; i++) {
        this.likeUserIds.push(this.likes[i].user_id)
      }
      this.searchMyLike()
    },
    searchMyLike () {
      if (this.likeUserIds.includes(this.currentUser.id)) {
        this.isLike = true
      }
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
