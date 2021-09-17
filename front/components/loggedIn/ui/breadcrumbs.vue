<template>
  <h4
    class="ma-5"
  >
    <template v-if="$route.params.id">
      {{ user.name }}
    </template>
    {{ breadcrumbs }}
  </h4>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  computed: {
    ...mapGetters({
      user: 'user/user',
      breadcrumbs: 'breadcrumbs/breadcrumbs'
    })
  }
}
</script>
