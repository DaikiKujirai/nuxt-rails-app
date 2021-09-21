<template>
  <v-row>
    <v-col>
      <v-card>
        <v-tabs
          v-model="tab"
          centered
          fixed-tabs
        >
          <v-tab
            @click="currentTab = 'posts'"
          >
            投稿
          </v-tab>
          <v-tab
            @click="currentTab = 'comments'"
          >
            コメント
          </v-tab>
          <v-tab
            @click="currentTab = 'images'"
          >
            メディア
          </v-tab>
          <v-tab
            @click="currentTab = 'likes'"
          >
            いいね
          </v-tab>
        </v-tabs>
      </v-card>
      <v-tabs-items v-model="tab">
        <v-app>
          <tab-posts
            :user="user"
            :current-tab="currentTab"
          />
          <tab-comments
            :user="user"
            :current-tab="currentTab"
          />
          <tab-image
            :user="user"
            :current-tab="currentTab"
          />
          <tab-likes
            :user="user"
            :current-tab="currentTab"
          />
        </v-app>
      </v-tabs-items>
    </v-col>
  </v-row>
</template>

<script>
import TabPosts from './tabs/tabPosts.vue'
import TabComments from './tabs/tabComments.vue'
import TabLikes from './tabs/tabLikes.vue'
import TabImage from './tabs/tabImages.vue'

export default {
  components: {
    TabPosts,
    TabComments,
    TabLikes,
    TabImage
  },
  props: {
    user: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      tab: null,
      currentTab: 'posts'
    }
  }
}
</script>
