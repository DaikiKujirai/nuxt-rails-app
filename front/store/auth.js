import firebase from '~/plugins/firebase.js'

export const state = () => ({
  user: null,
  data: null
})

export const getters = {
  user (state) {
    return state.user
  },
  data (state) {
    return state.data
  },
  isAuthenticated (state) {
    return !!state.user
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
    await this.$axios.$get(`/api/v1/find_login_user/${payload}`)
      .then((res) => {
        commit('setData', res)
      })
      .catch((err) => {
        // eslint-disable-next-line no-console
        console.log(err)
      })
  },

  updateCurrentUser ({ commit }, user) {
    commit('setData', user)
  },

  logout ({ commit }) {
    firebase.auth().signOut()
      .then(() => {
        this.$router.push('/posts')
        commit('setUser', null)
        commit('setData', null)
      })
      .catch((err) => {
        // eslint-disable-next-line no-console
        console.error(err)
      })
  }
}
