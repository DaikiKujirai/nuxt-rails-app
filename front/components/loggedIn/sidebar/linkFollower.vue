<template>
  <v-list
    nav
    rounded
  >
    <v-list-item
      two-line
      class="justify-center"
      @click="toFollow('follower')"
    >
      <v-icon
        size="28"
        v-text="'mdi-account-details-outline'"
      />
      <div class="ml-5">
        フォロワー
      </div>
    </v-list-item>
  </v-list>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  computed: {
    ...mapGetters({
      currentUser: 'auth/data'
    })
  },
  methods: {
    toFollow (tab) {
      this.$router.push(`/relationships/${this.currentUser.id}?tab=${tab}`)
    }
  }
}
</script>
