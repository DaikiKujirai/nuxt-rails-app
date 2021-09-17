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
          :user="user"
        />
        <template v-if="isAuthenticated">
          <actions
            :post="post"
            :user="user"
            :likes="post.likes"
            :is-list="isList"
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
import { mapGetters, mapActions } from 'vuex'
import Actions from '../../loggedIn/mainCard/actions.vue'
import PostCard from '../../post/postCard.vue'
import InfiniteScroll from '../../ui/infiniteScroll.vue'

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
    },
    currentTab: {
      type: String,
      required: true
    }
  },
  data () {
    return {
      posts: [],
      page: 1,
      url: `/api/v1/show_user_posts/${this.user.id}`,
      isList: true
    }
  },
  computed: {
    ...mapGetters({
      isAuthenticated: 'auth/isAuthenticated',
      currentUser: 'auth/data',
      deletePost: 'post/deletePost'
    })
  },
  watch: {
    deletePost (val) {
      if (val.bool && this.currentTab === 'posts') {
        const posts = this.posts.filter(post => post.id !== val.post.id)
        this.posts = posts
        this.setDeletePost({ bool: false, post: {} })
      }
    }
  },
  created () {
    this.fetchContents()
  },
  methods: {
    ...mapActions({
      setDeletePost: 'post/setDeletePost'
    }),
    async fetchContents () {
      const url = `/api/v1/show_user_posts/${this.user.id}`
      await this.$axios.get(url)
        .then((res) => {
          this.posts = res.data.user_posts
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
      this.posts.push(...res.data.user_posts)
    }
  }
}
</script>
