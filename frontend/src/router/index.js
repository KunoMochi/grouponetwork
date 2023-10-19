import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'

const routes = [
  {
    // Home page
    path: '/',
    name: 'home',
    component: HomeView
  },
  {
    // Forum page
    path: '/forum',
    name: 'forum',
    component: () => import('../views/ForumView.vue')
  },
  {
    // Topic page
    path: '/topic/:id',
    name: 'topic',
    component: () => import('../views/TopicView.vue'),
    props: true
  },
  {
    // Post page
    path: '/post',
    name: 'post',
    component: () => import('../views/PostView.vue')
  },
  {
    // About page
    path: '/about',
    name: 'about',
    component: () => import('../views/AboutView.vue')
  },
  {
    // Profile page
    path: '/profile/:id',
    name: 'profile',
    component: () => import('../views/ProfileView.vue'),
    props: true
  },
  {
    // Signup page
    path: '/signup',
    name: 'signup',
    component: () => import('../views/SignupView.vue')
  },
  {
    // Login page
    path: '/login',
    name: 'login',
    component: () => import('../views/LoginView.vue')
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
