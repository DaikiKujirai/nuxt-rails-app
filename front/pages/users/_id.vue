<template>
  <layout-main #layout-main> <!--eslint-disable-line-->
    <v-row>
      <v-col>
        <v-card>
          <v-row>
            <v-col>
              <v-img
                :src="coverImage"
                height="250"
              />
            </v-col>
          </v-row>
          <v-row class="mt-0">
            <v-col
              class="d-flex"
            >
              <v-img
                :src="avatar"
                max-height="70"
                max-width="70"
                contain
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
                    class="mr-2"
                  />
                  <btn-to-follower />
                </v-card-actions>
              </v-col>
            </v-row>
          </template>
        </v-card>
        <page-id-user-tab
          ref="pageIdUserTab"
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
  data () {
    return {
      user: {},
      avatar: '',
      coverImage: ''
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data',
      isAuthenticated: 'auth/isAuthenticated'
    })
  },
  created () {
    this.fetchContents()
  },
  methods: {
    ...mapActions({
      setUser: 'user/setUser'
    }),
    async fetchContents () {
      const url = `/api/v1/users/${this.$route.params.id}`
      await this.$axios.get(url)
        .then((res) => {
          this.user = res.data
          this.avatar = res.data.avatar.url
          this.coverImage = res.data.cover_image.url
          this.setUser(res.data)
          setTimeout(() => {
            this.fetchShowUser()
          }, 400)
        })
        .catch((err) => {
          console.error(err) // eslint-disable-line
        })
    },
    fetchShowUser () {
      this.$refs.pageIdUserTab.fetchContents()
    }
  }
}
</script>
