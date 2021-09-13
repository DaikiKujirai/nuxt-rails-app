<template>
  <v-container
    fluid
  >
    <v-row>
      <sidebar />
      <v-col
        cols="4"
        offset="3"
      >
        <v-row>
          <v-col
            class="breadcrumbs"
            cols="4"
          >
            <v-card class="d-flex align-center">
              <v-btn
                icon
                class="ml-3"
                @click="pageBack"
              >
                <v-icon
                  size="40"
                  v-text="'mdi-arrow-left'"
                />
              </v-btn>
              <breadcrumbs />
            </v-card>
          </v-col>
        </v-row>
        <v-main>
          <div class="mt-5">
            <chat-lists />
          </div>
        </v-main>
      </v-col>
      <v-col cols="5">
        選択してください
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex'
import ChatLists from '../../components/chat/chatLists.vue'
import Sidebar from '../../components/loggedIn/sidebar/sidebar.vue'
import Breadcrumbs from '../../components/loggedIn/ui/breadcrumbs.vue'

export default {
  components: {
    Sidebar,
    Breadcrumbs,
    ChatLists
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data'
    })
  },
  methods: {
    pageBack () {
      this.$router.go(-1)
    }
  }
}
</script>

<style scoped>
  .breadcrumbs {
    position: fixed;
    z-index: 1;
    padding-top: 0;
  }
</style>
