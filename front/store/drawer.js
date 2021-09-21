export const state = () => ({
  drawer: ''
})

export const getters = {
  drawer (state) {
    return state.drawer
  }
}

export const mutations = {
  setDrawer (state, payload) {
    state.drawer = payload
  }
}

export const actions = {
  setDrawer ({ commit }, bool) {
    commit('setDrawer', bool)
  }
}
