export const state = () => ({
  comments: [],
  post: {},
  user: {}
})

export const getters = {
  comments (state) {
    return state.comments
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
  setPost (state, payload) {
    state.post = payload
  },
  setUser (state, payload) {
    state.user = payload
    // eslint-disable-next-line no-console
    console.log('mutations')
  }
}

export const actions = {
  setComments ({ commit }, comments) {
    commit('setComments', comments)
  },
  setPost ({ commit }, post) {
    commit('setPost', post)
  },
  setUser ({ commit }, user) {
    commit('setUser', user)
    // eslint-disable-next-line no-console
    console.log('actions')
  }
}
