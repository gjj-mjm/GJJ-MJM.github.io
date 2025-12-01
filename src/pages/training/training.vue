<template>
  <view class="training-container">
    <!-- 搜索框 -->
    <view class="search-section">
      <view class="search-input-container">
        <text class="search-icon">🔍</text>
        <input 
          type="text" 
          class="search-input" 
          placeholder="搜索培训课程" 
          v-model="searchKeyword"
          @input="handleSearch"
        />
      </view>
    </view>

    <!-- 分类筛选 -->
    <view class="categories">
      <scroll-view scroll-x class="category-scroll">
        <view 
          class="category-item" 
          :class="{ active: selectedCategory === 'all' }" 
          @click="selectCategory('all')"
        >
          <text>全部课程</text>
        </view>
        <view 
          class="category-item" 
          :class="{ active: selectedCategory === 'agriculture' }" 
          @click="selectCategory('agriculture')"
        >
          <text>农业技术</text>
        </view>
        <view 
          class="category-item" 
          :class="{ active: selectedCategory === 'business' }" 
          @click="selectCategory('business')"
        >
          <text>创业管理</text>
        </view>
        <view 
          class="category-item" 
          :class="{ active: selectedCategory === 'digital' }" 
          @click="selectCategory('digital')"
        >
          <text>数字技能</text>
        </view>
        <view 
          class="category-item" 
          :class="{ active: selectedCategory === 'livestock' }" 
          @click="selectCategory('livestock')"
        >
          <text>养殖技术</text>
        </view>
        <view 
          class="category-item" 
          :class="{ active: selectedCategory === 'horticulture' }" 
          @click="selectCategory('horticulture')"
        >
          <text>园艺花卉</text>
        </view>
      </scroll-view>
    </view>

    <!-- 课程列表 -->
    <view class="course-section">
      <view class="section-header">
        <text class="section-title">推荐课程</text>
      </view>
      
      <view class="course-grid" v-if="filteredCourses.length > 0">
        <view 
          class="course-card" 
          v-for="course in filteredCourses" 
          :key="course.id"
          @click="viewCourseDetail(course.id)"
        >
          <!-- 课程封面图 -->
          <view class="course-cover" :class="`course-cover-${course.id % 5 + 1}`">
            <view class="course-duration">{{ course.duration }}</view>
          </view>
          
          <!-- 课程信息 -->
          <view class="course-info">
            <view class="course-title">{{ course.title }}</view>
            
            <view class="course-teacher">{{ course.teacher }}</view>
            
            <view class="course-stats">
              <view class="course-students">
                <text class="students-icon">👥</text>
                <text>{{ course.students }}人学习</text>
              </view>
              <view class="course-rating">
                <text class="rating-icon">⭐</text>
                <text>{{ course.rating }}</text>
              </view>
            </view>
            
            <view class="course-price">
              <text v-if="course.isFree" class="free-tag">免费</text>
              <text v-else class="price-tag">¥{{ course.price }}</text>
            </view>
          </view>
          
          <!-- 立即学习按钮 -->
          <view class="course-action">
            <button class="learn-btn" @click.stop="enrollCourse(course.id)">
              <text>{{ course.isFree ? '立即学习' : '立即报名' }}</text>
            </button>
          </view>
        </view>
      </view>
      
      <!-- 无课程提示 -->
      <view class="no-courses" v-else>
        <text class="no-courses-icon">📚</text>
        <text class="no-courses-text">暂无相关课程</text>
        <text class="no-courses-hint">请尝试其他搜索条件</text>
      </view>
    </view>
    
    <!-- 热门推荐 -->
    <view class="featured-section" v-if="featuredCourses.length > 0">
      <view class="section-header">
        <text class="section-title">热门推荐</text>
      </view>
      
      <view class="featured-list">
        <view 
          class="featured-item" 
          v-for="course in featuredCourses" 
          :key="course.id"
          @click="viewCourseDetail(course.id)"
        >
          <view class="featured-cover" :class="`featured-cover-${course.id % 3 + 1}`">
          </view>
          <view class="featured-info">
            <view class="featured-title">{{ course.title }}</view>
            <view class="featured-desc">{{ course.description }}</view>
            <view class="featured-footer">
              <view class="featured-students">{{ course.students }}人已学习</view>
              <view class="featured-arrow">›</view>
            </view>
          </view>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { useCourseStore } from '../../store/index'

export default {
  name: 'TrainingPage',
  setup() {
    const router = useRouter()
    const courseStore = useCourseStore()
    const searchKeyword = ref('')
    const selectedCategory = ref('all')
    
    // 模拟课程数据
    const courses = ref([
      {
        id: 1,
        title: '现代农业种植技术基础',
        description: '学习现代农业种植的基础知识和实用技术',
        teacher: '王教授',
        category: 'agriculture',
        students: 1245,
        rating: 4.8,
        duration: '12课时',
        isFree: true,
        price: 0
      },
      {
        id: 2,
        title: '电商直播带货技巧',
        description: '掌握农产品直播带货的核心技巧',
        teacher: '李老师',
        category: 'digital',
        students: 2341,
        rating: 4.9,
        duration: '8课时',
        isFree: false,
        price: 199
      },
      {
        id: 3,
        title: '病虫害绿色防控技术',
        description: '学习环保高效的病虫害防治方法',
        teacher: '张专家',
        category: 'agriculture',
        students: 892,
        rating: 4.7,
        duration: '10课时',
        isFree: true,
        price: 0
      },
      {
        id: 4,
        title: '农村创业项目规划',
        description: '如何规划和启动一个成功的农村创业项目',
        teacher: '刘顾问',
        category: 'business',
        students: 1567,
        rating: 4.6,
        duration: '15课时',
        isFree: false,
        price: 299
      },
      {
        id: 5,
        title: '家禽科学养殖技术',
        description: '科学养殖家禽，提高产量和品质',
        teacher: '陈技术员',
        category: 'livestock',
        students: 987,
        rating: 4.5,
        duration: '12课时',
        isFree: false,
        price: 149
      },
      {
        id: 6,
        title: '果树嫁接与修剪技术',
        description: '掌握果树嫁接和科学修剪的实用技能',
        teacher: '赵园艺师',
        category: 'horticulture',
        students: 756,
        rating: 4.7,
        duration: '9课时',
        isFree: true,
        price: 0
      }
    ])
    
    // 模拟热门推荐课程
    const featuredCourses = ref([
      {
        id: 101,
        title: '智慧农业技术应用',
        description: '物联网和大数据在现代农业中的应用',
        students: 3245,
        category: 'agriculture'
      },
      {
        id: 102,
        title: '农产品品牌建设与营销',
        description: '打造特色农产品品牌，拓展销售渠道',
        students: 2134,
        category: 'business'
      },
      {
        id: 103,
        title: '高效节水灌溉技术',
        description: '学习先进的节水灌溉技术，提高水资源利用效率',
        students: 1542,
        category: 'agriculture'
      }
    ])
    
    // 根据搜索关键词和分类筛选课程
    const filteredCourses = computed(() => {
      return courses.value.filter(course => {
        // 搜索关键词筛选
        const keywordMatch = searchKeyword.value === '' || 
          course.title.toLowerCase().includes(searchKeyword.value.toLowerCase()) ||
          course.description.toLowerCase().includes(searchKeyword.value.toLowerCase())
        
        // 分类筛选
        const categoryMatch = selectedCategory.value === 'all' || 
          course.category === selectedCategory.value
        
        return keywordMatch && categoryMatch
      })
    })
    
    // 搜索处理
    const handleSearch = () => {
      console.log('搜索关键词:', searchKeyword.value)
    }
    
    // 选择分类
    const selectCategory = (category) => {
      selectedCategory.value = category
      console.log('选择分类:', category)
    }
    
    // 查看课程详情
    const viewCourseDetail = (courseId) => {
      router.push(`/pages/course-detail/course-detail?id=${courseId}`)
    }
    
    // 报名课程
    const enrollCourse = (courseId) => {
      // 这里可以实现报名课程的逻辑
      console.log('报名课程:', courseId)
      
      // 模拟报名成功提示
      if (typeof wx !== 'undefined') {
        wx.showToast({
          title: '报名成功',
          icon: 'success',
          duration: 2000
        })
      } else {
        alert('报名成功')
      }
    }
    
    // 页面加载时的逻辑
    onMounted(() => {
      // 可以在这里加载实际的课程数据
      console.log('培训页面加载完成')
    })
    
    return {
      searchKeyword,
      selectedCategory,
      courses,
      filteredCourses,
      featuredCourses,
      handleSearch,
      selectCategory,
      viewCourseDetail,
      enrollCourse
    }
  }
}
</script>

<style scoped>
.training-container {
  background-color: #f5f5f5;
  padding-bottom: 100rpx;
  min-height: 100vh;
}

/* 搜索区域样式 */
.search-section {
  padding: 20rpx;
  background-color: #ffffff;
  position: sticky;
  top: 0;
  z-index: 10;
}

.search-input-container {
  display: flex;
  align-items: center;
  background-color: #f5f5f5;
  border-radius: 30rpx;
  padding: 0 30rpx;
}

.search-icon {
  font-size: 32rpx;
  color: #999999;
  margin-right: 10rpx;
}

.search-input {
  flex: 1;
  height: 60rpx;
  background-color: transparent;
  border: none;
  outline: none;
  font-size: 28rpx;
}

/* 分类筛选样式 */
.categories {
  background-color: #ffffff;
  padding: 20rpx 0;
  margin-bottom: 20rpx;
}

.category-scroll {
  padding: 0 20rpx;
}

.category-item {
  display: inline-block;
  padding: 10rpx 30rpx;
  margin-right: 20rpx;
  border-radius: 20rpx;
  background-color: #f5f5f5;
  font-size: 28rpx;
  color: #666666;
  white-space: nowrap;
}

.category-item.active {
  background-color: #1a5f23;
  color: #ffffff;
}

.category-item:active {
  opacity: 0.8;
}

/* 课程列表样式 */
.course-section {
  padding: 20rpx;
  margin-bottom: 20rpx;
}

.section-header {
  margin-bottom: 20rpx;
}

.section-title {
  font-size: 34rpx;
  font-weight: bold;
  color: #333333;
}

.course-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 20rpx;
}

.course-card {
  background-color: #ffffff;
  border-radius: 12rpx;
  overflow: hidden;
  box-shadow: 0 2rpx 8rpx rgba(0, 0, 0, 0.05);
}

.course-card:active {
  background-color: #f9f9f9;
}

.course-cover {
  width: 100%;
  height: 200rpx;
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
}

.course-cover-1 {
  background-color: #d4f1e1;
}

.course-cover-2 {
  background-color: #e1d4f1;
}

.course-cover-3 {
  background-color: #f1e1d4;
}

.course-cover-4 {
  background-color: #e1f1d4;
}

.course-cover-5 {
  background-color: #d4e1f1;
}

.course-duration {
  position: absolute;
  bottom: 10rpx;
  right: 10rpx;
  background-color: rgba(0, 0, 0, 0.6);
  color: #ffffff;
  padding: 5rpx 15rpx;
  border-radius: 15rpx;
  font-size: 22rpx;
}

.course-info {
  padding: 20rpx;
}

.course-title {
  font-size: 28rpx;
  font-weight: bold;
  color: #333333;
  margin-bottom: 10rpx;
  line-height: 1.4;
  height: 80rpx;
  overflow: hidden;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
}

.course-teacher {
  font-size: 24rpx;
  color: #666666;
  margin-bottom: 10rpx;
}

.course-stats {
  display: flex;
  justify-content: space-between;
  margin-bottom: 15rpx;
}

.course-students,
.course-rating {
  display: flex;
  align-items: center;
  font-size: 22rpx;
  color: #999999;
}

.students-icon,
.rating-icon {
  margin-right: 5rpx;
  font-size: 24rpx;
}

.course-action {
  padding: 0 20rpx 20rpx;
}

.learn-btn {
  background-color: #1a5f23;
  color: #ffffff;
  border: none;
  padding: 15rpx 0;
  border-radius: 8rpx;
  font-size: 28rpx;
  width: 100%;
}

.learn-btn:active {
  background-color: #2c8c38;
}

.course-price {
  margin-bottom: 15rpx;
}

.free-tag {
  background-color: #e8f5e9;
  color: #1a5f23;
  padding: 5rpx 15rpx;
  border-radius: 15rpx;
  font-size: 24rpx;
}

.price-tag {
  color: #e64340;
  font-size: 30rpx;
  font-weight: bold;
}

/* 无课程提示样式 */
.no-courses {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 100rpx 0;
}

.no-courses-icon {
  font-size: 100rpx;
  margin-bottom: 20rpx;
}

.no-courses-text {
  font-size: 32rpx;
  color: #666666;
  margin-bottom: 10rpx;
}

.no-courses-hint {
  font-size: 26rpx;
  color: #999999;
}

/* 热门推荐样式 */
.featured-section {
  background-color: #ffffff;
  padding: 20rpx;
}

.featured-list {
  display: flex;
  flex-direction: column;
  gap: 20rpx;
}

.featured-item {
  display: flex;
  background-color: #f9f9f9;
  border-radius: 12rpx;
  overflow: hidden;
  padding: 15rpx;
}

.featured-item:active {
  background-color: #f0f0f0;
}

.featured-cover {
  width: 160rpx;
  height: 160rpx;
  border-radius: 8rpx;
  margin-right: 20rpx;
}

.featured-cover-1 {
  background-color: #d4f1e1;
}

.featured-cover-2 {
  background-color: #e1d4f1;
}

.featured-cover-3 {
  background-color: #f1e1d4;
}

.featured-info {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.featured-title {
  font-size: 28rpx;
  font-weight: bold;
  color: #333333;
  margin-bottom: 10rpx;
}

.featured-desc {
  font-size: 24rpx;
  color: #666666;
  margin-bottom: 10rpx;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.featured-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.featured-students {
  font-size: 22rpx;
  color: #999999;
}

.featured-arrow {
  font-size: 32rpx;
  color: #999999;
}
</style>