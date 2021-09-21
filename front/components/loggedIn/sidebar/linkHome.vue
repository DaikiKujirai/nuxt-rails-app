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

export default {
  methods: {
    goHome () {
      this.$router.push(`/homes/${this.$store.state.auth.data.id}`)
    }
  }
}
</script>
