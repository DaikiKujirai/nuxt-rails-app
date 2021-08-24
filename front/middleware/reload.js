export default function ({ from, route, redirect }) {
  console.log(from, route)
  if (from.path === route.path) {
    return redirect('/')
  }
}
