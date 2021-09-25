<template>
  <div>
    <v-row>
      <v-col
        style="width: 500px;"
        class="d-flex"
      >
        <div>
          <v-img
            :src="user.avatar.url"
            height="70"
            max-width="70"
            class="ml-3"
            style="border-radius: 50%;"
          />
        </div>
        <div
          style="width: 100%;"
          class="d-flex"
        >
          <v-card-title>
            {{ user.name }}
          </v-card-title>
          <template
            v-if="!isCurrentUser"
          >
            <v-spacer />
            <btn-follow
              :user="user"
              class="ma-5"
            />
          </template>
        </div>
      </v-col>
    </v-row>
    <v-card-title>
      {{ user.introduction }}
    </v-card-title>
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
  data () {
    return {
      isCurrentUser: false
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
    setTimeout(() => {
      if (this.user.id === this.currentUser.id) {
        this.isCurrentUser = true
      }
    }, 0)
  },
  methods: {
    sliceIntroduction (user) {
      user.introduction = user.introduction.substr(0, 80) + '...'
    }
  }
}
</script>
