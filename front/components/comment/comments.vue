<template>
  <div class="mt-3">
    <v-row
      v-for="comment in comments"
      :key="comment.id"
      class="mb-1"
    >
      <v-col>
        <v-card
          @click="toShow('posts', comment.id)"
        >
          <post-card
            :post="comment"
            :user="comment.user"
            :rep-user="post.user"
          />
          <template v-if="isAuthenticated">
            <actions
              :post="comment"
              :user="comment.user"
              :likes="comment.likes"
              :is-list="isList"
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
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import Actions from '../loggedIn/mainCard/actions.vue'
import PostCard from '../post/postCard.vue'
import InfiniteScroll from '../ui/infiniteScroll.vue'

export default {
  components: {
    Actions,
    PostCard,
    InfiniteScroll
  },
  props: {
    post: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      comments: [],
      isList: true,
      page: 1,
      url: `/api/v1/find_comments/${this.$route.params.id}`
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data',
      isAuthenticated: 'auth/isAuthenticated',
      deletePost: 'post/deletePost'
    })
  },
  watch: {
    deletePost (val) {
      if (val.bool) {
        const comments = this.comments.filter(comment => comment.id !== val.post.id)
        this.comments = comments
        this.setDeletePost({ bool: false, post: {} })
      }
    }
  },
  created () {
    this.fetchComments()
  },
  methods: {
    ...mapActions({
      setDeletePost: 'post/setDeletePost',
      setCommentsCountPagePostId: 'post/setCommentsCountPagePostId'
    }),
    async fetchComments () {
      const url = `/api/v1/find_comments/${this.$route.params.id}`
      await this.$axios.get(url)
        .then((res) => {
          this.comments = res.data.comments
          this.setCommentsCountPagePostId(res.data.comments.length)
        })
    },
    fetchContents () {
      this.$emit('fetchContents')
    },
    pageIncrement () {
      this.page++
    },
    pushContents (res) {
      this.comments.push(...res.data.comments)
    },
    toShow (page, id) {
      this.$router.push(`/${page}/${id}`)
    }
  }
}
</script>
