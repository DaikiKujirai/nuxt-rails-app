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
    async setImage () {
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> a464482 ([add] edit_profile)
      const pageEdit = this.$route.name === 'users-edit'
      const typeChange = event.type === 'change'
      const labelAvatar = this.$options.propsData.label === 'プロフィール画像を選択してください'
      const labelCoverImage = this.$options.propsData.label === 'カバー画像を選択してください'
      if (!pageEdit && !typeChange) {
<<<<<<< HEAD
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
=======
      if (event.type !== 'change') {
=======
>>>>>>> a464482 ([add] edit_profile)
        this.setImageInPreview('')
        return
      } else if (!pageEdit && !event.target.files.length) {
        this.setImageInPreview('')
        return
<<<<<<< HEAD
>>>>>>> af3e88e ([fix] S3)
=======
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
>>>>>>> a464482 ([add] edit_profile)
      }
      const images = event.target.files || event.dataTransfer.files
      this.setImageInPostImage(event.target.files[0])
      await this.getBase64(images[0])
        .then((res) => {
          const originalImg = new Image()
          originalImg.src = res
          originalImg.onload = () => {
            const resizedCanvas = this.createResizedCanvasElement(originalImg)
            const resizedBase64 = resizedCanvas.toDataURL(images[0].type)
            this.setImageInPreview(resizedBase64)
          }
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    getBase64 (file) {
      return new Promise((resolve, reject) => {
        const reader = new FileReader()
        reader.readAsDataURL(file)
        reader.onload = () => resolve(reader.result)
        reader.onerror = error => reject(error)
      })
    },
    // 画像データをリサイズ //
    createResizedCanvasElement (originalImg) {
      const originalImgWidth = originalImg.width
      const originalImgHeight = originalImg.height
      const [resizedWidth, resizedHeight] = this.resizeWidthAndHeight(originalImgWidth, originalImgHeight)
      const canvas = document.createElement('canvas')
      const ctx = canvas.getContext('2d')
      canvas.width = resizedWidth
      canvas.height = resizedHeight
      ctx.drawImage(originalImg, 0, 0, resizedWidth, resizedHeight)
      return canvas
    },
    resizeWidthAndHeight (width, height) {
      const MAX_HEIGHT = 400
      const MAX_WIDTH = 400
      if (width > height) {
        if (width > MAX_WIDTH) {
          height *= MAX_WIDTH / width
          width = MAX_WIDTH
        }
      } else {
        // eslint-disable-next-line no-lonely-if
        if (height > MAX_HEIGHT) {
          width *= MAX_HEIGHT / height
          height = MAX_HEIGHT
        }
      }
      return [width, height]
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
