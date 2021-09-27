export const state = () => ({
  isNewPost: false,
  isNewComment: false,
  updatePost: { bool: false, post: {} },
  deletePost: { bool: false, post: {} }
})

export const getters = {
  isNewPost (state) {
    return state.isNewPost
  },
  isNewComment (state) {
    return state.isNewComment
  },
  updatePost (state) {
    return state.updatePost
  },
  deletePost (state) {
    return state.deletePost
  }
}

export const mutations = {
  setIsNewPost (state, payload) {
    state.isNewPost = payload
  },
  setIsNewComment (state, payload) {
    state.isNewComment = payload
  },
  setUpdatePost (state, payload) {
    state.updatePost = payload
  },
  setDeletePost (state, payload) {
    state.deletePost = payload
  }
}

export const actions = {
  setIsNewPost ({ commit }, bool) {
    commit('setIsNewPost', bool)
  },
  setIsNewComment ({ commit }, bool) {
    commit('setIsNewComment', bool)
  },
  setUpdatePost ({ commit }, { bool, post }) {
    commit('setUpdatePost', { bool, post })
  },
  setDeletePost ({ commit }, { bool, post }) {
    commit('setDeletePost', { bool, post })
  }
}
