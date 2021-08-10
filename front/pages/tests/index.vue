<template>
  <div>
    <v-card class="text-center">
      test
      <v-card-title class="justify-center">
        state ："  {{ number }}  "
      </v-card-title>
      <v-card-title class="justify-center">
        getters ："  {{ number }}  "
      </v-card-title>
      <v-btn
        rounded
        color="primary"
        @click="toActions"
      >
        ボタン
      </v-btn>
      <v-card-title>
        mutation ："  {{}}  "
      </v-card-title>
    </v-card>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
  data () {
    return {
    }
  },
  computed: {
    ...mapGetters({
      number: 'test/testGetters'
    })
  },
  methods: {
    ...mapActions({
      testAction: 'test/testAction'
    }),
    toActions () {
      this.testAction(5)
    }
  }
}
</script>

<style scoped>
  div {
    margin-top: 20px;
    padding: 50px;
  }
</style>
