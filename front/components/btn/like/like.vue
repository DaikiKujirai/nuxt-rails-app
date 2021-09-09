<template>
  <div>
    <template v-if="!isLike">
      <v-btn
        :color="btnColor"
        icon
        @click.prevent.stop="like"
      >
        <v-icon v-text="'mdi-heart-outline'" />
      </v-btn>
    </template>
    <template v-else>
      <v-btn
        :color="btnColor"
        icon
        @click.prevent.stop="disLike"
      >
        <v-icon v-text="'mdi-heart'" />
      </v-btn>
    </template>
    <template v-if="likesCount && isList">
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
    isList: {
      type: Boolean,
      required: true
    }
  },
  data () {
    return {
      likesCount: 0,
      newLike: {},
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
    if (this.$route.name === 'posts-id' && !this.isList) {
      this.fetchContents(this.$route.params.id)
    } else {
      this.fetchContents(this.post.id)
    }
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage',
      setLikesCountPagePostId: 'like/setLikesCountPagePostId',
      likesCountPagePostIdIncrement: 'like/likesCountPagePostIdIncrement',
      likesCountPagePostIdDecrement: 'like/likesCountPagePostIdDecrement'
    }),
    async like () {
      this.newLike.user_id = this.currentUser.id
      this.newLike.post_id = this.post.id
      const url = '/api/v1/likes'
      await this.$axios.post(url, this.newLike)
        .then(() => {
          if (this.$route.name === 'posts-id' && !this.isList) {
            this.likesCountPagePostIdIncrement()
          } else {
            this.likesCountIncrement()
          }
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
          if (this.$route.name === 'posts-id' && !this.isList) {
            this.likesCountPagePostIdDecrement()
          } else {
            this.likesCountDecrement()
          }
          this.isLike = false
          this.flashMessage({ message: 'いいねを取り消しました', type: 'error', status: true })
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    async fetchContents (id) {
      const url = `/api/v1/render_is_like_and_likes_count/${id}`
      await this.$axios.get(url, {
        params: {
          user_id: this.currentUser.id
        }
      })
        .then((res) => {
          this.isLike = res.data.is_like
          this.likesCount = res.data.likes_count
          if (this.$route.name === 'posts-id' && !this.isList) {
            this.setLikesCountPagePostId(res.data.likes_count)
          }
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    likesCountIncrement () {
      this.likesCount++
    },
    likesCountDecrement () {
      this.likesCount--
    }
  }
}
</script>
