<template>
  <v-row>
    <v-col>
      <v-card>
        <v-tabs
          v-model="tab"
          centered
          fixed-tabs
        >
          <v-tab>
            投稿
          </v-tab>
          <v-tab>
            投稿と返信
          </v-tab>
          <v-tab>
            メディア
          </v-tab>
          <v-tab>
            いいね
          </v-tab>
        </v-tabs>
      </v-card>
      <v-tabs-items v-model="tab">
        <tab-posts
          :user="user"
          :posts="posts"
          @fetchUser="fetchUser"
        />
        <tab-comments
          :user="user"
          :comments="comments"
          @fetchUser="fetchUser"
        />
        <v-tab-item>
          メディア
        </v-tab-item>
        <tab-likes
          :likes="likes"
        />
      </v-tabs-items>
    </v-col>
  </v-row>
</template>

<script>
import TabPosts from './tabs/tabPosts.vue'
import TabComments from './tabs/tabComments.vue'
import TabLikes from './tabs/tabLikes.vue'

export default {
  components: {
    TabPosts,
    TabComments,
    TabLikes
  },
  props: {
    user: {
      type: Object,
      required: true
    },
    posts: {
      type: Array,
      required: true
    },
    comments: {
      type: Array,
      required: true
    },
    likes: {
      type: Array,
      required: true
    }
  },
  data () {
    return {
      tab: null
    }
  },
  methods: {
    fetchUser () {
      this.$emit('fetchUser')
    }
  }
}
</script>
