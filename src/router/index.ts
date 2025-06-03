import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    { path: '/', component: () => import('../views/Home.vue') },
    { path: '/articles', component: () => import('../views/Articles.vue') },
    { path: '/about', component: () => import('../views/About.vue') },
    { path: '/friends', component: () => import('../views/Friends.vue') }
  ]
})

export default router