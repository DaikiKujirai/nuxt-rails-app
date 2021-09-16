export const state = () => ({
  isPost: false,
  commentsCountPagePostId: 0,
  updatePost: { bool: false, post: {} }
})

export const getters = {
  isPost (state) {
    return state.isPost
  },
  commentsCountPagePostId (state) {
    return state.commentsCountPagePostId
  },
  updatePost (state) {
    return state.updatePost
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
  },
  setUpdatePost (state, payload) {
    state.updatePost = payload
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
  },
  setUpdatePost ({ commit }, { bool, post }) {
    commit('setUpdatePost', { bool, post })
  }
}
