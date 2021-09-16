<template>
  <div>
    <template v-if="$route.name === 'users-id'">
      <v-divider class="mb-2" />
    </template>
    <v-row>
      <v-col
        class="d-flex"
      >
        <v-img
          :src="user.avatar.url"
          max-height="70"
          max-width="70"
          contain
          hover
          style="border-radius: 50%;"
          class="ml-3 img"
          @click.prevent.stop="toShow('users', postContainerForEdit.user_id)"
        />
        <v-card-text>
          {{ user.name }}
        </v-card-text>
        <v-card-text
          class="text-right"
        >
          <v-icon
            size="16"
            v-text="'mdi-update'"
          />
          {{ $my.format(postContainerForEdit.created_at) }}
        </v-card-text>
      </v-col>
    </v-row>
    <template v-if="postContainerForEdit.post_id !== 0">
      <v-row>
        <v-col class="py-0">
          <span class="pt-2 pl-2">
            返信先：
          </span>
          <u
            style="cursor: pointer;"
            @click.prevent.stop="toShow('users', replyUser.id)"
          >
            {{ replyUser.name }}
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
          {{ postContainerForEdit.content }}
        </v-card-title>
        <template v-if="postContainerForEdit.image">
          <v-img
            :src="postContainerForEdit.image.url"
            max-height="300"
            max-width="300"
            contain
            class="ma-3"
          />
        </template>
      </v-col>
    </v-row>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
  props: {
    post: {
      type: Object,
      required: true
    },
    user: {
      type: Object,
      required: true
    },
    repUser: {
      type: Object,
      default: () => {}
    }
  },
  data () {
    return {
      postContainerForEdit: {},
      replyUser: {}
    }
  },
  computed: {
    ...mapGetters({
      updatePost: 'post/updatePost'
    })
  },
  watch: {
    async updatePost (val) {
      if (val.bool && val.post.id === this.post.id) {
        this.postContainerForEdit = await val.post
        this.setUpdatePost = await { bool: false, post: {} }
      }
    }
  },
  created () {
    this.postContainerForEdit = this.post
    this.$route.name === 'users-id' && this.post.post_id !== 0
      ? (this.fetchReplyToUser())
      : (this.replyUser = this.repUser)
  },
  methods: {
    ...mapActions({
      setUpdatePost: 'post/setUpdatePost'
    }),
    async fetchReplyToUser () {
      const url = `/api/v1/posts/${this.post.post_id}`
      await this.$axios.get(url)
        .then((res) => {
          this.replyUser = res.data.user
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    toShow (page, id) {
      this.$router.push(`/${page}/${id}`)
    }
  }
}
</script>

<style>
  .img:hover {
    opacity: 0.7;
  }
</style>
