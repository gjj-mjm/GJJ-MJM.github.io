import { createApp } from 'vue'
import App from './App.vue'
import { createRouter, createWebHashHistory } from 'vue-router'
import store from './store/index'

// 导入页面组件
const Index = () => import('./pages/index/index.vue')
const Jobs = () => import('./pages/jobs/jobs.vue')
const Training = () => import('./pages/training/training.vue')
const Profile = () => import('./pages/profile/profile.vue')
const Resume = () => import('./pages/resume/resume.vue')
const JobDetail = () => import('./pages/job-detail/job-detail.vue')
const CourseDetail = () => import('./pages/course-detail/course-detail.vue')

// 定义路由配置
const routes = [
  {
    path: '/',
    redirect: '/pages/index/index'
  },
  {
    path: '/pages/index/index',
    component: Index,
    name: 'Index'
  },
  {
    path: '/pages/jobs/jobs',
    component: Jobs,
    name: 'Jobs'
  },
  {
    path: '/pages/training/training',
    component: Training,
    name: 'Training'
  },
  {
    path: '/pages/profile/profile',
    component: Profile,
    name: 'Profile'
  },
  {
    path: '/pages/resume/resume',
    component: Resume,
    name: 'Resume'
  },
  {
    path: '/pages/job-detail/job-detail',
    component: JobDetail,
    name: 'JobDetail'
  },
  {
    path: '/pages/course-detail/course-detail',
    component: CourseDetail,
    name: 'CourseDetail'
  }
]

// 创建路由实例
const router = createRouter({
  history: createWebHashHistory(),
  routes
})

// 创建Vue应用实例
const app = createApp(App)

// 使用路由和状态管理
app.use(router)
app.use(store)

// 挂载应用
app.mount('#app')

// 导出应用实例供调试使用
export default app