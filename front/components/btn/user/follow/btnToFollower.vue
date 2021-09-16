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
  props: {
    user: {
      type: Object,
      required: true
    }
  },
  computed: {
    ...mapGetters({
      followerCountPageUserId: 'relationship/followerCountPageUserId'
    })
  },
  created () {
    this.setFollowerCountPageUserId(this.user.followers.length)
  },
  methods: {
    ...mapActions({
      setFollowerCountPageUserId: 'relationship/setFollowerCountPageUserId'
    }),
    toShow (page, id, tab) {
      this.$router.push(`/${page}/${id}?tab=${tab}`)
    }
  }
}
</script>
