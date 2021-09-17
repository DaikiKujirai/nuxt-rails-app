export const state = () => ({
  isNewPost: false,
  commentsCountPagePostId: 0,
  updatePost: { bool: false, post: {} },
  deletePost: { bool: false, post: {} }
})

export const getters = {
  isNewPost (state) {
    return state.isNewPost
  },
  commentsCountPagePostId (state) {
    return state.commentsCountPagePostId
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
  },
  setDeletePost (state, payload) {
    state.deletePost = payload
  }
}

export const actions = {
  setIsNewPost ({ commit }, bool) {
    commit('setIsNewPost', bool)
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
  },
  setDeletePost ({ commit }, { bool, post }) {
    commit('setDeletePost', { bool, post })
  }
}
