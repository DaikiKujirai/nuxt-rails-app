<template>
  <v-container
    fluid
  >
    <v-row>
      <sidebar
        @fetchPosts="fetchPosts"
      />
      <v-col
        cols="6"
        offset="3"
      >
        <v-row>
          <v-col
            class="breadcrumbs"
            cols="6"
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
            <slot
              name="layout-main"
            />
          </div>
        </v-main>
      </v-col>
      <v-col cols="3">
        <v-card>
          サイドバー
        </v-card>
      </v-col>
    </v-row>
    <v-row>
      <v-col>
        <v-btn
          icon
          elevation="20"
          height="80px"
          width="80px"
          fixed
          right
          bottom
          color="info"
          class="mb-10"
          @click="toTop"
        >
          <v-icon
            size="50"
            color="dark"
            v-text="'mdi-chevron-up'"
          />
        </v-btn>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import Sidebar from '../../loggedIn/sidebar/sidebar.vue'
import Breadcrumbs from '../../loggedIn/ui/breadcrumbs.vue'

export default {
  components: {
    Sidebar,
    Breadcrumbs
  },
  methods: {
    pageBack () {
      this.$router.go(-1)
    },
    toTop () {
      window.scrollTo({
        top: 0,
        behavior: 'smooth'
      })
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
