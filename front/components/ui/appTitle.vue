<template>
  <v-toolbar-title>
    {{ appName }}
  </v-toolbar-title>
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
