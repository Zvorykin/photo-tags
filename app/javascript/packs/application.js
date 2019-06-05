import Vue from 'vue/dist/vue.esm'

import VueRouter from 'vue-router'
Vue.use(VueRouter)

import axios from 'axios'
import VueAxios from 'vue-axios'
Vue.use(VueAxios, axios)

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

import './styles/quasar.styl'
import iconSet from 'quasar/icon-set/ionicons-v4.js'
import '@quasar/extras/ionicons-v4/ionicons-v4.css'
import {
  Quasar,
  ClosePopup,
  QLayout,
  QDrawer,
  QPageContainer,
  QPage,
  QBtn,
  QTable,
  QTh,
  QTr,
  QTd,
  QSpace,
  QTabs,
  QTab,
  QTabPanels,
  QTabPanel,
  QDialog,
  QInput,
  QCard
} from 'quasar'

Vue.use(Quasar, {
  config: {},
  components: {
    QLayout,
    QDrawer,
    QPageContainer,
    QPage,
    QBtn,
    QTable,
    QTh,
    QTr,
    QTd,
    QSpace,
    QTabs,
    QTab,
    QTabPanels,
    QTabPanel,
    QInput,
    QDialog,
    QCard
  },
  directives: {
    ClosePopup
  },
  plugins: {},
  iconSet: iconSet,
})

import router from './router'

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
  router,
  template: '<App/>',
}).$mount('#app')
