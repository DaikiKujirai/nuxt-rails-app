<template>
  <span>
    <template v-if="!isFollow">
      <v-btn
        color="info"
        outlined
        rounded
        @click.prevent.stop="follow"
      >
        フォローする
      </v-btn>
    </template>
    <template v-else-if="isFollow && !isHover">
      <v-btn
        color="primary"
        outlined
        rounded
        class="px-6"
        @mouseover="isHover = true"
      >
        フォロー中
      </v-btn>
    </template>
    <template v-else>
      <v-btn
        color="error"
        outlined
        rounded
        @mouseleave="isHover = false"
        @click.prevent.stop="unFollow"
      >
        フォロー解除
      </v-btn>
    </template>
  </span>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
  props: {
    user: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      isFollow: false,
      isHover: false,
      params: { id: 0 }
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data'
    })
  },
  mounted () {
    setTimeout(() => {
      this.fetchContents()
    }, 0)
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage',
      followerCountPageUserIdIncrement: 'relationship/followerCountPageUserIdIncrement',
      followerCountPageUserIdDecrement: 'relationship/followerCountPageUserIdDecrement'
    }),
    async fetchContents () {
      const url = `/api/v1/users/${this.user.id}/is_following`
      await this.$axios.get(url, {
        params: {
          id: this.currentUser.id
        }
      })
        .then((res) => {
          this.isFollow = res.data
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    async follow () {
      const url = `/api/v1/users/${this.user.id}/relationships`
      this.params.id = this.currentUser.id
      await this.$axios.post(url, this.params)
        .then(() => {
          this.isFollow = true
          if (this.$route.name === 'users-id') {
            this.followerCountPageUserIdIncrement()
          }
          this.flashMessage({ message: 'フォローしました', type: 'primary', status: true })
        })
        .catch((err) => {
          this.flashMessage({ message: err, type: 'error', status: true })
        })
    },
    async unFollow () {
      const url = `/api/v1/users/${this.user.id}/relationships/${this.currentUser.id}`
      await this.$axios.delete(url)
        .then((res) => {
          this.isFollow = false
          if (this.$route.name === 'users-id') {
            this.followerCountPageUserIdDecrement()
          }
          this.flashMessage({ message: res.data.success_message, type: 'success', status: true })
        })
        .catch((err) => {
          this.flashMessage({ message: err, type: 'error', status: true })
        })
    }
  }
}
</script>
