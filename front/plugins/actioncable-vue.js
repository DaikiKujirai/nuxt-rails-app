import Vue from 'vue'
import ActionCableVue from 'actioncable-vue'

if (process.client) {
  Vue.use(ActionCableVue, {
    debug: true,
    debugLevel: 'error',
    connectionUrl: 'ws://localhost:3000/cable',
    connectImmediately: true
  })
}
