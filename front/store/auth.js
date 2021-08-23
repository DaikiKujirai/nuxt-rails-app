import firebase from '~/plugins/firebase.js'

export const state = () => ({
  user: null,
  data: null
})

export const getters = {
  user (state) {
    return state.user
  },
  isAuthenticated (state) {
    return !!state.user && !!state.user.uid
  },
  data (state) {
    return state.data
  }
}

export const mutations = {
  setData (state, payload) {
    state.data = payload
  },
  setUser (state, payload) {
    state.user = payload
  }
}

export const actions = {
  async login ({ dispatch }, user) {
    const userInfo = { email: user.email, uid: user.uid }
    await dispatch('setUser', userInfo)
    await dispatch('loadData', userInfo.uid)
  },

  setUser ({ commit }, user) {
    commit('setUser', user)
  },

  async loadData ({ commit }, payload) {
    try {
      const data = await this.$axios.$get(`/api/v1/find_login_user/${payload}`)
      commit('setData', data)
    } catch (err) {
      // eslint-disable-next-line no-console
      console.log(err)
    }
  },

  async logout ({ commit }) {
    await firebase.auth().signOut()
      .then(() => {
        commit('setUser', null)
        commit('setData', null)
      })
  }
}
