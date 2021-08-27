<template>
  <v-row>
    <v-col>
      <v-card class="pa-3">
        <v-row>
          <v-col class="d-flex">
            <v-img
              :src="src"
              max-height="70"
              max-width="70"
              contain
              style="border-radius: 50%;"
            />
            <v-textarea
              auto-grow
              counter="140"
              label="なにかあった？"
              class="mx-3"
            />
          </v-col>
        </v-row>
        <v-row>
          <v-col class="d-flex justify-end">
            <v-btn
              color="info"
              rounded
              @click="submitPost"
              v-text="'ツイートする'"
            />
          </v-col>
        </v-row>
      </v-card>
    </v-col>
  </v-row>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  data () {
    return {
      dialog: false,
      isValid: false,
      loading: false,
      post: { content: '' },
      src: 'https://picsum.photos/200/200'
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data'
    })
  },
  methods: {
    async submitPost () {
      this.loading = true
      this.post.user_id = this.currentUser.id
      await this.$axios.$post('/api/v1/posts', this.post)
        .then(() => {
          this.flashMessage({ message: '投稿しました', type: 'primary', status: true })
          this.fetchContents()
          this.loading = false
          this.dialog = false
          this.$refs.form.reset()
        })
        .catch((err) => {
          this.flashMessage({ message: err.response.data.message.join('\n'), type: 'error', status: true })
          this.loading = false
        })
    }
  }
}
</script>
