<template>
  <v-breadcrumbs
    :items="items"
  >
    <template #item="{ item }">
      <v-breadcrumbs-item
        exact
        class="text-truncate"
      >
        <template v-if="$route.name === 'posts-id'">
          {{ user.name }} の {{ title }}
        </template>
        <template v-if="$route.name === 'posts' || 'chats'">
          {{ item.text }}
        </template>
        <template v-else>
          {{ title }}
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
    }),
    title ({ $route }) {
      if ($route.name === 'posts-id') {
        return '投稿'
      } else if ($route.name === 'relationships-id') {
        return 'フォロー'
      } else if ($route.name === 'chats-id') {
        return 'チャット'
      } else {
        return '通知'
      }
    }
  }
}
</script>
