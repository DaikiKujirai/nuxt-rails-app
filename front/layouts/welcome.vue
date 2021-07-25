<template>
  <v-app>
    <wel-app-bar
      :menus="menus"
    />
    <v-img
      dark
      src="https://picsum.photos/id/20/1920/1080?blur=5"
      gradient="to top right, rgba(19,84,122,.6), rgba(128,208,199,.9)"
      :height="imgHeight"
    >
      <v-row
        align="center"
        justify="center"
        :style="{ height: `${imgHeight}px` }"
      >
        <v-col
          cols="12"
          class="text-center"
        >
          <h1 class="display-1 mb-4">
            Bookers
          </h1>
          <h4
            class="subheading"
            :style="{ letterSpacing: '5px' }"
          >
            試作品
          </h4>
        </v-col>
      </v-row>
    </v-img>
    <bef-login-footer />
  </v-app>
</template>

<script>
import WelAppBar from '../components/welcome/welAppBar.vue'
import BefLoginFooter from '~/components/beforeLogin/befLoginFooter.vue'

export default {
  components: {
    WelAppBar,
    BefLoginFooter
  },
  data () {
    return {
      imgHeight: 500
    }
  }
}
</script>
