<template>
  <view class="profile-container">
    <!-- 用户信息区域 -->
    <view class="user-section" @click="handleLoginOrProfile">
      <view class="user-avatar">
        <text v-if="!userStore.isLoggedIn" class="avatar-placeholder">👤</text>
        <image v-else :src="userStore.userInfo?.avatar || defaultAvatar" class="avatar-img"></image>
      </view>
      <view class="user-info">
        <view class="user-name">
          <text v-if="!userStore.isLoggedIn">未登录</text>
          <text v-else>{{ userStore.userInfo?.name || '用户' }}</text>
        </view>
        <view class="user-desc">
          <text v-if="!userStore.isLoggedIn">点击登录/注册</text>
          <text v-else>{{ userStore.userInfo?.profession || '普通用户' }}</text>
        </view>
      </view>
      <view class="user-arrow">
        <text>›</text>
      </view>
    </view>

    <!-- 统计信息 -->
    <view class="stats-section" v-if="userStore.isLoggedIn">
      <view class="stat-item" @click="navigateTo('/pages/jobs/jobs')">
        <view class="stat-number">{{ appliedJobs }}</view>
        <view class="stat-label">已申请</view>
      </view>
      <view class="stat-item" @click="navigateTo('/pages/training/training')">
        <view class="stat-number">{{ enrolledCourses }}</view>
        <view class="stat-label">已学习</view>
      </view>
      <view class="stat-item" @click="navigateTo('/pages/resume/resume')">
        <view class="stat-number">{{ completedHours }}</view>
        <view class="stat-label">学习时长</view>
      </view>
    </view>

    <!-- 功能菜单 -->
    <view class="menu-section">
      <!-- 我的服务 -->
      <view class="menu-group">
        <view class="menu-header">
          <text class="menu-title">我的服务</text>
        </view>
        <view class="menu-list">
          <view class="menu-item" @click="navigateTo('/pages/jobs/jobs?filter=applied')">
            <view class="menu-icon">📋</view>
            <view class="menu-text">我的申请</view>
            <view class="menu-arrow">›</view>
          </view>
          <view class="menu-item" @click="navigateTo('/pages/training/training?filter=enrolled')">
            <view class="menu-icon">📚</view>
            <view class="menu-text">我的课程</view>
            <view class="menu-arrow">›</view>
          </view>
          <view class="menu-item" @click="navigateTo('/pages/resume/resume')">
            <view class="menu-icon">📄</view>
            <view class="menu-text">简历管理</view>
            <view class="menu-arrow">›</view>
          </view>
          <view class="menu-item" @click="navigateTo('/pages/collection/collection')">
            <view class="menu-icon">❤️</view>
            <view class="menu-text">我的收藏</view>
            <view class="menu-arrow">›</view>
          </view>
        </view>
      </view>

      <!-- 系统设置 -->
      <view class="menu-group">
        <view class="menu-header">
          <text class="menu-title">系统设置</text>
        </view>
        <view class="menu-list">
          <view class="menu-item" @click="showNotificationSetting">
            <view class="menu-icon">🔔</view>
            <view class="menu-text">通知设置</view>
            <view class="menu-arrow">›</view>
          </view>
          <view class="menu-item" @click="showPrivacyPolicy">
            <view class="menu-icon">🔒</view>
            <view class="menu-text">隐私设置</view>
            <view class="menu-arrow">›</view>
          </view>
          <view class="menu-item" @click="showAbout">
            <view class="menu-icon">ℹ️</view>
            <view class="menu-text">关于我们</view>
            <view class="menu-arrow">›</view>
          </view>
          <view class="menu-item" @click="showHelp">
            <view class="menu-icon">❓</view>
            <view class="menu-text">帮助与反馈</view>
            <view class="menu-arrow">›</view>
          </view>
        </view>
      </view>
    </view>

    <!-- 退出登录按钮 -->
    <view class="logout-section" v-if="userStore.isLoggedIn">
      <button class="logout-btn" @click="handleLogout">退出登录</button>
    </view>

    <!-- 版本信息 -->
    <view class="version-section">
      <text class="version-text">版本 1.0.0</text>
    </view>
  </view>
</template>

<script>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { useUserStore } from '../../store/index'

export default {
  name: 'ProfilePage',
  setup() {
    const router = useRouter()
    const userStore = useUserStore()
    const defaultAvatar = '/assets/images/default-avatar.png'
    
    // 模拟统计数据
    const appliedJobs = ref(0)
    const enrolledCourses = ref(0)
    const completedHours = ref(0)
    
    // 处理登录或查看个人资料
    const handleLoginOrProfile = () => {
      if (userStore.isLoggedIn) {
        // 导航到个人资料详情页
        console.log('跳转到个人资料详情')
      } else {
        // 跳转到登录页面
        console.log('跳转到登录页面')
        // 模拟登录
        setTimeout(() => {
          mockLogin()
        }, 500)
      }
    }
    
    // 导航到指定页面
    const navigateTo = (path) => {
      if (!userStore.isLoggedIn) {
        // 如果未登录，先提示登录
        if (typeof wx !== 'undefined') {
          wx.showModal({
            title: '提示',
            content: '请先登录',
            showCancel: false
          })
        } else {
          alert('请先登录')
        }
        return
      }
      
      router.push(path)
    }
    
    // 显示通知设置
    const showNotificationSetting = () => {
      console.log('显示通知设置')
    }
    
    // 显示隐私政策
    const showPrivacyPolicy = () => {
      console.log('显示隐私设置')
    }
    
    // 显示关于我们
    const showAbout = () => {
      if (typeof wx !== 'undefined') {
        wx.showModal({
          title: '关于我们',
          content: '乡村人才振兴平台\n致力于为乡村人才提供就业和培训服务\n版本：1.0.0',
          showCancel: false
        })
      } else {
        alert('关于我们\n乡村人才振兴平台\n致力于为乡村人才提供就业和培训服务\n版本：1.0.0')
      }
    }
    
    // 显示帮助与反馈
    const showHelp = () => {
      console.log('显示帮助与反馈')
    }
    
    // 处理退出登录
    const handleLogout = () => {
      if (typeof wx !== 'undefined') {
        wx.showModal({
          title: '确认退出',
          content: '确定要退出登录吗？',
          success(res) {
            if (res.confirm) {
              userStore.logout()
              appliedJobs.value = 0
              enrolledCourses.value = 0
              completedHours.value = 0
            }
          }
        })
      } else {
        if (confirm('确定要退出登录吗？')) {
          userStore.logout()
          appliedJobs.value = 0
          enrolledCourses.value = 0
          completedHours.value = 0
        }
      }
    }
    
    // 模拟登录
    const mockLogin = () => {
      const mockUserInfo = {
        name: '张三',
        avatar: '',
        profession: '种植技术员',
        location: '本地'
      }
      const mockToken = 'mock_token_123456'
      
      userStore.login(mockUserInfo, mockToken)
      appliedJobs.value = 3
      enrolledCourses.value = 5
      completedHours.value = 12
      
      if (typeof wx !== 'undefined') {
        wx.showToast({
          title: '登录成功',
          icon: 'success',
          duration: 1500
        })
      }
    }
    
    // 页面加载时检查登录状态
    onMounted(() => {
      console.log('个人中心页面加载')
      
      // 这里可以检查本地存储的登录状态
      if (userStore.isLoggedIn) {
        // 如果已登录，可以加载统计数据
        appliedJobs.value = 3
        enrolledCourses.value = 5
        completedHours.value = 12
      }
    })
    
    return {
      userStore,
      defaultAvatar,
      appliedJobs,
      enrolledCourses,
      completedHours,
      handleLoginOrProfile,
      navigateTo,
      showNotificationSetting,
      showPrivacyPolicy,
      showAbout,
      showHelp,
      handleLogout
    }
  }
}
</script>

<style scoped>
.profile-container {
  background-color: #f5f5f5;
  min-height: 100vh;
  padding-bottom: 100rpx;
}

/* 用户信息区域 */
.user-section {
  display: flex;
  align-items: center;
  padding: 30rpx;
  background-color: #1a5f23;
  color: #ffffff;
}

.user-avatar {
  width: 120rpx;
  height: 120rpx;
  border-radius: 50%;
  background-color: rgba(255, 255, 255, 0.2);
  display: flex;
  align-items: center;
  justify-content: center;
  margin-right: 20rpx;
}

.avatar-placeholder {
  font-size: 60rpx;
}

.avatar-img {
  width: 100%;
  height: 100%;
  border-radius: 50%;
}

.user-info {
  flex: 1;
}

.user-name {
  font-size: 34rpx;
  font-weight: bold;
  margin-bottom: 10rpx;
}

.user-desc {
  font-size: 26rpx;
  opacity: 0.8;
}

.user-arrow {
  font-size: 40rpx;
  opacity: 0.8;
}

/* 统计信息区域 */
.stats-section {
  display: flex;
  background-color: #ffffff;
  padding: 30rpx 0;
  margin-bottom: 20rpx;
}

.stat-item {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.stat-number {
  font-size: 36rpx;
  font-weight: bold;
  color: #333333;
  margin-bottom: 10rpx;
}

.stat-label {
  font-size: 26rpx;
  color: #666666;
}

/* 菜单区域 */
.menu-section {
  margin-bottom: 30rpx;
}

.menu-group {
  background-color: #ffffff;
  margin-bottom: 20rpx;
  padding: 0 30rpx;
}

.menu-header {
  padding: 20rpx 0;
  border-bottom: 1rpx solid #f0f0f0;
}

.menu-title {
  font-size: 28rpx;
  color: #333333;
  font-weight: bold;
}

.menu-list {
  /* 菜单列表容器 */
}

.menu-item {
  display: flex;
  align-items: center;
  padding: 30rpx 0;
  border-bottom: 1rpx solid #f0f0f0;
}

.menu-item:last-child {
  border-bottom: none;
}

.menu-icon {
  font-size: 36rpx;
  margin-right: 20rpx;
}

.menu-text {
  flex: 1;
  font-size: 28rpx;
  color: #333333;
}

.menu-arrow {
  font-size: 32rpx;
  color: #999999;
}

.menu-item:active {
  background-color: #f9f9f9;
}

/* 退出登录按钮 */
.logout-section {
  padding: 0 30rpx 30rpx;
}

.logout-btn {
  width: 100%;
  background-color: #ffffff;
  color: #e64340;
  border: none;
  padding: 25rpx 0;
  border-radius: 12rpx;
  font-size: 30rpx;
}

.logout-btn:active {
  background-color: #f9f9f9;
}

/* 版本信息 */
.version-section {
  display: flex;
  justify-content: center;
  padding: 20rpx 0;
}

.version-text {
  font-size: 24rpx;
  color: #999999;
}
</style>