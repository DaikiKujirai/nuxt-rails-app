export const state = () => ({
  isUpdate: {},
  isCatchMessage: false
})

export const getters = {
  isUpdate (state) {
    return state.isUpdate
  },
  isCatchMessage (state) {
    return state.isCatchMessage
  }
}

export const mutations = {
  setIsUpdate (state, payload) {
    state.isUpdate = payload
  },
  setIsCatchMessage (state, payload) {
    state.isCatchMessage = payload
  }
}

export const actions = {
  setIsUpdate ({ commit }, { bool, userId }) {
    commit('setIsUpdate', { bool, userId })
  },
  setIsCatchMessage ({ commit }, bool) {
    commit('setIsCatchMessage', bool)
  }
}
