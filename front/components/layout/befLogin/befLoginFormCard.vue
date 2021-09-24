<template>
  <v-container fluid>
    <v-row
      align="center"
      justify="center"
    >
      <v-col
        cols="12"
        class="my-8 text-center"
      >
        <template v-if="isForget">
          <h3 class="text-h5 font-weight-bold">
            パスワードをお忘れですか？<br>
            確認メールを送信します
          </h3>
        </template>
        <template v-else>
          <h1 class="text-h5 font-weight-bold">
            {{ appName }}に{{ pageTitle }}
          </h1>
        </template>
      </v-col>
      <v-card
        flat
        width="80%"
        max-width="330"
        color="transparent"
      >
        <slot name="form-card-content" />
      </v-card>
    </v-row>
  </v-container>
</template>

<script>
export default {
  data ({ $route, $config: { appName } }) {
    return {
      appName,
      pageTitle: this.$t(`pages.${$route.name}`)
    }
  },
  computed: {
    isForget () {
      return this.$route.name === 'auth-forgetPassword'
    }
  }
}
</script>
