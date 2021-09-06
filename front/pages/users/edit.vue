<template>
  <layoutMain #layout-main> <!--eslint-disable-line-->
    <v-row>
      <v-col>
        <v-card>
          <v-row>
            <v-col>
              プロフィール編集
            </v-col>
          </v-row>
          <v-row>
            <v-col class="pb-0">
              <v-img
                :src="src"
                height="250"
              />
              <input-file-form
                :label="labelCoverImage"
                class="mx-15 mt-3"
                @change="coverImage = $event"
              />
            </v-col>
          </v-row>
          <v-row>
            <v-col class="d-flex pt-0">
              <v-img
                :src="src"
                max-height="120"
                max-width="120"
                contain
                style="border-radius: 50%;"
                class="ml-10"
              />
              <input-file-form
                :label="labelAvatar"
                class="mx-8 mt-10"
                @change="coverImage = $event"
              />
            </v-col>
          </v-row>
          <v-row>
            <v-col class="px-15">
              <user-form-name
                :outlined="false"
                class="mx-15"
              />
            </v-col>
          </v-row>
          <v-row>
            <v-col class="px-15">
              <user-form-introduction
                class="mx-15"
              />
            </v-col>
          </v-row>
        </v-card>
      </v-col>
    </v-row>
  </layoutMain>
</template>

<script>
import { mapGetters } from 'vuex'
import InputFileForm from '../../components/post/InputFileForm.vue'
import UserFormIntroduction from '../../components/user/userFormIntroduction.vue'
import UserFormName from '../../components/user/userFormName.vue'

export default {
  components: {
    InputFileForm,
    UserFormName,
    UserFormIntroduction
  },
  data () {
    return {
      src: 'https://picsum.photos/500/500',
      labelCoverImage: 'カバー画像を選択してください',
      labelAvatar: 'プロフィール画像を選択してください',
      // image: this.currentUser.cover,
      avatar: this.currentUser.avatar,
      name: this.currentUser.name,
      introduction: this.currentUser.introduction
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data'
    })
  },
  mounted () {
  },
  methos: {
  }
}
</script>
