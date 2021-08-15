export const state = () => ({
  toast: {
    msg: null,
    color: 'error',
    timeout: 4000
  }
})

export const getters = {
}

export const mutations = {
  setToast (state, payload) {
    state.toast = payload
  }
}

export const actions = {

  getToast ({ commit }, toast) {
    toast.color = toast.color || 'error'
    toast.timeout = toast.timeout || 4000
    commit('setToast', toast)
  },

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
