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
    <template v-if="route === 'search' || route === 'posts' || route === 'homes-id'">
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
  data () {
    return {
      route: this.$route.name
    }
  },
  computed: {
    ...mapGetters({
      user: 'user/user',
      breadcrumbs: 'breadcrumbs/breadcrumbs',
      searchWord: 'search/searchWord'
    })
  }
}
</script>
