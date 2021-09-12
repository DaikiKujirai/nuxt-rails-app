<template>
  <div>
    {{ followerCountPageUserId }}
    <v-btn
      text
      rounded
      class="px-0"
      @click="toShow('relationships', $route.params.id, 0)"
    >
      フォロワー
    </v-btn>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
  computed: {
    ...mapGetters({
      followerCountPageUserId: 'relationship/followerCountPageUserId'
    })
  },
  mounted () {
    this.fetchContents()
  },
  methods: {
    ...mapActions({
      setFollowerCountPageUserId: 'relationship/setFollowerCountPageUserId'
    }),
    async fetchContents () {
      const url = `/api/v1/find_followers/${this.$route.params.id}`
      await this.$axios.get(url)
        .then((res) => {
          this.setFollowerCountPageUserId(res.data.kaminari.pagination.count)
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    toShow (page, id, tab) {
      this.$router.push(`/${page}/${id}?tab=${tab}`)
    }
  }
}
</script>
