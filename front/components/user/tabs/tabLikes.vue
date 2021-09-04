<template>
  <v-tab-item class="mb-2">
    <v-row
      v-for="post in posts"
      :key="post.id"
      style="cursor: pointer;"
      @click="toShow('posts', post.id)"
    >
      <v-col>
        <post-card
          :post="post"
        />
        <template v-if="isAuthenticated">
          <actions
            :post="post"
            :is-index="isIndex"
            @rollBackPage="rollBackPage"
            @fetchContents="fetchContents"
          />
        </template>
      </v-col>
    </v-row>
    <infinite-scroll
      :page="page"
      :url="url"
      @pushContents="pushContents"
      @pageIncrement="pageIncrement"
    />
  </v-tab-item>
</template>

<script>
import { mapGetters } from 'vuex'
import InfiniteScroll from '../../infiniteScroll.vue'
import Actions from '../../loggedIn/mainCard/actions.vue'
import PostCard from '../../post/postCard.vue'

export default {
  components: {
    Actions,
    PostCard,
    InfiniteScroll
  },
  props: {
    user: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      posts: [],
      page: 1,
      isIndex: true,
      url: `/api/v1/show_user_like_posts/${this.$route.params.id}`,
      src: 'https://picsum.photos/500/500'
    }
  },
  computed: {
    ...mapGetters({
      isAuthenticated: 'auth/isAuthenticated',
      currentUser: 'auth/data'
    })
  },
  methods: {
    async fetchContents () {
      const url = `/api/v1/show_user_like_posts/${this.user.id}`
      await this.$axios.get(url)
        .then((res) => {
          this.posts = res.data.user_like_posts
        })
    },
    toShow (page, id) {
      this.$router.push(`/${page}/${id}`)
    },
    rollBackPage () {
      this.page = 1
    },
    pageIncrement () {
      this.page++
    },
    pushContents (res) {
      this.posts.push(...res.data.user_like_posts)
    }
  }
}
</script>
