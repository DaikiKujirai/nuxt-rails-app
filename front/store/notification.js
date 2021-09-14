export const state = () => ({
  isActive: false
})

export const getters = {
  isActive (state) {
    return state.isActive
  }
}

export const mutations = {
  setIsActive (state, payload) {
    state.isActive = payload
  }
}

export const actions = {
  setIsActive ({ commit }, bool) {
    commit('setIsActive', bool)
  }
}
