export const state = () => ({
  loggedIn: false,
  current: {
    post: null
  },
  posts: [
    { id: 6, title: 'title06', content: 'content06' },
    { id: 7, title: 'title07', content: 'content07' },
    { id: 8, title: 'title08', content: 'content08' },
    { id: 9, title: 'title09', content: 'content09' },
    { id: 10, title: 'title10', content: 'content10' }
  ]
})

export const getters = {}

export const mutations = {
  setLoggedIn (state, payload) {
    state.loggedIn = payload
  }
}

export const actions = {
  login ({ commit }) {
    commit('setLoggedIn', true)
  },
  logout ({ commit }) {
    commit('setLoggedIn', false)
  }
}
