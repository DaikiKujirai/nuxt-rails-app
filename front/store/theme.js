export const state = () => ({
  theme: false
})

export const getters = {
  theme (state) {
    return state.theme
  }
}

export const mutations = {
  setTheme (state, payload) {
    state.theme = payload
  }
}

export const actions = {
  setTheme ({ commit }, bool) {
    commit('setTheme', bool)
  }
}
