<template>
  <v-tab-item
    class="mb-2"
  >
    <v-form
      ref="form"
      v-model="isValid"
    >
      <v-row>
        <v-col class="px-15 pb-0">
          <user-form-password
            :password.sync="password"
            :outlined="outlined"
            label="現在のパスワードを入力"
            class="mx-15 px-10"
          />
        </v-col>
      </v-row>
      <v-row>
        <v-col class="px-15 pb-0">
          <user-form-password
            :new-password.sync="newPassword"
            :outlined="outlined"
            label="新しいパスワードを入力"
            class="mx-15 px-10"
          />
        </v-col>
      </v-row>
      <v-row>
        <v-col class="text-center my-10">
          <v-btn
            :disabled="!isValid || loading"
            :loading="loading"
            rounded
            color="success"
          >
            プロフィールを更新
          </v-btn>
        </v-col>
      </v-row>
    </v-form>
  </v-tab-item>
</template>

<script>
import UserFormPassword from '../../userFormPassword.vue'

export default {
  components: {
    UserFormPassword
  },
  data () {
    return {
      tab: null,
      isValid: false,
      loading: false,
      outlined: false,
      password: '',
      newPassword: ''
    }
  },
  methods: {
  }
}
</script>
