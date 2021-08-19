<template>
  <v-container
    fluid
  >
    <v-row>
      <sidebar />
      <v-col
        cols="6"
        offset="3"
        class="mt-2"
      >
        <slot name="layout-main" />
      </v-col>
      <v-col cols="3">
        <v-card>
          サイドバー
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import sidebar from '../../loggedIn/sidebar/sidebar.vue'

export default {
  components: {
    sidebar
  }
}
</script>
