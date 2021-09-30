<template>
  <v-list
    nav
    rounded
  >
    <v-list-item
      two-line
      class="justify-center"
      @click="goHome"
    >
      <v-icon
        size="28"
        v-text="'mdi-home'"
      />
      <div class="ml-5">
        ホーム
      </div>
    </v-list-item>
  </v-list>
</template>

<script>
import { mapActions } from 'vuex'

export default {
  methods: {
    ...mapActions({
      setReacquireData: 'post/setReacquireData'
    }),
    goHome () {
      this.$route.name !== 'homes-id'
        ? (this.$router.push(`/homes/${this.$store.state.auth.data.id}`))
        : (this.setReacquireData(true))
    }
  }
}
</script>
