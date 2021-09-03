export const state = () => ({
  posts: [],
  post: {},
  commentsCountPagePostId: 0
})

export const getters = {
  posts (state) {
    return state.posts
  },
  post (state) {
    return state.post
  },
  commentsCountPagePostId (state) {
    return state.commentsCountPagePostId
  }
}

export const mutations = {
  setPosts (state, payload) {
    state.posts = payload
  },
  setPost (state, payload) {
    state.post = payload
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
  setPosts ({ commit }, posts) {
    commit('setPosts', posts)
  },
  setPost ({ commit }, post) {
    commit('setPost', post)
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
