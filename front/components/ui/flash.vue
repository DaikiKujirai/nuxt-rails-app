<template>
  <v-snackbar
    v-model="status"
    style="margin: 0"
    transition="scale-transition"
    center
    top
    :color="type"
  >
    <div class="text-center font-weight-bold white--text" style="white-space: pre-wrap;" v-text="message" />
  </v-snackbar>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  computed: {
    ...mapGetters({
      message: 'flash/message',
      type: 'flash/type',
      status: 'flash/status'
    })
  }
}
</script>
