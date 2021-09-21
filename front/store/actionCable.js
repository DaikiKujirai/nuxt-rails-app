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
    console.log('mutations')
    state.myChannel = payload
  }
}

export const actions = {
  setMyChannel ({ commit }, channel) {
    // console.log(currentUserUid)
    // const cable = ActionCable.createConsumer('ws://localhost:3000/cable')
    // const channel = cable.subscriptions.create({
    //   channel: 'RoomChannel',
    //   uid: currentUserUid
    // }, {
    //   connected () {
    //     console.log('connected')
    //   },
    //   disconnected () {
    //     console.log('disconnected')
    //   },
    //   received (data) {
    //     console.log('received!!')
    //   }
    // })
    // console.log(channel)
    commit('setMyChannel', channel)
  }
}
