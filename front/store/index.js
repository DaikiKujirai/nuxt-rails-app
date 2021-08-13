export const actions = {
  nuxtClientInit ({ commit }) {
    if (localStorage.getItem('vuex')) {
      const data = JSON.parse(localStorage.getItem('vuex')) || []
      commit('flash/setStatus', false)
      if (data.user !== null) {
        commit('auth/setData', data.auth.data)
        commit('auth/setUser', data.auth.user)
      }
    }
  }
}
