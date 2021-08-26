export const state = () => ({
  likePosts: [],
  likeComments: [],
  likePostIds: [],
  likeCommentIds: []
})

export const getters = {
  likePosts (state) {
    return state.likePosts
  },
  likeComments (state) {
    return state.likeComments
  },
  likePostIds (state) {
    return state.likePostIds
  },
  likeCommentIds (state) {
    return state.likeCommentIds
  }
}

export const mutations = {
  setLikePosts (state, payload) {
    state.likePosts = payload
  },
  setLikeComments (state, payload) {
    state.likeComments = payload
  },
  setLikePostIds (state, payload) {
    state.likePostIds = payload
  },
  setLikeCommentIds (state, payload) {
    state.likeCommentIds = payload
  }
}

export const actions = {
  setLikePosts ({ dispatch, commit }, likePosts) {
    commit('setLikePosts', likePosts)
    dispatch('setLikePostIds', likePosts)
  },
  setLikeComments ({ dispatch, commit }, likeComments) {
    commit('setLikeComments', likeComments)
    dispatch('setLikeCommentIds', likeComments)
  },
  setLikePostIds ({ commit }, likePosts) {
    const ids = []
    for (let i = 0; i < likePosts.length; i++) {
      ids.push(likePosts[i].post_id)
    }
    commit('setLikePostIds', ids)
  },
  setLikeCommentIds ({ commit }, likeComments) {
    const ids = []
    for (let i = 0; i < likeComments.length; i++) {
      ids.push(likeComments[i].comment_id)
    }
    commit('setLikeCommentIds', ids)
  }
}
