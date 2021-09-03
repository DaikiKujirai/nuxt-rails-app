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
    }
  },
  data () {
    return {
    }
  },
  computed: {
    pagePosts () {
      return this.posts
    }
  },
  mounted () {
  },
  methods: {
    infiniteHandler () {
      this.pageIncrement()
      setTimeout(() => {
        this.$axios.get(this.url, { params: { page: this.page } })
          .then((res) => {
            setTimeout(() => {
              if (this.page <= res.data.kaminari.pagination.pages) {
                this.pushPosts(res)
                this.$refs.infiniteLoading.stateChanger.loaded()
              } else {
                this.$refs.infiniteLoading.stateChanger.complete()
              }
            })
          })
          .catch(() => {
            this.$refs.infiniteLoading.stateChanger.complete()
          })
      }, 1000)
    },
    pageIncrement () {
      this.$emit('pageIncrement')
    },
    pushPosts (res) {
      this.$emit('pushPosts', res)
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
