<template>
  <v-container
    fluid
  >
    <v-row>
      <v-col cols="3">
        <v-card>
          <li>あ</li>
          <li>い</li>
          <li>う</li>
          <li>え</li>
          <li>お</li>
          <li>あ</li>
          <li>い</li>
          <li>う</li>
          <li>え</li>
          <li>お</li>
          <li>・</li>
          <li>・</li>
          <li>・</li>
          <li>・</li>
          <li>・</li>
          <li>・</li>
          <li>・</li>
          <li>・</li>
          <li>・</li>
        </v-card>
      </v-col>
      <v-col cols="6">
        <v-card
          v-for="post in posts"
          :key="post.id"
          :to="`/posts/${post.id}`"
          class="d-flex"
        >
          <v-img
            :src="src"
            max-height="200"
            max-width="200"
            contain
          />
          <div>
            <v-card-title>
              {{ post.title }}
            </v-card-title>
            <v-card-text>
              {{ post.content }}
            </v-card-text>
            <v-card-text>
              <v-icon size="16">
                mdi-update
              </v-icon>
              {{ $my.format(post.created_at) }}
            </v-card-text>
          </div>
        </v-card>
      </v-col>
      <v-col cols="3">
        <v-card>
          サイドバー
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  layout: 'loggedIn',
  data: () => {
    return {
      posts: [],
      src: 'https://picsum.photos/200/200'
    }
  },
  mounted () {
    this.fetchContents()
  },
  methods: {
    fetchContents () {
      const url = '/api/v1/posts'
      this.$axios.get(url)
        .then((res) => {
          this.posts = res.data
          return this.posts.sort((a, b) => {
            if (a.id > b.id) { return -1 }
            if (a.id < b.id) { return 1 }
            return 0
          })
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    }
  }
}
</script>

<style scope>
</style>
