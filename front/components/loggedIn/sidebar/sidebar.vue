<template>
  <v-col
    cols="2"
    offset-md="1"
    class="col"
  >
    <div
      v-for="(menu, i) in menus"
      :key="`menu-btn-${i}`"
    >
      <v-btn
        text
        rounded
        x-large
        class="mb-4"
        :to="`/${menu.title}`"
      >
        <v-icon
          size="28"
          class="mr-5"
          v-text="menu.icon"
        />
        {{ $t(`menus.${menu.title}`) }}
      </v-btn>
    </div>
  </v-col>
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
</style>
