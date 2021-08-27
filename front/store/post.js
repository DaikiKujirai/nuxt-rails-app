export const state = () => ({
  posts: [],
  post: {}
})

export const getters = {
  posts (state) {
    return state.posts
  },
  post (state) {
    return state.post
  }
}

export const mutations = {
  setPosts (state, payload) {
    state.posts = payload
  },
  setPost (state, payload) {
    state.post = payload
  }
}

export const actions = {
  setPosts ({ commit }, posts) {
    commit('setPosts', posts)
  },
  setPost ({ commit }, post) {
    commit('setPost', post)
  }
}
