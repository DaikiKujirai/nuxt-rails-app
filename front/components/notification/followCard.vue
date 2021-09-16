<template>
  <v-row
    @click="toShow('users', user.id)"
  >
    <v-col
      cols="1"
      class="pl-5 text-center"
    >
      <v-icon
        size="40"
        :color="color"
        v-text="icon"
      />
    </v-col>
    <v-col>
      <v-img
        :src="user.avatar.url"
        max-height="50"
        max-width="50"
        contain
        hover
        style="border-radius: 50%; cursor: pointer;"
        class="ml-3 img"
        @click.prevent.stop="toShow('users', user.id)"
      />
      <v-card-text>
        <span
          class="title"
          @click.prevent.stop="toShow('users', user.id)"
        >
          {{ user.name }}
        </span>
        さんがあなたを {{ action }} しました
      </v-card-text>
    </v-col>
  </v-row>
</template>

<script>
export default {
  props: {
    notification: {
      type: Object,
      required: true
    },
    user: {
      type: Object,
      required: true
    }
  },
  data ({ $my }) {
    return {
      action: `${$my.action('actions.' + this.notification.action)}`,
      icon: 'mdi-account',
      color: '#02b97c'
    }
  },
  methods: {
    toShow (url, id) {
      this.$router.push(`/${url}/${id}`)
    }
  }
}
</script>

<style scoped>
  .title:hover {
    opacity: 0.7;
    text-decoration: underline;
  }
</style>
