<template>
  <v-app-bar
    app
    dark
    hide-on-scroll
    clipped-left
  >
    <v-app-bar-nav-icon />
    <v-toolbar-title>
      {{ appName }}
    </v-toolbar-title>
    <v-spacer />
    <v-btn
      rounded
      color="info"
    >
      +
    </v-btn>
  </v-app-bar>
</template>

<script>
export default {
  data ({ $config: { appName } }) {
    return {
      appName
    }
  }
}
</script>
