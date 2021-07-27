<template>
  <bef-login-form-card #form-card-content> <!--eslint-disable-line-->
    <v-form
      v-model="isValid"
    >
      <user-form-name />
      <user-form-email />
      <user-form-password />
      <v-btn
        :disabled="!isValid"
        block
        color="myblue"
      >
        登録する
      </v-btn>
    </v-form>
  </bef-login-form-card>
</template>

<script>
import befLoginFormCard from '../components/beforeLogin/befLoginFormCard.vue'
import UserFormEmail from '../components/user/userFormEmail.vue'
import UserFormName from '../components/user/userFormName.vue'
import UserFormPassword from '../components/user/userFormPassword.vue'

export default {
  components: {
    befLoginFormCard,
    UserFormName,
    UserFormEmail,
    UserFormPassword
  },
  layout: 'beforeLogin',
  data () {
    return {
      inValid: false
    }
  }
}
</script>
