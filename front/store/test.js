export const state = () => ({
  test: 0,
  gts: 0
})

export const getters = {
  testGetters (gts) {
    gts = 2
    return gts
  }
}

export const mutations = {
}

export const actions = {
}
