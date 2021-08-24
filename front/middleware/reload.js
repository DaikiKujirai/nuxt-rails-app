export default function ({ from, route, redirect }) {
  if (from.path === route.path) {
    return redirect('/posts')
  }
}
