import firebase from '~/plugins/firebase.js'

export default function () {
  firebase.auth().onAuthStateChanged((user) => {
  })
}
