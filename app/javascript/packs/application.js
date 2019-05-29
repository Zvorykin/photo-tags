import Vue from 'vue/dist/vue.esm'
import axios from 'axios'
import VueAxios from 'vue-axios'
// iView
import iView from 'iview'
import locale from 'iview/dist/locale/en-US'
import 'iview/dist/styles/iview'
// Moment
// import moment from 'moment'
//
// App
import store from '../packs/store/index'
import App from '../App.vue'
// lib
import errorHandle from '../packs/lib/errorHandle'
// import showMessage from '../packs/lib/notification'
// import * as constants from '../packs/lib/constants'
// import getConst from '../packs/lib/constantsPlugin'

Vue.use(VueAxios, axios)
Vue.use(iView, {
  locale,
  size: 'small',
})

Vue.prototype.$eventBus = new Vue()
Vue.prototype.$errorHandle = errorHandle
// Vue.prototype.$showMessage = showMessage
// Vue.prototype.$moment = moment
// Vue.prototype.$FORMATS = constants.FORMATS

Vue.config.productionTip = false

/* eslint-disable no-new */
new Vue({
  components: { App },
  store,
  template: '<App/>',
}).$mount('#app')
