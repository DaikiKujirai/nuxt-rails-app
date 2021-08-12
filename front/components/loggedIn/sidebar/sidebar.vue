<template>
  <v-col
    cols="3"
  >
    <v-btn
      v-for="(menu, i) in menus"
      :key="`menu-btn-${i}`"
      text
      rounded
      x-large
      block
      class="ma-2"
      :to="`/${menu.title}`"
    >
      {{ $t(`menus.${menu.title}`) }}
    </v-btn>
  </v-col>
</template>

<script>
export default {
  data () {
    return {
      menus: [
        { title: 'posts', icon: 'mdi-account-cog' },
        { title: 'search', icon: 'mdi-magnify' },
        { title: 'notification', icon: 'mdi-bell' },
        { title: 'chat', icon: 'mdi-chat-processing-outline' },
        { title: 'follow' },
        { title: 'follower' }
      ]
    }
  }
}
</script>

<style scoped>
</style>
