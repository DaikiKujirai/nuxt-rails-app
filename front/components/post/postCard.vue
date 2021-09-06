<template>
  <div>
    <template v-if="$route.name === 'users-id'">
      <v-divider class="mb-2" />
    </template>
    <v-row>
      <v-col
        class="d-flex"
      >
        {{ post }}
        <v-img
          :src="post.user_avatar.url"
          max-height="70"
          max-width="70"
          contain
          style="border-radius: 50%;"
          class="ml-3"
          @click.prevent.stop="toShow('users', post.user_id)"
        />
        <v-card-text>
          {{ post.user_name }}
        </v-card-text>
        <v-card-text
          class="text-right"
        >
          <v-icon
            size="16"
            v-text="'mdi-update'"
          />
          {{ $my.format(post.created_at) }}
        </v-card-text>
      </v-col>
    </v-row>
    <template v-if="post.post_id !== 0">
      <v-row>
        <v-col class="py-0">
          <span class="pt-2 pl-2">
            返信先：
          </span>
          <u
            style="cursor: pointer;"
            @click.prevent.stop="toShow('users', replyToUser.id)"
          >
            {{ replyToUser.name }}
          </u>
          <span>
            さん
          </span>
        </v-col>
      </v-row>
    </template>
    <v-row>
      <v-col>
        <v-card-title
          class="mx-3 pa-0"
        >
          {{ post.content }}
        </v-card-title>
        <template v-if="post.image">
          <v-img
            :src="post.image.url"
            max-height="400"
            max-width="400"
            contain
            class="ma-3"
          />
        </template>
      </v-col>
    </v-row>
  </div>
</template>

<script>
export default {
  props: {
    post: {
      type: Object,
      required: true
    }
  },
  data () {
    return {
      replyToUser: {}
    }
  },
  mounted () {
    this.$nextTick(() => {
      if (this.post.post_id !== 0) {
        this.fetchContents()
      }
    })
  },
  methods: {
    fetchContents () {
      const url = `/api/v1/posts/${this.post.post_id}`
      this.$axios.get(url)
        .then((res) => {
          this.replyToUser = res.data.user
        })
    },
    toShow (page, id) {
      this.$router.push(`/${page}/${id}`)
    }
  }
}
</script>
