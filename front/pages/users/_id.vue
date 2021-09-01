<template>
  <layout-main #layout-main> <!--eslint-disable-line-->
    <v-row>
      <v-col>
        <v-card>
          <v-row>
            <v-col>
              <v-img
                :src="src"
                height="250"
              />
            </v-col>
          </v-row>
          <v-row class="mt-0">
            <v-col
              class="d-flex"
            >
              <v-img
                :src="src"
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
                <v-btn
                  color="success"
                  outlined
                  rounded
                >
                  プロフィール編集
                </v-btn>
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
                  <v-btn
                    :color="btnColor"
                    text
                    rounded
                    @click="toFollow"
                  >
                    フォロー
                  </v-btn>
                  <v-btn
                    :color="btnColor"
                    text
                    rounded
                    @click="toFollower"
                  >
                    フォロワー
                  </v-btn>
                </v-card-actions>
              </v-col>
            </v-row>
          </template>
        </v-card>
        <page-id-user-tab
          class="mt-1"
          :user="user"
          :posts="posts"
          :comments="comments"
          :likes="likes"
          @fetchUser="fetchUser"
        />
      </v-col>
    </v-row>
  </layout-main>
</template>

<script>
import { mapGetters } from 'vuex'
import pageIdUserTab from '../../components/user/pageIdUserTab.vue'

export default {
  components: {
    pageIdUserTab
  },
  data: () => {
    return {
      user: {},
      posts: [],
      comments: [],
      likes: [],
      src: 'https://picsum.photos/500/500'
    }
  },
  computed: {
    ...mapGetters({
      isAuthenticated: 'auth/isAuthenticated',
      btnColor: 'btn/color'
    })
  },
  created () {
    this.fetchUser()
  },
  methods: {
    fetchUser () {
      const url = `/api/v1/users/${this.$route.params.id}`
      this.$axios.get(url)
        .then((res) => {
          this.user = res.data
          this.likes = res.data.likes
          this.dividePostsAndComments(res.data.posts)
        })
        .catch((err) => {
          console.error(err) // eslint-disable-line
        })
    },
    dividePostsAndComments (posts) {
      for (let i = 0; i < posts.length; i++) {
        if (posts[i].post_id === 0) {
          this.posts.push(posts[i])
        } else {
          this.comments.push(posts[i])
        }
      }
    },
    toFollow () {
      // eslint-disable-next-line no-console
      console.log('toFolow')
    },
    toFollower () {
      // eslint-disable-next-line no-console
      console.log('toFolower')
    }
  }
}
</script>
