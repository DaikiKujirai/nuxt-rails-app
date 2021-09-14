<template>
  <v-row>
    <v-col>
      <v-card-text>
        {{ user.name }} さんがあなたの投稿を {{  }} しました
      </v-card-text>
    </v-col>
  </v-row>
</template>

<script>
export default {
  props: {
    notification: {
      type: Object,
      required: true
    }
  },
  data ({ $my, props }) {
    return {
      user: {},
      userAvatar: '',
      content: '',
      action: `${$my.action(props.notification.action)}`
    }
  },
  mounted () {
    this.fetchContents()
  },
  methods: {
    async fetchContents () {
      const url = `/api/v1/users/${this.notification.visitor_id}`
      await this.$axios.get(url)
        .then((res) => {
          this.user = res.data
          this.userAvatar = res.data.avatar.url
          this.selectAction()
        })
        .catch((err) => {
          console.error(err)
        })
    },
    selectAction () {
      this.notification === 'comment'
        ? (this.content = 'コメント')
        : (this.content = 'いいね')
    }
  }
}
</script>
