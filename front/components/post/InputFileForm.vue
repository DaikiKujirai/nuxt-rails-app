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
export default {
  props: {
    label: {
      type: String,
      default: '画像を選択してください'
    }
  },
  methods: {
    setImage (e) {
      this.setImageInPostImage(e)
    },
    // 画像を選択時に画像データをエンコード //
    // async setImage (event) {
    //   if (!event.target.files) {
    //     this.setImageInPostImage('')
    //     this.setImageInPreview('')
    //     return
    //   }
    //   this.setImageInPostImage(event)
    //   const images = event.target.files || event.dataTransfer.files
    //   // this.setImageInPostImage(event.target.files[0].name)
    //   await this.getBase64(images[0])
    //     .then((res) => {
    //       const originalImg = new Image()
    //       originalImg.src = res
    //       originalImg.onload = () => {
    //         const resizedCanvas = this.createResizedCanvasElement(originalImg)
    //         const resizedBase64 = resizedCanvas.toDataURL(images[0].type)
    //         this.setImageInPreview(resizedBase64)
    //       }
    //     })
    //     .catch((err) => {
    //       // eslint-disable-next-line no-console
    //       console.error(err)
    //     })
    // },
    // getBase64 (file) {
    //   return new Promise((resolve, reject) => {
    //     const reader = new FileReader()
    //     reader.readAsDataURL(file)
    //     reader.onload = () => resolve(reader.result)
    //     reader.onerror = error => reject(error)
    //   })
    // },
    // // 画像データをリサイズ //
    // createResizedCanvasElement (originalImg) {
    //   const originalImgWidth = originalImg.width
    //   const originalImgHeight = originalImg.height
    //   const [resizedWidth, resizedHeight] = this.resizeWidthAndHeight(originalImgWidth, originalImgHeight)
    //   const canvas = document.createElement('canvas')
    //   const ctx = canvas.getContext('2d')
    //   canvas.width = resizedWidth
    //   canvas.height = resizedHeight
    //   ctx.drawImage(originalImg, 0, 0, resizedWidth, resizedHeight)
    //   return canvas
    // },
    // resizeWidthAndHeight (width, height) {
    //   const MAX_HEIGHT = 150
    //   const MAX_WIDTH = 150
    //   if (width > height) {
    //     if (width > MAX_WIDTH) {
    //       height *= MAX_WIDTH / width
    //       width = MAX_WIDTH
    //     }
    //   } else {
    //     // eslint-disable-next-line no-lonely-if
    //     if (height > MAX_HEIGHT) {
    //       width *= MAX_HEIGHT / height
    //       height = MAX_HEIGHT
    //     }
    //   }
    //   return [width, height]
    setImageInPreview (image) {
      this.$emit('setImageInPreview', image)
    },
    setImageInPostImage (image) {
      this.$emit('setImageInPostImage', image)
    },
    changeImage (image) {
      this.$emit('changeImage', image)
    }
  }
}
</script>
