<template>
  <v-row
    @click="toShow('posts', post.id)"
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
        さんがあなたの投稿に {{ action }} しました
      </v-card-text>
      <v-card-text
        class="text--disabled mt-0 pt-0"
      >
        {{ post.content }}
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
    },
    post: {
      type: Object,
      required: true
    }
  },
  data ({ $my }) {
    return {
      action: `${$my.action('actions.' + this.notification.action)}`
    }
  },
  computed: {
    icon () {
      if (this.action === 'コメント') {
        return 'mdi-chat-processing-outline'
      } else {
        return 'mdi-heart'
      }
    },
    color () {
      if (this.action === 'コメント') {
        return '#1c9cef'
      } else {
        return '#fa187f'
      }
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
