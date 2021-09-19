export const state = () => ({
  searchWord: '',
  fetchSearchContents: false,
  searchPageName: ''
})

export const getters = {
  searchWord (state) {
    return state.searchWord
  },
  fetchSearchContents (state) {
    return state.fetchSearchContents
  },
  searchPageName (state) {
    return state.searchPageName
  }
}

export const mutations = {
  setSearchWord (state, payload) {
    state.searchWord = payload
  },
  setFetchSearchContents (state, payload) {
    state.fetchSearchContents = payload
  },
  setSearchPageName (state, payload) {
    state.searchPageName = payload
  }
}

export const actions = {
  setSearchWord ({ commit }, searchWord) {
    commit('setSearchWord', searchWord)
  },
  setFetchSearchContents ({ commit }, bool) {
    commit('setFetchSearchContents', bool)
  },
  setSearchPageName ({ commit }, pageName) {
    commit('setSearchPageName', pageName)
  }
}
