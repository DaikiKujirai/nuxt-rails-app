<template>
  <v-tab-item>
    <v-row
      v-for="comment in comments"
      :key="comment.id"
      @click="toShow('posts', comment.id)"
    >
      <v-col>
        <post-card
          :post="comment"
          :user="user"
        />
        <template v-if="isAuthenticated">
          <actions
            :post="comment"
            :user="user"
            :likes="comment.likes"
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
import { mapGetters } from 'vuex'
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
    }
  },
  data () {
    return {
      comments: [],
      page: 1,
      url: `/api/v1/show_user_comments/${this.user.id}`,
      isList: true
    }
  },
  computed: {
    ...mapGetters({
      isAuthenticated: 'auth/isAuthenticated'
    })
  },
  created () {
    this.fetchContents()
  },
  methods: {
    async fetchContents () {
      const url = `/api/v1/show_user_comments/${this.user.id}`
      await this.$axios.get(url)
        .then((res) => {
          this.comments = res.data.user_comments
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
      this.comments.push(...res.data.user_comments)
    }
  }
}
</script>
