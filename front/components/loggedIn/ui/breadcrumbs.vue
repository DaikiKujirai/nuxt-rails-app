<template>
  <div
    class="ma-3 d-flex justify-space-between"
    style="width: 100%;"
  >
    <h4 class="ma-auto">
      <template v-if="$route.params.id">
        {{ user.name }}
      </template>
      <template v-else-if="$route.name === 'search'">
        "{{ searchWord }}"
      </template>
      {{ breadcrumbs }}
    </h4>
    <template v-if="isDisplay && isAuthenticated">
      <search-form />
    </template>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import searchForm from './searchForm.vue'

export default {
  components: {
    searchForm
  },
  computed: {
    ...mapGetters({
      user: 'user/user',
      breadcrumbs: 'breadcrumbs/breadcrumbs',
      searchWord: 'search/searchWord',
      isAuthenticated: 'auth/isAuthenticated'
    }),
    isDisplay () {
      const route = this.$route.name
      switch (route) {
        case 'search':
          return true
        case 'posts':
          return true
        case 'homes-id':
          return true
        default:
          return false
      }
    }
  }
}
</script>
