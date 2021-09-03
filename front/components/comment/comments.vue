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
          />
          <template v-if="isAuthenticated">
            <actions
              :post="comment"
              :is-index="isIndex"
              @rollBackPage="rollBackPage"
              @fetchContents="fetchContents"
            />
          </template>
        </v-card>
      </v-col>
    </v-row>
    <infinite-scroll
      :posts="comments"
      :page="page"
      :url="url"
      @pushPosts="pushPosts"
      @pageIncrement="pageIncrement"
    />
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import Actions from '../loggedIn/mainCard/actions.vue'
import PostCard from '../post/postCard.vue'

export default {
  components: {
    Actions,
    PostCard
  },
  props: {
    post: {
      type: Object,
      required: true
    },
    user: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      comments: [],
      isIndex: true,
      page: 1,
      url: `/api/v1/find_comments/${this.$route.params.id}`,
      src: 'https://picsum.photos/500/500'
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data',
      isAuthenticated: 'auth/isAuthenticated',
      btnColor: 'btn/color'
    })
  },
  methods: {
    async fetchComments () {
      const url = `/api/v1/find_comments/${this.$route.params.id}`
      await this.$axios.get(url)
        .then((res) => {
          this.comments = res.data.comments
        })
    },
    fetchContents () {
      this.$emit('fetchContents')
    },
    rollBackPage () {
      this.page = 1
    },
    pageIncrement () {
      this.page++
    },
    pushPosts (res) {
      this.comments.push(...res.data.comments)
    },
    toShow (page, id) {
      this.$router.push(`/${page}/${id}`)
    }
  }
}
</script>
