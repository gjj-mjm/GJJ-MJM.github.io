import { createPinia } from 'pinia'

// 创建pinia实例
const pinia = createPinia()

// 定义用户状态store
export const useUserStore = defineStore('user', {
  state: () => ({
    userInfo: null,
    isLoggedIn: false,
    token: ''
  }),
  actions: {
    // 登录
    login(userInfo, token) {
      this.userInfo = userInfo
      this.isLoggedIn = true
      this.token = token
      // 可以在这里保存token到本地存储
      try {
        if (typeof wx !== 'undefined') {
          wx.setStorageSync('token', token)
        } else if (typeof localStorage !== 'undefined') {
          localStorage.setItem('token', token)
        }
      } catch (error) {
        console.error('保存token失败:', error)
      }
    },
    // 登出
    logout() {
      this.userInfo = null
      this.isLoggedIn = false
      this.token = ''
      // 清除本地存储的token
      try {
        if (typeof wx !== 'undefined') {
          wx.removeStorageSync('token')
        } else if (typeof localStorage !== 'undefined') {
          localStorage.removeItem('token')
        }
      } catch (error) {
        console.error('清除token失败:', error)
      }
    }
  }
})

// 定义岗位状态store
export const useJobStore = defineStore('job', {
  state: () => ({
    jobs: [],
    currentJob: null,
    filters: {
      keyword: '',
      location: '',
      salary: ''
    }
  }),
  actions: {
    // 设置岗位列表
    setJobs(jobs) {
      this.jobs = jobs
    },
    // 设置当前岗位
    setCurrentJob(job) {
      this.currentJob = job
    },
    // 更新筛选条件
    updateFilters(filters) {
      this.filters = { ...this.filters, ...filters }
    }
  }
})

// 定义培训课程状态store
export const useCourseStore = defineStore('course', {
  state: () => ({
    courses: [],
    currentCourse: null,
    enrolledCourses: []
  }),
  actions: {
    // 设置课程列表
    setCourses(courses) {
      this.courses = courses
    },
    // 设置当前课程
    setCurrentCourse(course) {
      this.currentCourse = course
    },
    // 报名课程
    enrollCourse(courseId) {
      if (!this.enrolledCourses.includes(courseId)) {
        this.enrolledCourses.push(courseId)
      }
    }
  }
})

export default pinia