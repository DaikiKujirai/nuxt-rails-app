<template>
  <v-col class="pr-5 d-flex justify-end align-end">
    <div class="caption mb-0 mr-2">
      <p
        v-if="chat.checked"
        class="mb-0 text-right"
      >
        既読
      </p>
      {{ time }}
    </div>
    <div class="balloon_r">
      <p :class="saysCurrent">
        {{ chat.message }}
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
      time: moment(this.chat.created_at).format('HH:mm')
    }
  },
  computed: {
    saysCurrent () {
      return this.$vuetify.theme.dark ? ('says-current-dark') : ('says-current')
    }
  }
}
</script>
