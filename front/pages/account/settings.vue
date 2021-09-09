<template>
  <layoutMain #layout-main> <!--eslint-disable-line-->
    <v-row>
      <v-col>
        <v-card>
          アカウント設定
        </v-card>
      </v-col>
    </v-row>
  </layoutMain>
</template>

<script>
import LayoutMain from '../../components/layout/loggedIn/layoutMain.vue'

export default {
  components: {
    LayoutMain
  }
}
</script>
