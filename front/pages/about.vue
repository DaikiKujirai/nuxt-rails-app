<template>
  <v-container fluid>
    <v-app-bar
      dense
      collapse-on-scroll
    >
      <v-app-bar-nav-icon />
      <v-spacer />
      <v-btn
        to="/"
        :color="colors[1]"
      >
        Bookers
      </v-btn>
    </v-app-bar>
    <v-row>
      <v-col>
        <v-card>
          <v-card-title>
            Userテーブル
          </v-card-title>
        </v-card>
      </v-col>
      <v-col cols="8">
        <v-card>
          <v-card-text>
            <v-simple-table>
              <template
                v-if="users.length"
                #default
              >
                <thead>
                  <tr>
                    <th
                      v-for="(key, i) in userKeys"
                      :key="`key-${i}`"
                    >
                      {{ key }}
                    </th>
                  </tr>
                </thead>
                <tbody>
                  <tr
                    v-for="(user, i) in users"
                    :key="`user-${i}`"
                  >
                    <td>
                      {{ user.id }}
                    </td>
                    <td>
                      {{ user.name }}
                    </td>
                    <td>
                      {{ user.email }}
                    </td>
                    <td>
                      {{ user.created_at }}
                    </td>
                  </tr>
                </tbody>
              </template>
            </v-simple-table>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  async asyncData ({ $axios }) {
    let users = []
    await $axios.$get('api/v1/users').then(res => (users = res))
    const userKeys = Object.keys(users[0] || {})
    return { users, userKeys }
  },
  data () {
    return {
      colors: [
        'primary',
        'info',
        'success',
        'warning',
        'error',
        'background'
      ]
    }
  },
  computed: {
    dataFormat () {
      return (date) => {
        const dateTimeFormat = new Intl.DateTimeFormat(
          'ja', { dateStyle: 'medium', timeStyle: 'short' }
        )
        return dateTimeFormat.format(new Date(date))
      }
    }
  }
}
</script>
