<template>
  <v-col class="pl-0">
    <div class="balloon_l">
      <div class="face_icon">
        <v-avatar
          size="60"
        >
          <img
            :src="userAvatar"
            contain
          >
        </v-avatar>
      </div>
      <p class="says">
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
  }
}
</script>
