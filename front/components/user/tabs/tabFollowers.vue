<template>
  <v-tab-item
    class="mb-2"
  >
    <v-row
      v-for="user in users"
      :key="user.id"
      style="cursor: pointer;"
      @click="toShow('users', user.id)"
    >
      <user-template
        :user="user"
      />
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
      url: `/api/v1/find_followers/${this.$route.params.id}`,
      src: 'https://picsum.photos/200/200'
    }
  },
  mounted () {
    this.fetchContents()
  },
  methods: {
    async fetchContents () {
      const url = `/api/v1/find_followers/${this.$route.params.id}`
      await this.$axios.get(url)
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
