<template>
  <v-list
    nav
    rounded
  >
    <v-list-item
      two-line
      class="justify-center"
      @click="toNotification"
    >
      <v-icon
        size="28"
        class="mr-5"
        v-text="'mdi-bell'"
      />
      通知
      <template v-if="count">
        <v-badge
          bordered
          color="error"
          :content="count"
        />
      </template>
    </v-list-item>
  </v-list>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  data () {
    return {
      count: 0
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data'
    })
  },
  watch: {
    isActive (val) {
      if (val) {
        this.fetchContents()
        this.setIsActive(false)
      }
    }
  },
  mounted () {
    setTimeout(() => {
      this.fetchContents()
    }, 500)
  },
  methods: {
    toNotification () {
      this.$router.push(`/notifications/${this.currentUser.id}`)
    },
    fetchContents () {
      const url = `api/v1/find_notifications_count/${this.currentUser.id}`
      this.$axios.get(url)
        .then((res) => {
          this.count = res.data
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    }
  }
}
</script>
