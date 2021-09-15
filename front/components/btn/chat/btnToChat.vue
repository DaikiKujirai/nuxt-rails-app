<template>
  <v-tooltip bottom>
    <template #activator="{ on, attrs }">
      <v-btn
        icon
        large
        v-bind="attrs"
        class="btn-to-chat"
        v-on="on"
        @click="toChat"
      >
        <v-icon
          v-text="'mdi-wechat'"
        />
      </v-btn>
    </template>
    <span>チャット</span>
  </v-tooltip>
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
    toChat () {
      this.$router.push(`/chats/${this.user.id}`)
    }
  }
}
</script>

<style scoped>
  .btn-to-chat:hover {
    color: #ffa500;
  }
</style>
