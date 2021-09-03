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
          :src="src"
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
      <v-card-text>
        返信先： {{ post.user_name }} さん
      </v-card-text>
    </template>
    <v-row>
      <v-col>
        <v-card-title
          class="card-content"
        >
          {{ post.content }}
        </v-card-title>
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
      src: 'https://picsum.photos/200/200'
    }
  },
  methods: {
    toShow (page, id) {
      this.$router.push(`/${page}/${id}`)
    }
  }
}
</script>
