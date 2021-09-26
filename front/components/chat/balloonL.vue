<template>
  <v-col class="pl-0">
    <div class="balloon_l">
      <div class="face_icon">
        <img
          :src="userAvatar"
        >
      </div>
      <p
        :class="says"
      >
        {{ msg.message }}
      </p>
    </div>
  </v-col>
</template>

<script>
export default {
  props: {
    userAvatar: {
      type: String,
      required: true
    },
    msg: {
      type: Object,
      required: true
    }
  },
  computed: {
    says () {
      return this.$vuetify.theme.dark ? ('says-dark') : ('says')
    }
  }
}
</script>
