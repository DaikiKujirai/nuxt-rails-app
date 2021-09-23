<template>
  <v-tab-item class="mt-3">
    <v-row
      v-for="like in likes"
      :key="like.post.id"
      style="cursor: pointer;"
      @click="toShow('posts', like.post.id)"
    >
      <v-col>
        <v-card>
          <post-card
            :post="like.post"
            :user="user"
          />
          <template v-if="isAuthenticated">
            <actions
              :post="like.post"
              :user="user"
              :likes="like.post.likes"
              :is-list="isList"
              @rollBackPage="rollBackPage"
              @fetchContents="fetchContents"
            />
          </template>
        </v-card>
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
import InfiniteScroll from '../../ui/infiniteScroll.vue'
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
    },
    currentTab: {
      type: String,
      required: true
    }
  },
  data () {
    return {
      likes: [],
      page: 1,
      isList: true,
      url: `/api/v1/show_user_like_posts/${this.$route.params.id}`
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
      if (val.bool && this.currentTab === 'likes') {
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
    async fetchContents () {
      const url = `/api/v1/show_user_like_posts/${this.user.id}`
      await this.$axios.get(url)
        .then((res) => {
          console.log(res)
          this.likes = res.data.user_likes
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
      console.log(res)
      this.likes.push(...res.data.user_likes)
    }
  }
}
</script>
