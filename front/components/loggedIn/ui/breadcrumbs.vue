<template>
  <v-breadcrumbs
    :items="items"
  >
    <template #item="{ item }">
      <v-breadcrumbs-item
        exact
        class="text-truncate"
      >
        {{ item.text }}
      </v-breadcrumbs-item>
    </template>
    <template #divider>
      <v-icon>
        mdi-chevron-right
      </v-icon>
    </template>
  </v-breadcrumbs>
</template>

<script>
export default {
  computed: {
    items () {
      return [
        { text: this.$my.pageTitle(this.$route.name) }
      ]
    }
  }
}
</script>
