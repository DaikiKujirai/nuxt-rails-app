<template>
  <layout-main #layout-main> <!--eslint-disable-line-->
    <v-row>
      <v-col>
        <v-card>
          <v-row>
            <v-col>
              <v-img
                :src="user.cover_image.url"
                height="250"
              />
            </v-col>
          </v-row>
          <v-row class="mt-0">
            <v-col
              class="d-flex"
            >
              <v-img
                :src="user.avatar.url"
                height="70"
                max-width="70"
                style="border-radius: 50%;"
                class="ml-3 mt-0"
              />
              <v-card-title>
                {{ user.name }}
              </v-card-title>
              <v-col
                class="text-right mr-2"
              >
                <template v-if="user.id === currentUser.id">
                  <btn-edit-profile />
                </template>
                <template v-else>
                  <btn-to-chat
                    :user="user"
                  />
                  <btn-follow
                    ref="btnFollow"
                    :user="user"
                  />
                </template>
              </v-col>
            </v-col>
          </v-row>
          <v-row>
            <v-col>
              <v-card-title
                class="card-content"
              >
                {{ user.introduction }}
              </v-card-title>
            </v-col>
          </v-row>
          <template v-if="isAuthenticated">
            <v-row>
              <v-col>
                <v-card-actions>
                  <btn-to-follow
                    :user="user"
                    class="mr-2"
                  />
                  <btn-to-follower
                    :user="user"
                  />
                </v-card-actions>
              </v-col>
            </v-row>
          </template>
        </v-card>
        <page-id-user-tab
          class="mt-1"
          :user="user"
        />
      </v-col>
    </v-row>
  </layout-main>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import BtnToChat from '../../components/btn/chat/btnToChat.vue'
import BtnEditProfile from '../../components/btn/user/editProfile/btnEditProfile.vue'
import BtnFollow from '../../components/btn/user/follow/btnFollow.vue'
import BtnToFollow from '../../components/btn/user/follow/btnToFollow.vue'
import BtnToFollower from '../../components/btn/user/follow/btnToFollower.vue'
import pageIdUserTab from '../../components/user/pageIdUserTab.vue'

export default {
  components: {
    pageIdUserTab,
    BtnEditProfile,
    BtnFollow,
    BtnToFollow,
    BtnToFollower,
    BtnToChat
  },
  async asyncData ({ $axios, params }) {
    const res = await $axios.get(`/api/v1/users/${params.id}`)
    return { user: res.data }
  },
  channels: {
    RoomChannel: {
      connected () {
        // eslint-disable-next-line no-console
        console.log('connected')
      },
      received () {
        this.setIsActive(true)
      },
      disconnected () {
        // eslint-disable-next-line no-console
        console.log('disconnected')
      }
    }
  },
  data () {
    return {
      breadcrumbs: ''
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data',
      isAuthenticated: 'auth/isAuthenticated'
    })
  },
  created () {
    this.setUser(this.user)
    this.setBreadcrumbs(this.breadcrumbs)
  },
  mounted () {
    setTimeout(() => {
      if (!this.isAuthenticated) {
        this.$router.push('/auth/login')
      }
      this.subscribe()
    })
  },
  methods: {
    ...mapActions({
      setUser: 'user/setUser',
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
