<template>
  <v-fab-transition>
    <v-btn
      v-show="scrollY"
      elevation="10"
      height="80px"
      width="80px"
      fixed
      right
      bottom
      fab
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
  </v-fab-transition>
</template>

<script>
export default {
  data () {
    return {
      scrollY: 0
    }
  },
  mounted () {
    window.addEventListener('scroll', this.onScroll)
  },
  beforeDestroy () {
    window.removeEventListener('scroll', this.onScroll)
  },
  methods: {
    toTop () {
      window.scrollTo({
        top: 0,
        behavior: 'smooth'
      })
    },
    onScroll () {
      this.scrollY = window.scrollY
    }
  }
}
</script>
