<template>
  <v-app>
    <wel-app-bar />
    <v-img
      dark
      src="https://picsum.photos/id/20/1920/1080?blur=5"
      gradient="to top right, rgba(19,84,122,.6), rgba(128,208,199,.9)"
      :height="imgHeight"
    />
    <v-card
      v-for="post in posts"
      :key="post.id"
      class="mt-40"
    >
      <v-card-title>
        {{ post.title }}
      </v-card-title>
      <v-card-text>
        {{ post.content }}
      </v-card-text>
      <v-card-text>
        {{ post.created_at }}
      </v-card-text>
    </v-card>
    <v-card>
      <v-calendar-daily />
    </v-card>
  </v-app>
</template>

<script>
import welAppBar from '../../components/welcome/welAppBar.vue'

export default {
  components: {
    welAppBar
  },
  data: () => {
    return {
      posts: [],
      imgHeight: 500
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
          console.log(this.posts)
          return this.posts
        })
        .catch((err) => {
          console.error(err) // eslint-disable-line
        })
    }
  }
}
</script>
