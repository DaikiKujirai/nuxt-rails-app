export const state = () => ({
  loggedIn: false,
  current: {
    post: null
  }
})

export const getters = {}

export const mutations = {
  setLoggedIn (state, payload) {
    state.loggedIn = payload
  }
}

export const actions = {
  login ({ commit }) {
    console.log(commit)
    commit('setLoggedIn', true)
  },
  logout ({ commit }) {
    commit('setLoggedIn', false)
  }
}
