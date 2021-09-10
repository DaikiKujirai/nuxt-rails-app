<template>
  <v-tooltip bottom>
    <template #activator="{ on, attrs }">
      <v-btn
        icon
        large
        v-bind="attrs"
        v-on="on"
      >
        <v-icon
          v-text="'mdi-email-outline'"
        />
      </v-btn>
    </template>
    <span>メッセージ</span>
  </v-tooltip>
</template>

<script>
export default {
}
</script>
