import './styles/quasar.styl'
import iconSet from 'quasar/icon-set/ionicons-v4.js'
import '@quasar/extras/ionicons-v4/ionicons-v4.css'
import {
  ClosePopup,
  Notify,
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
  QCheckbox,
  QField,
  QCardSection,
  QCardActions,
  QChip,
  QSplitter,
  QSeparator,
  QTooltip,
} from 'quasar'

Notify.setDefaults({ textColor: 'white' })

export default {
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
    QCheckbox,
    QField,
    QCardSection,
    QCardActions,
    QChip,
    QSplitter,
    QSeparator,
    QTooltip,
  },
  directives: {
    ClosePopup,
  },
  plugins: {
    Notify,
  },
  iconSet: iconSet,
}