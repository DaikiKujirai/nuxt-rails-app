export const state = () => ({
  isUpdate: {}
})

export const getters = {
  isUpdate (state) {
    return state.isUpdate
  }
}

export const mutations = {
  setIsUpdate (state, payload) {
    state.isUpdate = payload
  }
}

export const actions = {
  setIsUpdate ({ commit }, { bool, userId }) {
    commit('setIsUpdate', { bool, userId })
  }
}
