<template>
  <div>
    <v-divider />
    <v-row>
      <v-col
        cols="2"
      >
        <v-img
          :src="user.avatar.url"
          height="70"
          max-width="70"
          class="ma-2"
          style="border-radius: 50%;"
        />
      </v-col>
      <v-col class="d-flex justify-space-between pt-0">
        <v-card-title class="pa-0">
          {{ user.name }}
        </v-card-title>
        <template
          v-if="user.id !== currentUser.id"
          class="text-right"
        >
          <btn-follow
            :user="user"
            class="ma-5"
          />
        </template>
      </v-col>
    </v-row>
    <v-col class="text-left">
      {{ user.introduction }}
    </v-col>
  </div>
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
  computed: {
    ...mapGetters({
      currentUser: 'auth/data'
    })
  },
  mounted () {
    if (this.user.introduction.length > 80) {
      this.sliceIntroduction(this.user)
    }
  },
  methods: {
    sliceIntroduction (user) {
      user.introduction = user.introduction.substr(0, 80) + '...'
    }
  }
}
</script>
