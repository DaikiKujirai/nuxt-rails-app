<template>
  <v-container
    fluid
    class="d-flex"
  >
    <v-row
      justify="center"
      align="center"
    >
      <v-col
        cols="12"
        :sm="container.sm"
        :md="container.md"
      >
        <v-card-title>
          全ての会員
        </v-card-title>
        <v-divider class="mb-4" />
        <v-card>
          <v-simple-table
            :items="users"
            item-key="name"
          >
            <template v-slot:default> <!--eslint-disable-line-->
              <thead>
                <tr>
                  <th>
                    アイコン
                  </th>
                  <th>
                    名前
                  </th>
                  <th>
                    紹介文
                  </th>
                </tr>
              </thead>
              <tbody>
                <tr
                  v-for="user in users"
                  :key="user.name"
                >
                  <td>
                    <v-avatar size="150">
                      <v-img
                        :src="src"
                        max-height="200"
                        max-width="200"
                        contain
                      />
                    </v-avatar>
                  </td>
                  <td>
                    <nuxt-link :to="`/users/${user.id}`">
                      {{ user.name }}
                    </nuxt-link>
                  </td>
                  <td>
                    {{ user.introduction }}
                  </td>
                </tr>
              </tbody>
            </template>
          </v-simple-table>
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
      src: 'https://picsum.photos/200/200',
      container: {
        sm: 10,
        md: 8
      }
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
