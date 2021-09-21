<template>
  <v-tab-item
    class="pt-4"
  >
    <v-row
      v-for="user in users"
      :key="user.id"
    >
      <v-col class="pa-2">
        <v-card
          @click="toShow('users', user.id)"
        >
          <user-template
            :user="user"
          />
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
import infiniteScroll from '../../ui/infiniteScroll.vue'
import UserTemplate from '../userTemplate.vue'

export default {
  components: {
    infiniteScroll,
    UserTemplate
  },
  data () {
    return {
      users: [],
      page: 1,
      url: `/api/v1/find_followers/${this.$route.params.id}`
    }
  },
  created () {
    this.fetchContents()
  },
  methods: {
    async fetchContents () {
      // const url = `/api/v1/find_followers/${this.$route.params.id}`
      await this.$axios.get(this.url)
        .then((res) => {
          this.users = res.data.followers
        })
    },
    rollBackPage () {
      this.page = 1
    },
    pageIncrement () {
      this.page++
    },
    pushContents (res) {
      this.users.push(...res.data.followers)
    },
    toShow (page, id) {
      this.$router.push(`/${page}/${id}`)
    }
  }
}
</script>
