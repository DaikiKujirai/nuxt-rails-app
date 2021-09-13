import firebase from '~/plugins/firebase.js'

export const state = () => ({
  chats: [],
  firstDisplayedChatsUser: {}
})

export const getters = {
  chats (state) {
    return state.chats
  },
  firstDisplayedChatsUser (state) {
    return state.firstDisplayedChatsUser
  }
}

export const mutations = {
  fetchChats (state, { chat }) {
    const isEmpty = state.chats.length === 0
    const isNotAdded = !state.chats.find(c => c.id === chat.id)

    if (isEmpty || isNotAdded) {
      state.chats.push(chat)
    }
  },
  clear (state) {
    state.chats = []
  },
  setFirstDisplayedChatsUser (state, payload) {
    state.firstDisplayedChatsUser = payload
  }
}

export const actions = {
  fetchChats ({ commit }, roomId) {
    return firebase.firestore()
      .collection('rooms')
      .doc(roomId)
      .collection('chats')
      .orderBy('createdAt', 'asc')
      .onSnapshot((chatsSnapShot) => {
        chatsSnapShot.docChanges().forEach((snapshot) => {
          const docData = snapshot.doc.data()
          const chat = {
            id: snapshot.doc.id,
            ...docData
          }
          commit('fetchChats', { chat })
        })
      })
  },
  clear ({ commit }) {
    commit('clear')
  },
  setFirstDisplayedChatsUser ({ commit }, user) {
    commit('setFirstDisplayedChatsUser', user)
  }
}
