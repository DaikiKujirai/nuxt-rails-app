<template>
  <span>
    <v-btn
      color="success"
      outlined
      rounded
      @click="toEdit"
    >
      プロフィール編集
    </v-btn>
  </span>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  computed: {
    ...mapGetters({
      currentUser: 'auth/data'
    })
  },
  methods: {
    toEdit () {
      this.$router.push('/users/edit')
    }
  }
}
</script>
