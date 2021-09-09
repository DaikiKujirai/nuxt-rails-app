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
          <user-form-email
            :email.sync="user.email"
            :outlined="outlined"
            :label="label"
            class="mx-15"
          />
        </v-col>
      </v-row>
      <v-row>
        <v-col class="px-15 pb-0">
          <user-form-password
            :password.sync="user.password"
            :outlined="outlined"
            class="mx-15"
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
import userFormEmail from '../../userFormEmail.vue'
import UserFormPassword from '../../userFormPassword.vue'
export default {
  components: {
    userFormEmail,
    UserFormPassword
  },
  data () {
    return {
      tab: null,
      isValid: false,
      loading: false,
      outlined: false,
      label: '新しいメールアドレスを入力',
      user: {
        email: '',
        password: ''
      }
    }
  }
}
</script>
