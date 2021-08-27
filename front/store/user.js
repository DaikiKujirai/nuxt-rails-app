export const state = () => ({
  users: [],
  user: {}
})

export const getters = {
  users (state) {
    return state.users
  },
  user (state) {
    return state.user
  }
}

export const mutations = {
  setUsers (state, payload) {
    state.users = payload
  },
  setUser (state, payload) {
    state.user = payload
  }
}

export const actions = {
  setUsers ({ commit }, users) {
    commit('setUsers', users)
  },
  setUser ({ commit }, user) {
    commit('setUser', user)
  }
}
