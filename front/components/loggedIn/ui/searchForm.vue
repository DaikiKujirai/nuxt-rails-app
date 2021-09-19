<template>
  <div>
    <v-text-field
      v-model="content"
      dense
      prepend-inner-icon="mdi-magnify"
      placeholder="検索"
      outlined
      hide-details="false"
      rounded
      class="mx-15"
      @keypress.enter.exact="toSearch"
    />
  </div>
</template>

<script>
import { mapActions } from 'vuex'

export default {
  data () {
    return {
      content: ''
    }
  },
  methods: {
    ...mapActions({
      setSearchWord: 'search/setSearchWord',
      setFetchSearchContents: 'search/setFetchSearchContents',
      setSearchPageName: 'search/setSearchPageName'
    }),
    toSearch () {
      this.setSearchWord(this.content)
      if (this.$route.name === 'search') {
        this.setFetchSearchContents(true)
      } else {
        this.setSearchPageName(this.$route.name)
        this.$router.push('/search')
      }
    }
  }
}
</script>
