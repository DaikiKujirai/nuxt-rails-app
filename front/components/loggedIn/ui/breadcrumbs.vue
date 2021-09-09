<template>
  <v-breadcrumbs
    :items="items"
  >
    <template #item="{ item }">
      <v-breadcrumbs-item
        exact
        class="text-truncate"
      >
        <template v-if="$route.name === 'users-id'">
          {{ user.name }}
        </template>
        <template v-else>
          {{ item.text }}
        </template>
      </v-breadcrumbs-item>
    </template>
    <template #divider>
      <v-icon
        v-text="'mdi-chevron-right'"
      />
    </template>
  </v-breadcrumbs>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  computed: {
    items () {
      return [
        { text: this.$my.pageTitle(this.$route.name) }
      ]
    },
    ...mapGetters({
      user: 'user/user'
    })
  }
}
</script>
