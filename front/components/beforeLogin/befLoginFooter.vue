<template>
  <div :style="{ marginTop: `${height}px` }">
    <v-footer
      absolute
      dark
      color="black"
      :height="height"
    >
      <v-col
        cols="12"
        class="py-0"
      >
        <div class="text-center text-body-2">
          &copy;{{ copyRightYear }}
          <strong>{{ appName }}</strong>
        </div>
      </v-col>
    </v-footer>
  </div>
</template>

<script>
export default {
  data ({ $config: { appName } }) {
    return {
      appName,
      height: 32
    }
  },
  computed: {
    copyRightYear () {
      const beginningYear = 2020
      const thisYear = new Date().getFullYear()
      return (beginningYear < thisYear) ? `${beginningYear} - ${thisYear}` : beginningYear
    }
  }
}
</script>
