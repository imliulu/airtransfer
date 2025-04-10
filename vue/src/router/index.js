import Vue from 'vue'
import Router from 'vue-router'
import Rooms from '@/views/Rooms.vue'
import Transfer from '@/views/Transfer.vue'
import NotFound from '@/views/NotFound.vue'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'Rooms',
      component: Rooms
    },
    {
      path: '/transfer/:roomID',
      name: 'Transfer',
      component: Transfer
    },
    {
      path: '*',
      name: 'NotFound',
      component: NotFound
    }
  ]
})
