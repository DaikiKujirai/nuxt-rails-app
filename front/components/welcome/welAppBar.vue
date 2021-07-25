<template>
  <v-app-bar
    app
    dark
    hide-on-scroll
    clipped-left
  >
    <v-app-bar-nav-icon />
    <v-toolbar-title>
      {{ appName }}
    </v-toolbar-title>
    <v-spacer />
    <v-toolbar-items>
      <v-btn
        v-for="(menu, i) in menus"
        :key="`menu-btn-${i}`"
        text
        rounded
        class="mr-2"
      >
        {{ $t(`menus.${menu.title}`) }}
      </v-btn>
    </v-toolbar-items>
    <v-btn
      rounded
      color="info"
      class="open-modal-btn"
      @click="dialog = true"
    >
      +
    </v-btn>
    <v-dialog
      v-model="dialog"
      width="500"
    >
      <v-card>
        <!-- eslint-disable-next-line vue/no-lone-template -->
        <div class="d-flex">
          <v-card-title>
            新規登録
          </v-card-title>
          <v-spacer />
          <v-icon
            size="30"
            class="mr-5"
            @click="dialog = false"
          >
            ✖︎
          </v-icon>
        </div>
        <v-textarea />
        <v-btn
          color="info"
          @click="dialog = false"
        >
          ボタン
        </v-btn>
      </v-card>
    </v-dialog>
  </v-app-bar>
</template>

<script>
export default {
  props: {
    menus: {
      type: Array,
      default: () => []
    }
  },
  data ({ $config: { appName } }) {
    return {
      appName,
      dialog: false
    }
  }
}
</script>
