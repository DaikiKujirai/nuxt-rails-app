<template>
  <div>
    <v-text-field
      v-model="content"
      clearable
      dense
      prepend-inner-icon="mdi-magnify"
      placeholder="検索"
      outlined
      hide-details="false"
      rounded
      class="mx-15"
      @keypress.enter.exact="toSearch"
    />
    {{ content }}
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
      setSearchWord: 'search/setSearchWord'
    }),
    toSearch () {
      this.setSearchWord(this.content)
      this.$router.push('/search')
    }
  }
}
</script>
