export const state = () => ({
  followerCountPageUserId: 0
})

export const getters = {
  followerCountPageUserId (state) {
    return state.followerCountPageUserId
  }
}

export const mutations = {
  setFollowerCountPageUserId (state, payload) {
    state.followerCountPageUserId = payload
  },
  followerCountPageUserIdIncrement (state) {
    state.followerCountPageUserId++
  },
  followerCountPageUserIdDecrement (state) {
    state.followerCountPageUserId--
  }
}

export const actions = {
  setFollowerCountPageUserId ({ commit }, followerCount) {
    commit('setFollowerCountPageUserId', followerCount)
  },
  followerCountPageUserIdIncrement ({ commit }) {
    commit('followerCountPageUserIdIncrement')
  },
  followerCountPageUserIdDecrement ({ commit }) {
    commit('followerCountPageUserIdDecrement')
  }
}
