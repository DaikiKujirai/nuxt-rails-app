<template>
  <v-tooltip bottom>
    <template #activator="{ on, attrs }">
      <v-btn
        icon
        large
        v-bind="attrs"
        v-on="on"
        @click="toChat"
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
import { mapGetters, mapActions } from 'vuex'
import firebase from '~/plugins/firebase'

export default {
  props: {
    user: {
      type: Object,
      required: true
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data'
    })
  },
  methods: {
    ...mapActions({
      setMessageRecipientUser: 'chat/setMessageRecipientUser'
    }),
    toChat () {
      // const params = { messageRecipientId: this.user.id, user_id: this.currentUser.id }
      firebase.firestore()
        .collection('rooms')
        .doc(this.$route.params.id)
        .collectionset({ message: 'メッセージ' })
      // firebase.firestore().collection('rooms').where('user_id', '==', this.currentUser.id).get()
        .then((res) => {
          console.log(res)
          // this.setMessageRecipientUser(this.user)
        })
        .catch((err) => {
          console.log('err', err)
        })
    }
  }
}
</script>
