<template>
  <v-container
    fluid
  >
    <v-row>
      <sidebar
        class="d-none d-md-flex"
      />
      <v-col
        offset-sm="0"
        offset-md="3"
        xs="12"
        sm="12"
        md="6"
      >
        <v-row>
          <v-col
            class="breadcrumbs"
            xs="12"
            sm="12"
            md="6"
          >
            <v-card class="d-flex align-center">
              <template v-if="$route.name !== 'index'">
                <v-btn
                  icon
                  class="ml-3"
                  style="z-index: 1;"
                  @click="pageBack"
                >
                  <v-icon
                    size="40"
                    v-text="'mdi-arrow-left'"
                  />
                </v-btn>
              </template>
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
      <v-col
        sm="0"
        md="3"
      >
        <v-card>
          サイドバー
        </v-card>
      </v-col>
    </v-row>
    <v-row>
      <v-col>
        <to-top />
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import ToTop from '../../btn/toTop.vue'
import Sidebar from '../../loggedIn/sidebar/sidebar.vue'
import Breadcrumbs from '../../loggedIn/ui/breadcrumbs.vue'

export default {
  components: {
    Sidebar,
    Breadcrumbs,
    ToTop
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
