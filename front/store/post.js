export const state = () => ({
  isPost: false,
  commentsCountPagePostId: 0
})

export const getters = {
  isPost (state) {
    return state.isPost
  },
  commentsCountPagePostId (state) {
    return state.commentsCountPagePostId
  }
}

export const mutations = {
  setIsPost (state, payload) {
    state.isPost = payload
  },
  setCommentsCountPagePostId (state, payload) {
    state.commentsCountPagePostId = payload
  },
  commentsCountPagePostIdIncrement (state) {
    state.commentsCountPagePostId++
  },
  commentsCountPagePostIdDecrement (state) {
    state.commentsCountPagePostId--
  }
}

export const actions = {
  setIsPost ({ commit }, bool) {
    commit('setIsPost', bool)
  },
  setCommentsCountPagePostId ({ commit }, comment) {
    commit('setCommentsCountPagePostId', comment)
  },
  commentsCountPagePostIdIncrement ({ commit }, comment) {
    commit('commentsCountPagePostIdIncrement', comment)
  },
  commentsCountPagePostIdDecrement ({ commit }) {
    commit('commentsCountPagePostIdDecrement')
  }
}
