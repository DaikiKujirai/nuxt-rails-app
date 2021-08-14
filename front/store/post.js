export const state = () => ({
  posts: []
})

export const getters = {
  posts (state) {
    return state.posts
  }
}

export const mutations = {
  setPosts (state, payload) {
    state.data = payload
  }
}

export const actions = {
  setPosts ({ commit, posts }) {
    commit('setPosts', posts)
  }
}
