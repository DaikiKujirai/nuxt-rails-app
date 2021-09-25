export const state = () => ({
  myChannel: null
})

export const getters = {
  myChannel (state) {
    return state.myChannel
  }
}

export const mutations = {
  setMyChannel (state, payload) {
    state.myChannel = payload
  }
}

export const actions = {
  async subscribe (userUid) {
    await this.$cable.subscribe({
      channel: 'RoomChannel',
      room: userUid,
      uid: userUid
    })
  }
}
