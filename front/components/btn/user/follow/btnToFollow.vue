<template>
  <div>
    {{ followCount }}
    <v-btn
      :color="btnColor"
      text
      rounded
      class="px-0"
      @click="toShow('relationships', $route.params.id, 1)"
    >
      フォロー中
    </v-btn>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  data () {
    return {
      followCount: 0
    }
  },
  computed: {
    ...mapGetters({
      btnColor: 'btn/color'
    })
  },
  mounted () {
    this.fetchContents()
  },
  methods: {
    async fetchContents () {
      const url = `/api/v1/find_following/${this.$route.params.id}`
      await this.$axios.get(url)
        .then((res) => {
          this.followCount = res.data.kaminari.pagination.count
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    toShow (page, id, tab) {
      this.$router.push(`/${page}/${id}?tab=${tab}`)
    }
  }
}
</script>
