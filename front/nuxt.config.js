export default {
  // Disable server-side rendering: https://go.nuxtjs.dev/ssr-mode
  ssr: false,

  // Global page headers: https://go.nuxtjs.dev/config-head
  head: {
    title: 'app',
    htmlAttrs: {
      lang: 'en'
    },
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: '' },
      { name: 'format-detection', content: 'telephone=no' }
    ],
    link: [
      { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }
    ]
  },

  // Global CSS: https://go.nuxtjs.dev/config-css
  css: [
    '~/assets/sass/main.scss'
  ],

  // Plugins to run before rendering page: https://go.nuxtjs.dev/config-plugins
  plugins: [
    'plugins/axios',
    'plugins/myInject',
    '~/plugins/firebase.js',
    { src: '~plugins/persistedstate.js', ssr: false }
  ],

  // Auto import components: https://go.nuxtjs.dev/config-components
  components: true,

  // Modules for dev and build (recommended): https://go.nuxtjs.dev/config-modules
  buildModules: [
    // https://go.nuxtjs.dev/eslint
    '@nuxtjs/eslint-module',
    '@nuxtjs/vuetify'
  ],

  // Modules: https://go.nuxtjs.dev/config-modules
  modules: [
    // https://go.nuxtjs.dev/axios
    '@nuxtjs/axios',
    'nuxt-i18n',
    '@nuxtjs/dotenv'
  ],

  // Axios module configuration: https://go.nuxtjs.dev/config-axios
  axios: {},

  vuetify: {
    treeShake: true,
    customVariables: ['~/assets/sass/variables.scss'],
    theme: {
      themes: {
        light: {
          primary: '4080BE',
          info: '4FC1E9',
          success: '44D69E',
          warning: 'FEB65E',
          error: 'FB8678',
          background: 'f6f6f4'
        }
      }
    }
  },
  i18n: {
    locales: ['ja', 'en'],
    defaultLocale: 'ja',
    strategy: 'no_prefix',
    vueI18n: {
      fallbackLocale: 'ja',
      silentFallbackWarn: true,
      messages: {
        ja: require('./locales/ja.json'),
        en: require('./locales/en.json')
      }
    }
  },

  // Build Configuration: https://go.nuxtjs.dev/config-build
  build: {
  },
  publicRuntimeConfig: {
    appName: process.env.APP_NAME
  }
}
