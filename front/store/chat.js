import firebase from '~/plugins/firebase.js'

export const state = () => ({
  chats: [],
  messageRecipientUser: {}
})

export const getters = {
  chats (state) {
    return state.chats
  },
  messageRecipientUser (state) {
    return state.messageRecipientUser
  }
}

export const mutations = {
  add (state, { chat }) {
    const isEmpty = state.chats.length === 0
    const isNotAdded = !state.chats.find(c => c.id === chat.id)

    if (isEmpty || isNotAdded) {
      state.chats.push(chat)
    }
  },

  update (state, { chat }) {
    state.chats = state.chats.map((c) => {
      if (c.id === chat.id) {
        c = chat
      }
      return c
    })
  },

  remove (state, { chat }) {
    state.chats = state.chats.filter(c => c.id !== chat.id)
  },

  clear (state) {
    state.chats = []
  },
  setMessageRecipientUser (state, payload) {
    state.setMessageRecipientUser = payload
  }
}

export const actions = {
  subscribe ({ commit }, { roomId }) {
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

          switch (snapshot.type) {
            case 'added':
              commit('add', { chat })
              break

            case 'modified':
              commit('update', { chat })
              break

            case 'removed':
              commit('remove', { chat })
              break
          }
        })
      })
  },

  clear ({ commit }) {
    commit('clear')
  },

  setMessageRecipientUser ({ commit }, user) {
    commit('setMessageRecipientUser', user)
  }
}
