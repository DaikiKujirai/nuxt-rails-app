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
        :src="userAvatar"
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
    }
  },
  data ({ $my }) {
    return {
      user: {},
      userAvatar: '',
      content: '',
      action: `${$my.action('actions.' + this.notification.action)}`,
      post: {}
    }
  },
  computed: {
    icon () {
      if (this.action === 'コメント') {
        return 'mdi-chat-processing-outline'
      } else if (this.action === 'いいね') {
        return 'mdi-heart'
      } else {
        return 'mdi-acount'
      }
    },
    color () {
      if (this.action === 'コメント') {
        return '#1c9cef'
      } else if (this.action === 'いいね') {
        return '#fa187f'
      } else {
        return '#02b97c'
      }
    }
  },
  mounted () {
    this.fetchContents()
  },
  methods: {
    async fetchContents () {
      const url = `/api/v1/users/${this.notification.visitor_id}`
      await this.$axios.get(url)
        .then((res) => {
          this.user = res.data
          this.userAvatar = res.data.avatar.url
          this.fetchPost()
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    async fetchPost () {
      const url = `/api/v1/posts/${this.notification.post_id}`
      await this.$axios.get(url)
        .then((res) => {
          this.post = res.data.post
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
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
