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
        {{ message }}
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
    message: {
      type: String,
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
