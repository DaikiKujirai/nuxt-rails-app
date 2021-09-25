<template>
  <div>
    <v-btn
      icon
      class="mx-2"
      @click="toggleTheme"
    >
      <v-icon
        v-text="icon"
      />
    </v-btn>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
  computed: {
    ...mapGetters({
      theme: 'theme/theme'
    }),
    icon () {
      return this.theme ? ('mdi-weather-night') : ('mdi-white-balance-sunny')
    }
  },
  created () {
    this.$vuetify.theme.dark = this.theme
  },
  methods: {
    ...mapActions({
      setTheme: 'theme/setTheme'
    }),
    toggleTheme () {
      this.theme ? (this.setTheme(false)) : (this.setTheme(true))
      this.$vuetify.theme.dark = this.theme
    }
  }
}
</script>
