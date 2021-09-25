<template>
  <layout-main #layout-main> <!--eslint-disable-line-->
    <v-row
      v-for="like in likes"
      :key="like.id"
    >
      <v-col class="pa-2">
        <v-card
          @click="toShow('users', like.user.id)"
        >
          <user-template
            :user="like.user"
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
  </layout-main>
</template>

<script>
import { mapActions } from 'vuex'
import LayoutMain from '../../components/layout/loggedIn/layoutMain.vue'
import InfiniteScroll from '../../components/ui/infiniteScroll.vue'
import userTemplate from '../../components/user/userTemplate.vue'

export default {
  components: {
    userTemplate,
    InfiniteScroll,
    LayoutMain
  },
  async asyncData ({ $axios, params }) {
    const res = await $axios.get(`/api/v1/likes/${params.id}`)
    return { likes: res.data.likes }
  },
  data () {
    return {
      page: 1,
      url: `/api/v1/likes/${this.$route.params.id}`,
      breadcrumbs: 'いいねしたユーザー'
    }
  },
  created () {
    this.setBreadcrumbs(this.breadcrumbs)
  },
  methods: {
    ...mapActions({
      setBreadcrumbs: 'breadcrumbs/setBreadcrumbs'
    }),
    rollBackPage () {
      this.page = 1
    },
    pageIncrement () {
      this.page++
    },
    pushContents (res) {
      this.likes.push(...res.data.likes)
    },
    toShow (page, id) {
      this.$router.push(`/${page}/${id}`)
    }
  }
}
</script>
