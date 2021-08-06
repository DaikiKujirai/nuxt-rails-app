import firebase from '~/plugins/firebase'

export const state = () => ({
  loggedIn: false,
  current: {
    post: null
  }
})

export const getters = {}

export const mutations = {
  setLoggedIn (state, payload) {
    state.loggedIn = payload
  }
}

export const actions = {
  // login ({ commit }) {
  //   console.log(commit)
  //   commit('setLoggedIn', true)
  // },
  // logout ({ commit }) {
  //   commit('setLoggedIn', false)
  // }
  login () {
    console.log('login action')
    const provider = new firebase.auth.GoogleAuthProvider()
    firebase.auth().signInWithPopup(provider)
      .then((result) => {
        const user = result.user
        console.log('success：' + user)
      })
      .catch((err) => {
        console.log('error' + err.code)
      })
  }
}
