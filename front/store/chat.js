import firebase from '~/plugins/firebase.js'

export const state = () => ({
  // chats: [],
  // displayedChatUser: {},
  // roomId: ''
  isSort: false
})

export const getters = {
  chats (state) {
    return state.chats
  },
  displayedChatUser (state) {
    return state.displayedChatUser
  },
  roomId (state) {
    return state.roomId
  },
  isSort (state) {
    return state.isSort
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
  setDisplayedChatUser (state, payload) {
    state.displayedChatUser = payload
  },
  setRoomId (state, payload) {
    state.roomId = payload
  },
  setIsSort (state, payload) {
    state.isSort = payload
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
  setDisplayedChatUser ({ commit }, user) {
    commit('setDisplayedChatUser', user)
  },
  setRoomId ({ commit }, {
    currentUserUid,
    otherUserUid
  }) {
    otherUserUid > currentUserUid
      ? (commit('setRoomId', otherUserUid + '-' + currentUserUid))
      : (commit('setRoomId', currentUserUid + '-' + otherUserUid))
  },
  setIsSort ({ commit }, bool) {
    commit('setIsSort', bool)
  }
}
