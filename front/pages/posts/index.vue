<template>
  <layout-main #layout-main> <!--eslint-disable-line-->
    <v-card
      v-for="post in posts"
      :key="post.id"
      :to="`/posts/${post.id}`"
    >
      <v-row>
        <v-col class="d-flex">
          <v-img
            :src="src"
            max-height="70"
            max-width="70"
            contain
            style="border-radius: 50%;"
          />
          <v-card-text>
            {{ post.user.name }}
          </v-card-text>
        </v-col>
      </v-row>
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
  </layout-main>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import layoutMain from '../../components/layout/loggedIn/layoutMain.vue'

export default {
  components: {
    layoutMain
  },
  data () {
    return {
      // posts: [],
      src: 'https://picsum.photos/200/200'
    }
  },
  computed: {
    ...mapGetters({
      posts: 'post/posts'
    })
  },
  mounted () {
    this.fetchContents()
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage',
      setPosts: 'post/setPosts'
    }),
    async fetchContents () {
      const url = '/api/v1/posts'
      await this.$axios.get(url)
        .then((res) => {
          this.setPosts(res.data)
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
  /* .card-content {
    height: 180px;
    min-width: 490px;
  } */
</style>
