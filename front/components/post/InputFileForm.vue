<template>
  <v-file-input
    accept="image/png, image/jpeg, image/bmp"
    :label="label"
    class="pa-0 mx-3"
    prepend-icon="mdi-camera"
    small-chips
    @change="setImage"
  />
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  props: {
    label: {
      type: String,
      default: '画像を選択してください'
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data'
    })
  },
  methods: {
    // 画像を選択時に画像データをエンコード //
    setImage () {
      const pageEdit = this.$route.name === 'users-edit'
      const typeChange = event.type === 'change'
      const labelAvatar = this.$options.propsData.label === 'プロフィール画像を選択してください'
      const labelCoverImage = this.$options.propsData.label === 'カバー画像を選択してください'
      if (!pageEdit && !typeChange) {
        this.setImageInPreview('')
        return
      } else if (!pageEdit && !event.target.files.length) {
        this.setImageInPreview('')
        return
      } else if (pageEdit && !typeChange && labelAvatar) {
        this.setImageInPreview(this.currentUser.avatar.url)
        return
      } else if (pageEdit && !typeChange && labelCoverImage) {
        this.setImageInPreview(this.currentUser.cover_image.url)
        return
      } else if (pageEdit && !event.target.files.length && labelAvatar) {
        this.setImageInPreview(this.currentUser.avatar.url)
        return
      } else if (pageEdit && !event.target.files.length && labelCoverImage) {
        this.setImageInPreview(this.currentUser.cover_image.url)
        return
      }
      this.setImageInPostImage(event.target.files[0])
      this.setImageInPreview(URL.createObjectURL(event.target.files[0]))
    },
    setImageInPreview (image) {
      this.$emit('setImageInPreview', image)
    },
    setImageInPostImage (image) {
      this.$emit('setImageInPostImage', image)
    }
  }
}
</script>
