<template>
  <v-col class="pr-5">
    <div class="balloon_r">
      <p :class="saysCurrent">
        {{ msg.message }}
        <!-- {{ msg.createdAt.toDate().format('YYYY-MM-DD HH:mm') }} -->
      </p>
    </div>
  </v-col>
</template>

<script>
export default {
  props: {
    msg: {
      type: Object,
      required: true
    }
  },
  computed: {
    saysCurrent () {
      return this.$vuetify.theme.dark ? ('says-current-dark') : ('says-current')
    }
  }
}
</script>
