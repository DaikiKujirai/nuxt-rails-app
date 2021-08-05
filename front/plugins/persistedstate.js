import createPersistedState from 'vuex-persistedstate'

export default ({ store, isHMR }) => {
  if (isHMR) return // eslint-disable-line

  if (process.client) {
    window.onNuxtReady((nuxt) => {
      createPersistedState()(store) // vuex plugins can be connected to store, even after creation
    })
  }
}
