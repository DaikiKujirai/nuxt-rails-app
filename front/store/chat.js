export const state = () => ({
  isUpdate: {},
  isCatchMessage: {},
  isExistsUnreadChat: false
})

export const getters = {
  isUpdate (state) {
    return state.isUpdate
  },
  isCatchMessage (state) {
    return state.isCatchMessage
  },
  isExistsUnreadChat (state) {
    return state.isExistsUnreadChat
  }
}

export const mutations = {
  setIsUpdate (state, payload) {
    state.isUpdate = payload
  },
  setIsCatchMessage (state, payload) {
    state.isCatchMessage = payload
  },
  setIsExistsUnreadChat (state, payload) {
    state.isExistsUnreadChat = payload
  }
}

export const actions = {
  setIsUpdate ({ commit }, { bool, userId }) {
    commit('setIsUpdate', { bool, userId })
  },
  setIsCatchMessage ({ commit }, { bool, userId }) {
    commit('setIsCatchMessage', { bool, userId })
  },
  setIsExistsUnreadChat ({ commit }, bool) {
    commit('setIsExistsUnreadChat', bool)
  }
}
