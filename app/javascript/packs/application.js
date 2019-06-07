import Vue from 'vue/dist/vue.esm'

// Axios
import axios from 'axios'
import VueAxios from 'vue-axios'
Vue.use(VueAxios, axios)

// Debounce
import { debounce } from "debounce"
Vue.prototype.$debounce = debounce

// Moment
// import moment from 'moment'
//

// lib
import errorHandle from '../packs/lib/errorHandle'
Vue.prototype.$errorHandle = errorHandle

// import showMessage from '../packs/lib/notification'
// import * as constants from '../packs/lib/constants'
// import getConst from '../packs/lib/constantsPlugin'

// Quasar
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
  QCard,
  QImg,
  QToolbar,
  QToolbarTitle,
  QIcon,
  QHeader,
  QFooter,
  QPagination
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
    QCard,
    QImg,
    QToolbar,
    QToolbarTitle,
    QIcon,
    QHeader,
    QFooter,
    QPagination
  },
  directives: {
    ClosePopup
  },
  plugins: {},
  iconSet: iconSet,
})

Vue.prototype.$eventBus = new Vue()
// Vue.prototype.$showMessage = showMessage
// Vue.prototype.$moment = moment
// Vue.prototype.$FORMATS = constants.FORMATS

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
