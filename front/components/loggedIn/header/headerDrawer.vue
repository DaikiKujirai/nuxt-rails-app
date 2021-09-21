<template>
  <div>
    <v-app-bar-nav-icon
      @click.stop="drawer = !drawer"
    />
  </div>
</template>

<script>
import { mapActions } from 'vuex'

export default {
  data () {
    return {
      drawer: false
    }
  },
  watch: {
    drawer (bool) {
      bool ? (this.setDrawer(true)) : (this.setDrawer(false))
    }
  },
  methods: {
    ...mapActions({
      setDrawer: 'drawer/setDrawer'
    })
  }
}
</script>
