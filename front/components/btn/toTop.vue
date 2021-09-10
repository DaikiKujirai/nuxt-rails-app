<template>
  <v-btn
    icon
    elevation="20"
    height="80px"
    width="80px"
    fixed
    right
    bottom
    color="info"
    class="mb-10"
    @click="toTop"
  >
    <v-icon
      size="50"
      color="dark"
      v-text="'mdi-chevron-up'"
    />
  </v-btn>
</template>

<script>
export default {
  methods: {
    toTop () {
      window.scrollTo({
        top: 0,
        behavior: 'smooth'
      })
    }
  }
}
</script>
