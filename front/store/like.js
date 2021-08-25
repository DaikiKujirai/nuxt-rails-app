export const state = () => ({
  likes: [],
  likePostIds: [],
  likeCommentIds: []
})

export const getters = {
  likes (state) {
    return state.likes
  },
  likePostIds (state) {
    return state.likePostIds
  },
  likeCommentIds (state) {
    return state.likeCommentIds
  }
}

export const mutations = {
  setLikes (state, payload) {
    state.likes = payload
  },
  setLikePostIds (state, payload) {
    state.likePostIds = payload
  },
  setLikeCommentIds (state, payload) {
    state.likeCommentIds = payload
  }
}

export const actions = {
  setLikes ({ commit, dispatch }, likes) {
    console.log(likes)
    commit('setLikes', likes)
    dispatch('setLikePostIds', likes)
    dispatch('setLikeCommentIds', likes)
  },
  setLikePostIds ({ commit }, likes) {
    const ids = []
    for (let i = 0; i < likes.length; i++) {
      if (likes[i].likeable_type === 'post') {
        ids.push(likes[i].likeable_id)
      }
    }
    console.log(ids)
    commit('setLikePostIds', ids)
  },
  setLikeCommentIds ({ commit }, likes) {
    const ids = []
    for (let i = 0; i < likes.length; i++) {
      if (likes[i].likeable_type === 'comment') {
        ids.push(likes[i].likeable_id)
      }
    }
    console.log(ids)
    commit('setLikeCommentIds', ids)
  }
}
