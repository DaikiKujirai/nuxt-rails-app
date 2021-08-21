export const state = () => ({
  color: 'deep-purple lighten-2'
})

export const getters = {
  color (state) {
    return state.color
  }
}
