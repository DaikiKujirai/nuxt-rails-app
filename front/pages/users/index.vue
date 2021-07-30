<template>
  <v-container
    fluid
    class="d-flex"
  >
    <v-row>
      <v-col
        v-for="user in users"
        :key="user.id"
        cols="4"
      >
        <v-card
          hover
          :to="`/users/${user.id}`"
          class="d-flex"
        >
          <v-img
            :src="src"
            max-height="200"
            max-width="200"
            contain
          />
          <div>
            <v-card-title>
              {{ user.name }}
            </v-card-title>
            <v-card-text>
              {{ user.introduction }}
            </v-card-text>
          </div>
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
      users: [],
      src: 'https://picsum.photos/200/200'
    }
  },
  mounted () {
    this.fetchContents()
  },
  methods: {
    fetchContents () {
      const url = '/api/v1/users'
      this.$axios.get(url)
        .then((res) => {
          this.users = res.data
        })
        .catch((err) => {
          console.error(err) // eslint-disable-line
        })
    }
  }
}
</script>
