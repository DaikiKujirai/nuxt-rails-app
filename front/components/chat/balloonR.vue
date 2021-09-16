<template>
  <v-col class="pr-5">
    <div class="balloon_r">
      <p class="says-current">
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
  }
}
</script>
