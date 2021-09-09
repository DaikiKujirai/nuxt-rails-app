<template>
  <layout-main #layout-main> <!--eslint-disable-line-->
    <v-row class="text-center">
      <v-col>
        <v-card>
          <v-tabs
            v-model="tab"
            centered
            fixed-tabs
          >
            <v-tab>
              フォロワー
            </v-tab>
            <v-tab>
              フォロー中
            </v-tab>
          </v-tabs>
        </v-card>
        <v-tabs-items
          v-model="tab"
        >
          <tab-followers />
          <tab-following />
        </v-tabs-items>
      </v-col>
    </v-row>
  </layout-main>
</template>

<script>
import layoutMain from '../../components/layout/loggedIn/layoutMain.vue'
import TabFollowers from '../../components/user/tabs/tabFollowers.vue'
import TabFollowing from '../../components/user/tabs/tabFollowing.vue'

export default {
  components: {
    layoutMain,
    TabFollowers,
    TabFollowing
  },
  data () {
    return {
      tab: Number(this.$route.query.tab)
    }
  }
}
</script>
