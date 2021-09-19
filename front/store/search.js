export const state = () => ({
  searchWord: ''
})

export const getters = {
  searchWord (state) {
    return state.searchWord
  }
}

export const mutations = {
  setSearchWord (state, payload) {
    state.searchWord = payload
  }
}

export const actions = {
  setSearchWord ({ commit }, searchWord) {
    commit('setSearchWord', searchWord)
  }
}
