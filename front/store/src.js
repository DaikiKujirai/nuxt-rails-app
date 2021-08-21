export const state = () => ({
  src: 'https://picsum.photos/200/200'
})

export const getters = {
  color (state) {
    return state.src
  }
}
