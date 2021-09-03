<template>
  <v-tab-item>
    <v-row
      v-for="comment in comments"
      :key="comment.id"
      @click="toShow('page', comment.id)"
    >
      <v-col>
        <v-divider />
        <v-row>
          <v-col
            class="d-flex"
          >
            <v-img
              :src="src"
              max-height="70"
              max-width="70"
              contain
              style="border-radius: 50%;"
              class="ml-3 mt-3"
            />
            <v-col cols="7">
              <v-card-title>
                {{ comment.user_name }}
              </v-card-title>
            </v-col>
            <v-card-text
              class="text-right"
            >
              <v-icon
                size="16"
                v-text="'mdi-update'"
              />
              {{ $my.format(comment.created_at) }}
            </v-card-text>
          </v-col>
        </v-row>
        <p class="ml-3">
          返信先： {{ comment.user_name }} さん
        </p>
        <v-row>
          <v-col>
            <v-card-title
              class="card-content"
            >
              {{ comment.content }}
            </v-card-title>
          </v-col>
        </v-row>
        <template v-if="isAuthenticated">
          <actions
            :post="comment"
            :is-index="isIndex"
            @rollBackPage="rollBackPage"
            @fetchContents="fetchContents"
          />
        </template>
      </v-col>
    </v-row>
    <infinite-loading
      ref="infiniteLoading"
      spinner="bubbles"
      @infinite="infiniteHandler"
    >
      <div
        slot="no-results"
        class="mt-3"
      >
        <v-divider class="mb-3" />
        データはありません
      </div>
    </infinite-loading>
  </v-tab-item>
</template>

<script>
import { mapGetters } from 'vuex'
import Actions from '../../loggedIn/mainCard/actions.vue'

export default {
  components: {
    Actions
  },
  props: {
    user: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      comments: [],
      page: 1,
      kaminari: {},
      userId: 0,
      isIndex: true,
      src: 'https://picsum.photos/500/500'
    }
  },
  computed: {
    ...mapGetters({
      isAuthenticated: 'auth/isAuthenticated',
      currentUser: 'auth/data',
      btnColor: 'btn/color'
    })
  },
  methods: {
    async fetchContents () {
      const url = `/api/v1/show_user_comments/${this.user.id}`
      await this.$axios.get(url)
        .then((res) => {
          console.log(res)
          this.comments = res.data.user_comments
          this.kaminari = res.data.kaminari
          // this.userId = this.user.id
        })
    },
    infiniteHandler () {
      setTimeout(() => {
        const url = `api/v1/show_user_comments/${this.user.id}`
        this.page++
        this.$axios.get(url, { params: { page: this.page } })
          .then((res) => {
            setTimeout(() => {
              if (this.page <= res.data.kaminari.pagination.pages) {
                this.comments.push(...res.data.user_comments)
                this.$refs.infiniteLoading.stateChanger.loaded()
              } else {
                this.$refs.infiniteLoading.stateChanger.complete()
              }
            })
          })
          .catch(() => {
            this.$refs.infiniteLoading.stateChanger.complete()
          })
      }, 1000)
    },
    toShow (page, id) {
      this.$router.push(`/${page}/${id}`)
    },
    rollBackPage () {
      this.page = 1
    }
  }
}
</script>
