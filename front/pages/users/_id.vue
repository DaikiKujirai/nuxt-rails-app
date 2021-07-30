<template>
  <v-container
    class="mt-3"
  >
    <v-row>
      <v-col
        cols="8"
        offset="2"
      >
        <v-card
          align="center"
          class="pt-4"
        >
          <v-img
            :src="src"
            max-height="500"
            max-width="500"
            contain
          />
          <v-card-title>
            {{ user.name }}
          </v-card-title>
          <v-card-text>
            {{ user.introduction }}
          </v-card-text>
          <v-card-actions>
            <v-btn
              color="deep-purple lighten-2"
              text
            >
              いいね
              <v-icon>
                mdi-heart-outline
              </v-icon>
            </v-btn>
            <v-btn
              color="deep-purple lighten-2"
              text
            >
              コメント
              <v-icon>
                mdi-chat-processing-outline
              </v-icon>
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  layout: 'loggedIn',
  data: () => {
    return {
      user: {},
      src: 'https://picsum.photos/500/500'
    }
  },
  mounted () {
    this.fetchContents()
  },
  methods: {
    fetchContents () {
      const url = `/api/v1/users/${this.$route.params.id}`
      this.$axios.get(url)
        .then((res) => {
          // eslint-disable-next-line
          console.log('投稿詳細')
          this.user = res.data
        })
        .catch((err) => {
          console.error(err) // eslint-disable-line
        })
    }
  }
}
</script>
