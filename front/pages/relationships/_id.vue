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
          <v-app>
            <tab-followers />
            <tab-following />
          </v-app>
        </v-tabs-items>
      </v-col>
    </v-row>
  </layout-main>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import layoutMain from '../../components/layout/loggedIn/layoutMain.vue'
import TabFollowers from '../../components/user/tabs/tabFollowers.vue'
import TabFollowing from '../../components/user/tabs/tabFollowing.vue'

export default {
  components: {
    layoutMain,
    TabFollowers,
    TabFollowing
  },
  channels: {
    RoomChannel: {
      connected () {
      },
      received (data) {
        this.setIsActive(true)
        this.pushNotification(data)
      },
      disconnected () {
        // eslint-disable-next-line no-console
        console.log('disconnected')
      }
    }
  },
  data () {
    return {
      tab: 0,
      breadcrumbs: ''
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data'
    })
  },
  created () {
    this.fetchContents()
    this.setBreadcrumbs(this.breadcrumbs)
  },
  mounted () {
    setTimeout(() => {
      this.subscribe()
    }, 0)
  },
  methods: {
    ...mapActions({
      setBreadcrumbs: 'breadcrumbs/setBreadcrumbs',
      setIsActive: 'notification/setIsActive',
      pushNotification: 'notification/pushNotification'
    }),
    async subscribe () {
      await this.$cable.subscribe({
        channel: 'RoomChannel',
        room: this.currentUser.uid,
        uid: `${this.currentUser.uid}`
      })
    },
    fetchContents () {
      if (this.$route.query.tab === 'following') {
        this.tab = 1
      }
    }
  }
}
</script>
