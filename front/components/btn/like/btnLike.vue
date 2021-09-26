<template>
  <div>
    <template v-if="!isLike">
      <v-tooltip bottom>
        <template #activator="{ on, attrs }">
          <v-btn
            icon
            class="btn-like"
            v-bind="attrs"
            v-on="on"
            @click.prevent.stop="like"
          >
            <v-icon v-text="'mdi-heart-outline'" />
          </v-btn>
        </template>
        <span>いいね</span>
      </v-tooltip>
    </template>
    <template v-else>
      <v-btn
        color="#fa187f"
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
    likes: {
      type: Array,
      required: true
    },
    isList: {
      type: Boolean,
      required: true
    },
    user: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      likesCount: this.likes.length,
      newLike: {},
      isLike: false
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data'
    })
  },
  created () {
    this.fetchIsLike()
    if (this.$route.name === 'posts-id' && !this.isList) {
      this.setLikesCountPagePostId(this.likes.length)
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
      this.newLike.uid = this.user.uid
      const url = '/api/v1/likes'
      await this.$axios.post(url, this.newLike)
        .then(() => {
          this.$route.name === 'posts-id' && !this.isList
            ? (this.likesCountPagePostIdIncrement())
            : (this.likesCountIncrement())
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
          this.$route.name === 'posts-id' && !this.isList
            ? (this.likesCountPagePostIdDecrement())
            : (this.likesCountDecrement())
          this.isLike = false
          this.flashMessage({ message: 'いいねを取り消しました', type: 'error', status: true })
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    fetchIsLike () {
      if (this.likes.find(like => like.user_id === this.currentUser.id)) {
        this.isLike = true
      }
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

<style scoped>
  .btn-like:hover {
    color: #fa187f;
  }
</style>
