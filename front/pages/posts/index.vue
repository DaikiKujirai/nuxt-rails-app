<template>
  <layout-main #layout-main> <!--eslint-disable-line-->
    <v-card
      v-for="post in posts"
      :key="post.id"
      class="mt-3"
      @click="toShow(post.id)"
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
          <v-card-text
            class="text-right"
          >
            <v-icon size="16">
              mdi-update
            </v-icon>
            {{ $my.format(post.created_at) }}
          </v-card-text>
        </v-col>
      </v-row>
      <div>
        <v-card-title
          class="card-content"
        >
          {{ post.content }}
        </v-card-title>
      </div>
      <v-card-actions>
        <v-btn
          :color="btnColor"
          text
        >
          <v-icon>
            mdi-heart-outline
          </v-icon>
        </v-btn>
        <v-spacer />
        <btn-new-comment
          :post="post"
        />
        <v-spacer />
        <template v-if="post.user_id === currentUser.id">
          <btn-edit-post-in-index
            :post="post"
          />
          <v-spacer />
        </template>
        <btn-delete-post />
      </v-card-actions>
    </v-card>
  </layout-main>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import btnEditPostInIndex from '../../components/btn/btnEditPostInIndex.vue'
import btnNewComment from '../../components/btn/btnNewComment.vue'
import layoutMain from '../../components/layout/loggedIn/layoutMain.vue'

export default {
  components: {
    layoutMain,
    btnNewComment,
    btnEditPostInIndex
  },
  data () {
    return {
      src: 'https://picsum.photos/200/200',
      isIndex: true
    }
  },
  computed: {
    ...mapGetters({
      posts: 'post/posts',
      btnColor: 'btn/color',
      currentUser: 'auth/data'
    })
  },
  mounted () {
    this.fetchContents()
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage',
      setPosts: 'post/setPosts',
      setPost: 'post/setPost'
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
    },
    async toShow (id) {
      const url = `/api/v1/posts/${id}`
      await this.$axios.get(url)
        .then((res) => {
          this.setPost(res.data)
          this.$router.push(`posts/${res.data.id}`)
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
