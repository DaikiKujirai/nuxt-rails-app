<template>
  <v-list
    nav
    rounded
  >
    <v-list-item
      two-line
      class="justify-center"
      @click="toFollow('following')"
    >
      <v-icon
        size="28"
        v-text="'mdi-account-details'"
      />
      <div class="ml-5">
        フォロー
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
