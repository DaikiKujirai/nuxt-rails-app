<template>
  <div>
    <v-card class="text-center">
      test
      <v-card-title class="justify-center">
        state ："  {{ test }}  "
      </v-card-title>
      <v-card-title class="justify-center">
        getters ："  {{ gts }}  "
      </v-card-title>
      <v-btn
        rounded
        color="primary"
      >
        ボタン
      </v-btn>
    </v-card>
  </div>
</template>

<script>
import { mapState, mapGetters } from 'vuex'

export default {
  data () {
    return {
      // test: 0
    }
  },
  computed: {
    ...mapState(
      'test',
      'gts'
    ),
    ...mapGetters([
      'gts'
    ])
  },
  methods: {
    // ...mapState({
    //   test
    // })
  }
}
</script>

<style scoped>
  div {
    margin-top: 20px;
    padding: 50px;
  }
</style>
