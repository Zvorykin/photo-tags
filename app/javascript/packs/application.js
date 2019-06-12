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

// import showMessage from '../packs/lib/notification'
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
  QPagination,
  QBadge,
  QInnerLoading,
  QSpinnerTail,
  QSelect,
  QCheckbox
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
    QPagination,
    QBadge,
    QInnerLoading,
    QSpinnerTail,
    QSelect,
    QCheckbox
  },
  directives: {
    ClosePopup
  },
  plugins: {},
  iconSet: iconSet,
})

Vue.prototype.$eventBus = new Vue()
// Vue.prototype.$showMessage = showMessage

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
