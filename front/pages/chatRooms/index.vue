<template>
  <layout-chat #layout-chat > <!--eslint-disable-line-->
    <v-card class="mt-15">
      <v-card-title>
        チャットを選択してください
      </v-card-title>
    </v-card>
  </layout-chat>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import LayoutChat from '../../components/layout/loggedIn/layoutChat.vue'

export default {
  components: {
    LayoutChat
  },
  data () {
    return {
      breadcrumbs: 'チャット',
      userId: 0
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data'
    })
  },
  created () {
    this.setBreadcrumbs(this.breadcrumbs)
  },
  methods: {
    ...mapActions({
      setBreadcrumbs: 'breadcrumbs/setBreadcrumbs'
    })
  }
}
</script>
