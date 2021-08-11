// import firebase from '~/plugins/firebase'

export const state = () => ({
  loggedIn: false
})

export const getters = {}

export const mutations = {
  setLoggedIn (state, payload) {
    state.loggedIn = payload
  }
}

export const actions = {
  login ({ commit }) {
    // eslint-disable-next-line no-console
    console.log(commit)
    commit('setLoggedIn', true)
  },
  logout ({ commit }) {
    commit('setLoggedIn', false)
  }
}
