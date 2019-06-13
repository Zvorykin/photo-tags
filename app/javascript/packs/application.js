import Vue from 'vue/dist/vue.esm'

// Axios
import axios from 'axios'
import VueAxios from 'vue-axios'
Vue.use(VueAxios, axios)

// Debounce
import { debounce } from "debounce"
Vue.prototype.$debounce = debounce

// Moment
import moment from 'moment'
moment.defaultFormat = 'YYYY-MM-DD HH:mm'
Vue.prototype.$moment = moment

// lib
import errorHandle from '../packs/lib/errorHandle'
Vue.prototype.$errorHandle = errorHandle
// import * as CONST from '../packs/lib/constants'
// Vue.prototype.$CONST = CONST
// import getConst from '../packs/lib/constantsPlugin'

// Quasar
import { Quasar } from 'quasar'
import quasarConf from './quasar'
Vue.use(Quasar, quasarConf)

Vue.prototype.$eventBus = new Vue()

Vue.config.productionTip = false
// import router from './router'

// App
import store from '../packs/store/index'
import App from '../App.vue'

/* eslint-disable no-new */
new Vue({
  components: { App },
  store,
  // router,
  template: '<App/>',
}).$mount('#app')
