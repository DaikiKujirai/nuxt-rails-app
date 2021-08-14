<template>
  <v-app>
    <v-col
      cols="3"
      class="list"
    >
      <v-list
        v-for="(menu, i) in menus"
        :key="`menu-btn-${i}`"
        nav
        rounded
      >
        <v-list-item
          two-line
          :to="`/${menu.title}`"
          class="justify-center"
        >
          <v-icon
            size="28"
            class="mr-5"
            v-text="menu.icon"
          />
          {{ $t(`menus.${menu.title}`) }}
        </v-list-item>
      </v-list>
    </v-col>
  </v-app>
</template>

<script>
export default {
  data () {
    return {
      menus: [
        { title: 'posts', icon: 'mdi-home' },
        { title: 'search', icon: 'mdi-magnify' },
        { title: 'notification', icon: 'mdi-bell' },
        { title: 'chat', icon: 'mdi-chat-processing-outline' },
        { title: 'follow', icon: 'mdi-account-details' },
        { title: 'follower', icon: 'mdi-account-details-outline' }
      ]
    }
  }
}
</script>

<style scoped>
  .list {
    position: fixed;
  }
</style>
