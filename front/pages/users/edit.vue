<template>
  <layoutMain #layout-main> <!--eslint-disable-line-->
    <v-row>
      <v-col>
        <v-form
          ref="form"
          v-model="isValid"
        >
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
                  @setImageInPreview="coverImage = $event"
                  @setImageInPostImage="editCoverImage = $event"
                />
              </v-col>
            </v-row>
            <v-row>
              <v-col class="d-flex pt-0">
                <v-img
                  :src="avatar"
                  height="120"
                  max-width="120"
                  style="border-radius: 50%;"
                  class="ml-10"
                />
                <input-file-form
                  :label="labelAvatar"
                  class="mx-8 mt-10"
                  @setImageInPreview="avatar = $event"
                  @setImageInPostImage="editAvatar = $event"
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
              </v-col>
            </v-row>
            <v-row>
              <v-col class="px-15 pb-0">
                <user-form-introduction
                  :introduction.sync="introduction"
                  class="mx-15"
                />
              </v-col>
            </v-row>
            <v-row>
              <v-col class="text-center mb-3">
                <template v-if="isGuest">
                  <v-btn
                    disabled
                    rounded
                    @click="toHome"
                  >
                    ゲストユーザーのため変更できません
                  </v-btn>
                </template>
                <template v-else>
                  <v-btn
                    :disabled="!isValid || loading"
                    :loading="loading"
                    rounded
                    color="success"
                    @click="submitEdit"
                  >
                    プロフィールを更新
                  </v-btn>
                </template>
              </v-col>
            </v-row>
          </v-card>
        </v-form>
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
  data ({ store }) {
    return {
      isValid: false,
      loading: false,
      labelCoverImage: 'カバー画像を選択してください',
      labelAvatar: 'プロフィール画像を選択してください',
      name: '',
      introduction: '',
      coverImage: '',
      avatar: '',
      editAvatar: '',
      editCoverImage: '',
      breadcrumbs: 'プロフィール編集',
      guest: process.env.GUEST_EMAIL
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data',
      user: 'auth/user'
    }),
    isGuest () {
      return this.guest === this.user.email
    }
  },
  mounted () {
    this.setBreadcrumbs(this.breadcrumbs)
    setTimeout(() => {
      this.name = this.currentUser.name
      this.introduction = this.currentUser.introduction
      this.coverImage = this.currentUser.cover_image.url
      this.avatar = this.currentUser.avatar.url
    }, 0)
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage',
      updateCurrentUser: 'auth/updateCurrentUser',
      setBreadcrumbs: 'breadcrumbs/setBreadcrumbs'
    }),
    async submitEdit () {
      this.loading = true
      const formData = new FormData()
      formData.append('user[name]', this.name)
      formData.append('user[introduction]', this.introduction)
      if (this.editAvatar) {
        formData.append('user[avatar]', this.editAvatar)
      }
      if (this.editCoverImage) {
        formData.append('user[cover_image]', this.editCoverImage)
      }
      await this.$axios.patch(`/api/v1/users/${this.currentUser.id}`, formData)
        .then((res) => {
          this.updateCurrentUser(res.data)
          this.flashMessage({ message: 'プロフィールを更新しました', type: 'success', status: true })
          this.$router.push(`/users/${this.currentUser.id}`)
          this.loading = false
        })
        .catch((err) => {
          this.flashMessage({ message: err, type: 'error', status: true })
          this.loading = false
        })
    },
    toHome () {
      this.flashMessage({ message: 'ゲストユーザーのため変更できません', type: 'success', status: true })
      this.$router.push(`/homes/${this.currentUser.id}`)
    }
  }
}
</script>
