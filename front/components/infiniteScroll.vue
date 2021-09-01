<template>
  <infinite-loading
    ref="infiniteLoading"
    spinner="bubbles"
    @infinite="infiniteHandler"
  >
    {{ count }}
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
    posts: {
      type: Array,
      required: true
    }
  },
  data () {
    return {
      page: 1
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
      const url = 'api/v1/posts'
      this.$axios.get(url, { params: { page: this.page } })
        .then((res) => {
          setTimeout(() => {
            if (this.page <= res.data.kaminari.pagenation.pages) {
              this.page++
              this.$refs.infiniteLoading.stateChanger.loaded()
            } else {
              this.$refs.infiniteLoading.stateChanger.complete()
            }
          }, 1000)
        })
    },
    fetchPosts () {
      this.$emit('fetchPosts')
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
