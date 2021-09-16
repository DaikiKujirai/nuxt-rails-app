<template>
  <div>
    {{ user.followings.length }}
    <v-btn
      text
      rounded
      class="px-0"
      @click="toShow('relationships', $route.params.id, 1)"
    >
      フォロー中
    </v-btn>
  </div>
</template>

<script>
export default {
  props: {
    user: {
      type: Object,
      required: true
    }
  },
  methods: {
    toShow (page, id, tab) {
      this.$router.push(`/${page}/${id}?tab=${tab}`)
    }
  }
}
</script>
