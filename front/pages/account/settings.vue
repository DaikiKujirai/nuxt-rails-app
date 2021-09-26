<template>
  <layoutMain #layout-main> <!--eslint-disable-line-->
    <v-row>
      <v-col>
        <v-card>
          <v-row>
            <v-col class="pb-0">
              <v-img
                :src="coverImage"
                height="250"
              />
            </v-col>
          </v-row>
          <v-row>
            <v-col class="d-flex pt-0">
              <v-img
                :src="avatar"
                max-height="120"
                max-width="120"
                contain
                style="border-radius: 50%;"
                class="ml-10 my-5"
              />
              <v-card-title>
                {{ name }}
              </v-card-title>
            </v-col>
          </v-row>
          <v-tabs
            v-model="tab"
            centered
            fixed-tabs
          >
            <v-tab>
              メールアドレス変更
            </v-tab>
            <v-tab>
              パスワード変更・退会
            </v-tab>
          </v-tabs>
          <v-tabs-items v-model="tab">
            <tab-edit-email
              :is-guest="isGuest"
              class="mt-10"
            />
            <tab-edit-password
              :is-guest="isGuest"
              class="mt-10"
            />
          </v-tabs-items>
        </v-card>
      </v-col>
    </v-row>
  </layoutMain>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import LayoutMain from '../../components/layout/loggedIn/layoutMain.vue'
import TabEditEmail from '../../components/user/tabs/edit/tabEditEmail.vue'
import TabEditPassword from '../../components/user/tabs/edit/tabEditPassword.vue'

export default {
  components: {
    LayoutMain,
    TabEditEmail,
    TabEditPassword
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
      tab: null,
      name: '',
      coverImage: '',
      avatar: '',
      breadcrumbs: 'アカウント設定',
      guest: process.env.GUEST_EMAIL,
      isGuest: false
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data'
    })
  },
  mounted () {
    setTimeout(() => {
      this.name = this.currentUser.name
      this.email = this.currentUser.email
      this.password = this.currentUser.password
      this.coverImage = this.currentUser.cover_image.url
      this.avatar = this.currentUser.avatar.url
      this.setBreadcrumbs(this.breadcrumbs)
      this.isGuest = this.guest === this.currentUser.email
      this.subscribe()
    }, 0)
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage',
      updateCurrentUser: 'auth/updateCurrentUser',
      setBreadcrumbs: 'breadcrumbs/setBreadcrumbs',
      setIsActive: 'notification/setIsActive'
    }),
    async subscribe () {
      await this.$cable.subscribe({
        channel: 'RoomChannel',
        room: this.currentUser.uid,
        uid: `${this.currentUser.uid}`
      })
    }
  }
}
</script>
