<template>
  <layout-main #layout-main> <!--eslint-disable-line-->
    <v-row>
      <v-col>
        <v-card>
          <v-row>
            <v-col
              class="d-flex"
            >
              <v-img
                :src="src"
                max-height="70"
                max-width="70"
                contain
                style="border-radius: 50%;"
                class="ml-3"
              />
              <v-card-text>
                {{ user.name }}
              </v-card-text>
              <v-card-text
                class="text-right"
              >
                <v-icon
                  size="16"
                  v-text="'mdi-update'"
                />
              </v-card-text>
            </v-col>
          </v-row>
          <v-row>
            <v-col>
              <v-card-title
                class="card-content"
              >
                {{ user }}
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
      </v-col>
    </v-row>
  </layout-main>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  data: () => {
    return {
      src: 'https://picsum.photos/500/500'
    }
  },
  computed: {
    ...mapGetters({
      user: 'user/user',
      isAuthenticated: 'auth/isAuthenticated',
      btnColor: 'btn/color'
    })
  },
  methods: {
    fetchContents () {
      const url = `/api/v1/users/${this.$route.params.id}`
      this.$axios.get(url)
        .then((res) => {
          // eslint-disable-next-line
          console.log('投稿詳細')
          this.user = res.data
        })
        .catch((err) => {
          console.error(err) // eslint-disable-line
        })
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
