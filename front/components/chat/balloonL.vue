<template>
  <v-col class="pl-0">
    <div class="balloon_l align-end">
      <div class="face_icon">
        <img
          :src="userAvatar"
        >
      </div>
      <p
        :class="says"
      >
        {{ chat.message }}
      </p>
      <p class="caption ml-2 mb-0">
        {{ time }}
      </p>
    </div>
  </v-col>
</template>

<script>
import moment from 'moment'

export default {
  props: {
    userAvatar: {
      type: String,
      required: true
    },
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
    says () {
      return this.$vuetify.theme.dark ? ('says-dark') : ('says')
    }
  }
}
</script>
