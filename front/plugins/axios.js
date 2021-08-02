export default ({ $axios }) => {
  // リクエストログ
  $axios.onRequest((config) => {
    console.log(config, 'リク')
  })
  // レスポンスログ
  $axios.onResponse((config) => {
    console.log(config, 'レス')
  })
  // エラーログ
  $axios.onError((e) => {
    console.log(e.response, 'エラー')
  })
}
