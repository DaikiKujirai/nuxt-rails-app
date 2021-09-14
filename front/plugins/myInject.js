class MyInject {
  constructor (app) {
    this.app = app
  }

  format (date) {
    const dateTimeFormat = new Intl.DateTimeFormat(
      'ja', { dateStyle: 'medium', timeStyle: 'short' }
    )
    return dateTimeFormat.format(new Date(date))
  }

  postLinkTo (id, name = 'post-id-dashboard') {
    return { name, params: { id } }
  }

  pageTitle (routeName) {
    const jsonPath = `pages.${routeName.replace(/-/g, '.')}`
    const title = this.app.i18n.t(jsonPath)
    return (typeof (title) === 'object') ? title.index : title
  }

  action (action) {
    console.log(this.app.i18n.t('actions.comment'))
    return this.app.i18n.t(action)
  }
}

export default ({ app }, inject) => {
  inject('my', new MyInject(app))
}
