export const state = () => ({
  number: 0
})

export const getters = {
  testGetters (state) {
    return state.number
  }
}

export const mutations = {
  testMutation (state, payload) {
    state.number += payload
  }
}

export const actions = {
  async testAction ({ dispatch }, payload) {
    await dispatch('message', payload)
  },
  async message ({ commit }, payload) {
    await commit('testMutation', payload)
  }
}
