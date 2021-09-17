export const state = () => ({
  breadcrumbs: ''
})

export const getters = {
  breadcrumbs (state) {
    return state.breadcrumbs
  }
}

export const mutations = {
  setBreadcrumbs (state, payload) {
    state.breadcrumbs = payload
  }
}

export const actions = {
  setBreadcrumbs ({ commit }, breadcrumbs) {
    commit('setBreadcrumbs', breadcrumbs)
  }
}
