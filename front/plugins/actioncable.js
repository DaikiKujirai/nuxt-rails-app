// import ActionCable from 'actioncable'

// export default {
//   data () {
//     return {
//       messageText: ''
//     }
//   },
//   created () {
//     const cable = ActionCable.createConsumer('ws://localhost:/cable')

//     this.messageChannel = cable.subscriptions.create('RoomChannel', {
//       receiced: (data) => {
//         this.$store.commit('addMessage', data)
//       }
//     })
//   },
//   methods: {
//     handleClick () {
//       this.noticeChannel.perfrom('post', {
//         message: this.messageText
//       })
//       this.messageText = ''
//     }
//   }
// }

import Vue from 'vue'
import ActionCable from 'actioncable'

const cable = ActionCable.createConsumer('ws:localhost:3000/cable')
Vue.prototype.$cable = cable
