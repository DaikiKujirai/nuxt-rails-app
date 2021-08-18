export const state = () => ({
  posts: [],
  post: {},
  user: {}
})

export const getters = {
  posts (state) {
    return state.posts
  },
  post (state) {
    return state.post
  },
  user (state) {
    return state.user
  }
}

export const mutations = {
  setPosts (state, payload) {
    state.posts = payload
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
  setPosts ({ commit }, posts) {
    commit('setPosts', posts)
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
