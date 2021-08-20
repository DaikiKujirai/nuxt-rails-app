export const state = () => ({
  comments: [],
  comment: {},
  post: {},
  user: {}
})

export const getters = {
  comments (state) {
    return state.comments
  },
  comment (state) {
    return state.comment
  },
  post (state) {
    return state.post
  },
  user (state) {
    return state.user
  }
}

export const mutations = {
  setComments (state, payload) {
    state.comments = payload
  },
  setComment (state, payload) {
    state.comment = payload
  },
  setPost (state, payload) {
    state.post = payload
  },
  setUser (state, payload) {
    state.user = payload
  }
}

export const actions = {
  setComments ({ commit }, comments) {
    commit('setComments', comments)
  },
  setComment ({ commit }, comment) {
    commit('setComment', comment)
  },
  setPost ({ commit }, post) {
    commit('setPost', post)
  },
  setUser ({ commit }, user) {
    commit('setUser', user)
  }
}
