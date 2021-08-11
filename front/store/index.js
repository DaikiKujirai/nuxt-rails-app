// import firebase from '~/plugins/firebase'

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
  login ({ commit }) {
    console.log(commit)
    commit('setLoggedIn', true)
  },
  logout ({ commit }) {
    commit('setLoggedIn', false)
  }
  // signup () {
  //   firebase.auth().createUserWithEmailAndPassword(email, password)
  //     .then((userCredential) => {
  //       // Signed in
  //       const user = userCredential.user
  //     })
  //     .catch((error) => {
  //       console.log('サインアップエラー', error.code)
  //       console.log(error.message)
  //       // ..
  //     })
  // },
  // login () {
  //   console.log('login action')
  //   const provider = new firebase.auth.GoogleAuthProvider()
  //   firebase.auth().signInWithPopup(provider)
  //     .then((result) => {
  //       const user = result.user
  //       console.log('success：' + user)
  //     })
  //     .catch((err) => {
  //       console.log('error' + err.code)
  //     })
  // firebase.auth().signInWithEmailAndPassword(email, password)
  //   .then((userCredential) => {
  //   })
  //   .catch(() => {
  //     console.log('ログインエラー')
  //   })
  // }
}
