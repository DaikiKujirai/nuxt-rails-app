<template>
  <layoutMain #layout-main> <!--eslint-disable-line-->
    <v-row>
      <v-col>
        <v-card>
          <v-row>
            <v-col class="pb-0">
              <v-img
                :src="coverImage"
                height="250"
              />
              <input-file-form
                :label="labelCoverImage"
                class="mx-15 mt-3"
                @change="coverImage = $event"
              />
              {{ coverImage }}
            </v-col>
          </v-row>
          <v-row>
            <v-col class="d-flex pt-0">
              <v-img
                :src="avatar"
                max-height="120"
                max-width="120"
                contain
                style="border-radius: 50%;"
                class="ml-10"
              />
              {{ avatar }}
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
                :name.sync="name"
                :outlined="false"
                class="mx-15"
              />
              {{ name }}
            </v-col>
          </v-row>
          <v-row>
            <v-col class="px-15 pb-0">
              <user-form-introduction
                :introduction.sync="introduction"
                class="mx-15"
              />
              {{ introduction }}
            </v-col>
          </v-row>
          <v-row>
            <v-col class="text-center mb-3">
              <v-btn
                rounded
                color="success"
                @click="submitEdit"
              >
                プロフィールを更新
              </v-btn>
            </v-col>
          </v-row>
        </v-card>
      </v-col>
    </v-row>
  </layoutMain>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
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
      labelCoverImage: 'カバー画像を選択してください',
      labelAvatar: 'プロフィール画像を選択してください',
      name: '',
      introduction: '',
      coverImage: '',
      avatar: ''
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data'
    })
  },
  mounted () {
    this.$nextTick(() => {
      this.name = this.currentUser.name
      this.introduction = this.currentUser.introduction
      this.coverImage = this.currentUser.cover_image.url
      this.avatar = this.currentUser.avatar.url
    }, 500)
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage'
    }),
    async submitEdit () {
      this.loading = true
      const formData = new FormData()
      formData.append('user[id]', this.currentUser.id)
      formData.append('user[name]', this.name)
      formData.append('user[introduction]', this.introduction)
      formData.append('user[avatar]', this.avatar)
      formData.append('user[cover_image]', this.cover_image)
      // const config = {
      //   header: {
      //     'content-type': 'multipart/form-data'
      //   }
      // }
      await this.$axios.patch(`/api/v1/users/${this.currentUser.id}`, formData)
        .then(() => {
          this.flashMessage({ message: 'プロフィールを更新しました', type: 'success', status: true })
          this.$router.push(`/users/${this.currentUser.id}`)
          this.loading = false
        })
        .catch(() => {
          this.flashMessage({ message: '失敗しました', type: 'error', status: true })
          this.loading = false
        })
    }
  }
}
</script>
