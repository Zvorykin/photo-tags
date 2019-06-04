import Vue from 'vue/dist/vue.esm'
import axios from 'axios'
import VueAxios from 'vue-axios'
// iView
// import iView from 'iview'
// import locale from 'iview/dist/locale/en-US'
// import 'iview/dist/styles/iview'
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

// import BootstrapVue from 'bootstrap-vue'
// Vue.use(BootstrapVue)
// import 'bootstrap/dist/css/bootstrap.css'
// import 'bootstrap-vue/dist/bootstrap-vue.css'

Vue.use(VueAxios, axios)
// Vue.use(iView, {
//   locale,
//   size: 'small',
// })


import './styles/quasar.styl'
import iconSet from 'quasar/icon-set/ionicons-v4.js'
import '@quasar/extras/ionicons-v4/ionicons-v4.css'
import {
  Quasar,
  QLayout,
  QHeader,
  QDrawer,
  QPageContainer,
  QPage,
  QToolbar,
  QToolbarTitle,
  QBtn,
  QIcon,
  QList,
  QItem,
  QItemSection,
  QItemLabel,
  QTable,
  QTh,
  QTr,
  QTd
} from 'quasar'

Vue.use(Quasar, {
  config: {},
  components: {
    QLayout,
    QHeader,
    QDrawer,
    QPageContainer,
    QPage,
    QToolbar,
    QToolbarTitle,
    QBtn,
    QIcon,
    QList,
    QItem,
    QItemSection,
    QItemLabel,
    QTable,
    QTh,
    QTr,
    QTd
  },
  directives: {
  },
  plugins: {
  },
  iconSet: iconSet
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
