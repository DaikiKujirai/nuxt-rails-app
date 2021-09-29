import Push from 'push.js'

export const state = () => ({
  isActive: false
})

export const getters = {
  isActive (state) {
    return state.isActive
  }
}

export const mutations = {
  setIsActive (state, payload) {
    state.isActive = payload
  }
}

export const actions = {
  setIsActive ({ commit }, bool) {
    commit('setIsActive', bool)
  },
  pushNotification ({ commit }, notification) {
    let message = ''
    console.log(notification)
    switch (notification.category) {
      case 'chat':
        message = `${notification.user_name}さんからチャットが届きました`
        break
      case 'comment':
        notification.notification_data.post_id === 0
          ? (message = `あなたの投稿に${notification.user_name}さんからコメントが届きました`)
          : (message = `あなたのコメントに${notification.user_name}さんからコメントが届きました`)
        break
      case 'follow':
        message = `${notification.user_name}さんからフォローされました`
        break
      case 'like':
        notification.notification_data.post_id === 0
          ? (message = `あなたの投稿が${notification.user_name}さんにいいねされました`)
          : (message = `あなたのコメントが${notification.user_name}さんにいいねされました`)
        break
    }

    Push.create('nuxt-rails-app', {
      body: message,
      onClick () {
        window.focus()
        this.close()
      }
    })
  }
}
