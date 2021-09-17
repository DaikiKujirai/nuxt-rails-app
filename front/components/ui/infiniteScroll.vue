<template>
  <infinite-loading
    ref="infiniteLoading"
    spinner="bubbles"
    @infinite="infiniteHandler"
  >
    <div
      slot="no-results"
      class="mt-3"
    >
      <v-divider
        class="mb-2 mx-3"
      />
      データはありません
    </div>
  </infinite-loading>
</template>

<script>
export default {
  props: {
    page: {
      type: Number,
      required: true
    },
    url: {
      type: String,
      required: true
    },
    userId: {
      type: Number,
      default: 0
    },
    currentUserId: {
      type: Number,
      default: 0
    }
  },
  methods: {
    infiniteHandler () {
      this.pageIncrement()
      setTimeout(() => {
        this.$axios.get(this.url, {
          params: {
            page: this.page,
            user_id: this.userId,
            current_user_id: this.currentUserId
          }
        })
          .then((res) => {
            setTimeout(() => {
              if (this.page <= res.data.kaminari.pagination.pages) {
                this.pushContents(res)
                this.$refs.infiniteLoading.stateChanger.loaded()
              } else {
                this.$refs.infiniteLoading.stateChanger.complete()
              }
            }, 500)
          })
          .catch(() => {
            this.$refs.infiniteLoading.stateChanger.complete()
          })
      }, 500)
    },
    pageIncrement () {
      this.$emit('pageIncrement')
    },
    pushContents (res) {
      this.$emit('pushContents', res)
    }
  }
}
</script>

<style>
.infinite-scroll {
  display: flex;
  flex-direction: column;
  justify-content: center;
  width: 680px;
  margin: 100px 0;
}

.infinite-scroll-list-item {
  height: 60px;
  margin: 10px 0;
  border-bottom: 1px solid #eaeaea;
  padding-bottom: 10px;
}
</style>
