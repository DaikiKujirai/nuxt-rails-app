<template>
  <div>
    <v-app-bar-nav-icon
      @click.stop="toggleDrawer"
    />
  </div>
</template>

<script>
export default {
  methods: {
    toggleDrawer () {
      this.$emit('toggleDrawer')
    }
  }
}
</script>
