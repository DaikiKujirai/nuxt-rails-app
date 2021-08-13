export default function ({ from, route, redirect }) {
  if (from.name === route.name) {
    return redirect('/posts')
  }
}
