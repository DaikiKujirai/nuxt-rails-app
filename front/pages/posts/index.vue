<template>
  <v-container
    fluid
  >
    <v-row>
      <sidebar />
      <v-col cols="6">
        <v-card
          v-for="post in posts"
          :key="post.id"
          :to="`/posts/${post.id}`"
        >
          <div class="d-flex">
            <v-img
              :src="src"
              max-height="200"
              max-width="200"
              contain
            />
          </div>
          {{ post }}
          <div>
            <v-card-title
              class="card-content"
            >
              {{ post.content }}
            </v-card-title>
            <v-card-text
              class="text-right"
            >
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
// import { mapGetters } from 'vuex'
import sidebar from '../../components/loggedIn/sidebar/sidebar.vue'

export default {
  components: {
    sidebar
  },
  data () {
    return {
      posts: [],
      src: 'https://picsum.photos/200/200'
    }
  },
  mounted () {
    this.fetchContents()
  },
  methods: {
    async fetchContents () {
      const url = '/api/v1/posts'
      await this.$axios.get(url)
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
  .card-content {
    height: 180px;
    min-width: 490px
  }
</style>
