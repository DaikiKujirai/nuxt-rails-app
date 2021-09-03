export const state = () => ({
  likesCountPagePostId: 0
})

export const getters = {
  likesCountPagePostId (state) {
    return state.likesCountPagePostId
  }
}

export const mutations = {
  setLikesCountPagePostId (state, payload) {
    state.likesCountPagePostId = payload
  },
  likesCountPagePostIdIncrement (state) {
    state.likesCountPagePostId++
  },
  likesCountPagePostIdDecrement (state) {
    state.likesCountPagePostId--
  }
}

export const actions = {
  setLikesCountPagePostId ({ commit }, likesCount) {
    commit('setLikesCountPagePostId', likesCount)
  },
  likesCountPagePostIdIncrement ({ commit }) {
    commit('likesCountPagePostIdIncrement')
  },
  likesCountPagePostIdDecrement ({ commit }) {
    commit('likesCountPagePostIdDecrement')
  }
}
