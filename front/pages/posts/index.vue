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
          いいね
          <v-icon>
            mdi-heart-outline
          </v-icon>
        </v-btn>
        <v-spacer />
        <btn-new-comment
          :is-show-comment-count="true"
          :post="post"
        />
        <v-spacer />
        <btn-edit-post />
        <v-spacer />
        <btn-delete-post />
      </v-card-actions>
    </v-card>
  </layout-main>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import btnNewComment from '../../components/btn/btnNewComment.vue'
import layoutMain from '../../components/layout/loggedIn/layoutMain.vue'

export default {
  components: {
    layoutMain,
    btnNewComment
  },
  data () {
    return {
      src: 'https://picsum.photos/200/200'
    }
  },
  computed: {
    ...mapGetters({
      posts: 'post/posts',
      gettersUser: 'post/user',
      btnColor: 'btn/color'
    })
  },
  mounted () {
    this.fetchContents()
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage',
      setPosts: 'post/setPosts',
      setPost: 'post/setPost',
      setPostUser: 'post/setUser',
      setComments: 'comment/setComments'
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
          this.setPostUser(res.data.user)
          // this.setComments(res.data.comments)
          this.$router.push(`posts/${res.data.id}`)
          console.log('post', res.data)
        })
        .catch((err) => {
          console.error(err)
        })
    }
  }
}
</script>

<style scope>
</style>
