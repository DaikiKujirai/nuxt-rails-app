<template>
  <v-col class="pr-5">
    <div class="balloon_r">
      <p :class="saysCurrent">
        {{ chat.message }}
        {{ time }}
      </p>
    </div>
  </v-col>
</template>

<script>
import moment from 'moment'

export default {
  props: {
    chat: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      time: moment(this.chat.created_at)
    }
  },
  computed: {
    saysCurrent () {
      return this.$vuetify.theme.dark ? ('says-current-dark') : ('says-current')
    }
  }
}
</script>
