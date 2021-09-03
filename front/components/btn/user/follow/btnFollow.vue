<template>
  <v-col
    class="text-right mr-2"
  >
    <template v-if="!isFollow">
      <v-btn
        color="info"
        outlined
        rounded
        @click="follow"
      >
        フォローする
      </v-btn>
    </template>
    <template v-else>
      <v-btn
        color="primary"
        outlined
        rounded
        @click="follow"
      >
        フォロー中
      </v-btn>
    </template>
  </v-col>
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
      followingIds: [],
      followerIds: [],
      isFollow: false,
      params: { id: 0 }
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data'
    })
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage'
    }),
    async fetchContents () {
      const url = `/api/v1/users/${this.$route.params.id}/is_following`
      this.params.id = this.currentUser.id
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
      const url = `/api/v1/users/${this.$route.params.id}/relationships`
      this.params.id = this.currentUser.id
      await this.$axios.post(url, this.params)
        .then((res) => {
          this.followingIds.push(res.data)
          this.flashMessage({ message: 'フォローしました', type: 'primary', status: true })
        })
        .catch((err) => {
          this.flashMessage({ message: err, type: 'error', status: true })
        })
    }
  }
}
</script>
