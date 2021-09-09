<template>
  <v-col
    class="text-right mr-2"
  >
    <v-btn
      color="success"
      outlined
      rounded
      @click="toEdit"
    >
      プロフィール編集
    </v-btn>
  </v-col>
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
