<template>
  <v-app>
    <logged-in-app-bar />
    <v-main>
      <v-breadcrumbs
        divider=">"
        large
      />
      <nuxt />
    </v-main>
  </v-app>
</template>

<script>
export default {
}
</script>
