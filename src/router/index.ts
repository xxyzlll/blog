import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
    history: createWebHistory(),
    routes: [
        { path: '/', component: () => import('../views/Home.vue') },
        {
            path: '/articles', component: () => import('../views/Articles.vue'), meta: {
                keepAlive: true  // 标记需缓存的页面
            }
        },
        { path: '/about', component: () => import('../views/About.vue') },
        { path: '/friends', component: () => import('../views/Friends.vue') },
        { path: '/tags', component: () => import('../views/Tags.vue') },
        { path: '/article-detail', component: () => import('../views/ArticleDetail.vue') },
    ]
})

export default router
