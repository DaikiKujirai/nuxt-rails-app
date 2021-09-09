<template>
  <v-col>
    <v-divider class="mb-2" />
    <v-row>
      <v-col
        class="d-flex"
      >
        <v-img
          :src="user.avatar.url"
          max-height="70"
          max-width="70"
          contain
          style="border-radius: 50%;"
          class="ml-3"
        />
        <v-card-title>
          {{ user.name }}
        </v-card-title>
        <template v-if="user.id !== currentUser.id">
          <btn-follow
            :user="user"
          />
        </template>
      </v-col>
    </v-row>
    <v-row>
      <v-col>
        <v-card-title>
          {{ user.introduction }}
        </v-card-title>
      </v-col>
    </v-row>
  </v-col>
</template>

<script>
import { mapGetters } from 'vuex'
import btnFollow from '../btn/user/follow/btnFollow.vue'

export default {
  components: {
    btnFollow
  },
  props: {
    user: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      src: 'https://picsum.photos/200/200'
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data'
    })
  }
}
</script>
