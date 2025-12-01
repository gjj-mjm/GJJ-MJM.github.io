<template>
  <view class="index-container">
    <!-- 头部搜索框 -->
    <view class="search-bar">
      <view class="search-input">
        <text class="search-icon">🔍</text>
        <text class="search-placeholder">搜索岗位或培训</text>
      </view>
    </view>

    <!-- 轮播图 -->
    <view class="banner">
      <swiper class="swiper" indicator-dots circular autoplay interval="5000">
        <swiper-item>
          <view class="banner-item banner-1">乡村振兴计划</view>
        </swiper-item>
        <swiper-item>
          <view class="banner-item banner-2">技能培训课程</view>
        </swiper-item>
        <swiper-item>
          <view class="banner-item banner-3">岗位推荐</view>
        </swiper-item>
      </swiper>
    </view>

    <!-- 快捷入口 -->
    <view class="quick-entry">
      <view class="entry-item" @click="navigateTo('/pages/jobs/jobs')">
        <view class="entry-icon">💼</view>
        <text class="entry-text">岗位匹配</text>
      </view>
      <view class="entry-item" @click="navigateTo('/pages/training/training')">
        <view class="entry-icon">📚</view>
        <text class="entry-text">技能培训</text>
      </view>
      <view class="entry-item" @click="navigateTo('/pages/resume/resume')">
        <view class="entry-icon">📝</view>
        <text class="entry-text">简历管理</text>
      </view>
      <view class="entry-item" @click="navigateTo('/pages/profile/profile')">
        <view class="entry-icon">👤</view>
        <text class="entry-text">个人中心</text>
      </view>
    </view>

    <!-- 推荐岗位 -->
    <view class="section">
      <view class="section-header">
        <text class="section-title">推荐岗位</text>
        <view class="section-more" @click="navigateTo('/pages/jobs/jobs')">
          <text>查看更多</text>
          <text class="more-icon">›</text>
        </view>
      </view>
      <view class="job-list">
        <view class="job-item" v-for="(job, index) in recommendedJobs" :key="index" @click="navigateTo('/pages/job-detail/job-detail?id=' + job.id)">
          <view class="job-title">{{ job.title }}</view>
          <view class="job-company">{{ job.company }}</view>
          <view class="job-info">
            <text class="job-salary">{{ job.salary }}</text>
            <text class="job-location">{{ job.location }}</text>
          </view>
        </view>
      </view>
    </view>

    <!-- 热门培训 -->
    <view class="section">
      <view class="section-header">
        <text class="section-title">热门培训</text>
        <view class="section-more" @click="navigateTo('/pages/training/training')">
          <text>查看更多</text>
          <text class="more-icon">›</text>
        </view>
      </view>
      <view class="course-list">
        <view class="course-item" v-for="(course, index) in popularCourses" :key="index" @click="navigateTo('/pages/course-detail/course-detail?id=' + course.id)">
          <view class="course-img course-img-{{index % 3 + 1}}"></view>
          <view class="course-info">
            <view class="course-title">{{ course.title }}</view>
            <view class="course-stats">
              <text class="course-students">{{ course.students }}人学习</text>
              <text class="course-rating">{{ course.rating }}分</text>
            </view>
          </view>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { useJobStore, useCourseStore } from '../../store/index'

export default {
  name: 'IndexPage',
  setup() {
    const router = useRouter()
    const jobStore = useJobStore()
    const courseStore = useCourseStore()

    // 模拟推荐岗位数据
    const recommendedJobs = ref([
      { id: 1, title: '农业技术员', company: '绿色生态农场', salary: '4000-6000元/月', location: '本地' },
      { id: 2, title: '乡村电商运营', company: '农产品销售公司', salary: '5000-8000元/月', location: '本地' },
      { id: 3, title: '种植顾问', company: '现代农业合作社', salary: '3500-5500元/月', location: '本地' }
    ])

    // 模拟热门课程数据
    const popularCourses = ref([
      { id: 1, title: '现代农业技术基础', students: 1234, rating: 4.8 },
      { id: 2, title: '电商直播带货技巧', students: 2345, rating: 4.9 },
      { id: 3, title: '病虫害防治专题', students: 890, rating: 4.7 }
    ])

    // 导航到指定页面
    const navigateTo = (url) => {
      router.push(url)
    }

    // 页面加载时获取数据
    onMounted(() => {
      // 这里可以从store或API获取实际数据
      console.log('首页加载完成')
    })

    return {
      recommendedJobs,
      popularCourses,
      navigateTo
    }
  }
}
</script>

<style scoped>
.index-container {
  padding-bottom: 100rpx;
  background-color: #f5f5f5;
}

/* 搜索框样式 */
.search-bar {
  padding: 20rpx;
  background-color: #ffffff;
  position: sticky;
  top: 0;
  z-index: 10;
}

.search-input {
  display: flex;
  align-items: center;
  background-color: #f5f5f5;
  border-radius: 30rpx;
  padding: 20rpx 30rpx;
}

.search-icon {
  font-size: 32rpx;
  margin-right: 10rpx;
  color: #999;
}

.search-placeholder {
  font-size: 28rpx;
  color: #999;
}

/* 轮播图样式 */
.banner {
  width: 100%;
  height: 300rpx;
  margin-bottom: 20rpx;
}

.swiper {
  width: 100%;
  height: 100%;
}

.banner-item {
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  color: #ffffff;
  font-size: 36rpx;
  font-weight: bold;
  border-radius: 12rpx;
  margin: 0 20rpx;
}

.banner-1 {
  background-color: #1a5f23;
}

.banner-2 {
  background-color: #2c8c38;
}

.banner-3 {
  background-color: #41a651;
}

/* 快捷入口样式 */
.quick-entry {
  display: flex;
  justify-content: space-around;
  padding: 30rpx 0;
  background-color: #ffffff;
  margin-bottom: 20rpx;
}

.entry-item {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.entry-icon {
  width: 100rpx;
  height: 100rpx;
  display: flex;
  justify-content: center;
  align-items: center;
  font-size: 50rpx;
  margin-bottom: 10rpx;
  background-color: #f0f9f2;
  border-radius: 50%;
}

.entry-text {
  font-size: 24rpx;
  color: #333;
}

/* 通用区域样式 */
.section {
  background-color: #ffffff;
  margin-bottom: 20rpx;
  padding: 20rpx;
}

.section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20rpx;
}

.section-title {
  font-size: 32rpx;
  font-weight: bold;
  color: #333;
}

.section-more {
  display: flex;
  align-items: center;
  color: #999;
  font-size: 26rpx;
}

.more-icon {
  font-size: 32rpx;
  margin-left: 5rpx;
}

/* 岗位列表样式 */
.job-list {
  display: flex;
  flex-direction: column;
  gap: 20rpx;
}

.job-item {
  padding: 20rpx;
  background-color: #f9f9f9;
  border-radius: 12rpx;
}

.job-item:active {
  background-color: #f0f0f0;
}

.job-title {
  font-size: 30rpx;
  font-weight: 500;
  color: #333;
  margin-bottom: 8rpx;
}

.job-company {
  font-size: 26rpx;
  color: #666;
  margin-bottom: 8rpx;
}

.job-info {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.job-salary {
  font-size: 28rpx;
  color: #e64340;
  font-weight: 500;
}

.job-location {
  font-size: 24rpx;
  color: #999;
}

/* 课程列表样式 */
.course-list {
  display: flex;
  flex-direction: column;
  gap: 20rpx;
}

.course-item {
  display: flex;
  background-color: #f9f9f9;
  border-radius: 12rpx;
  overflow: hidden;
}

.course-item:active {
  background-color: #f0f0f0;
}

.course-img {
  width: 200rpx;
  height: 140rpx;
  background-size: cover;
  background-position: center;
}

.course-img-1 {
  background-color: #d4f1e1;
}

.course-img-2 {
  background-color: #e1d4f1;
}

.course-img-3 {
  background-color: #f1e1d4;
}

.course-info {
  flex: 1;
  padding: 20rpx;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.course-title {
  font-size: 28rpx;
  color: #333;
  margin-bottom: 10rpx;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.course-stats {
  display: flex;
  justify-content: space-between;
  font-size: 22rpx;
  color: #999;
}
</style>