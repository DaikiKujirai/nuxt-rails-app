<template>
  <v-card>
    コメント
  </v-card>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  computed: {
    ...mapGetters({
      comment: 'comment/comment'
    })
  }
}
</script>
