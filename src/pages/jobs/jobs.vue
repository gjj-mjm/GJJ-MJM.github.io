<template>
  <view class="jobs-container">
    <!-- 搜索框 -->
    <view class="search-container">
      <view class="search-input-wrapper">
        <text class="search-icon">🔍</text>
        <input 
          type="text" 
          class="search-input" 
          placeholder="搜索岗位名称或公司" 
          v-model="keyword"
          @input="onSearch"
        />
      </view>
    </view>

    <!-- 筛选条件 -->
    <view class="filters">
      <view class="filter-item" :class="{ active: selectedLocation === 'all' }" @click="setLocation('all')">
        <text>全部地区</text>
      </view>
      <view class="filter-item" :class="{ active: selectedLocation === 'local' }" @click="setLocation('local')">
        <text>本地</text>
      </view>
      <view class="filter-item" :class="{ active: selectedLocation === 'nearby' }" @click="setLocation('nearby')">
        <text>附近</text>
      </view>
    </view>

    <!-- 薪资筛选 -->
    <view class="salary-filters">
      <view class="filter-item" :class="{ active: selectedSalary === 'all' }" @click="setSalary('all')">
        <text>薪资不限</text>
      </view>
      <view class="filter-item" :class="{ active: selectedSalary === '0-3000' }" @click="setSalary('0-3000')">
        <text>3000以下</text>
      </view>
      <view class="filter-item" :class="{ active: selectedSalary === '3000-5000' }" @click="setSalary('3000-5000')">
        <text>3000-5000</text>
      </view>
      <view class="filter-item" :class="{ active: selectedSalary === '5000-8000' }" @click="setSalary('5000-8000')">
        <text>5000-8000</text>
      </view>
      <view class="filter-item" :class="{ active: selectedSalary === '8000+' }" @click="setSalary('8000+')">
        <text>8000以上</text>
      </view>
    </view>

    <!-- 岗位列表 -->
    <view class="job-list" v-if="filteredJobs.length > 0">
      <view 
        class="job-card" 
        v-for="job in filteredJobs" 
        :key="job.id"
        @click="viewJobDetail(job.id)"
      >
        <view class="job-header">
          <view class="job-title">{{ job.title }}</view>
          <view class="job-salary">{{ job.salary }}</view>
        </view>
        <view class="job-company">{{ job.company }}</view>
        <view class="job-info">
          <view class="job-location">
            <text class="info-icon">📍</text>
            <text>{{ job.location }}</text>
          </view>
          <view class="job-experience">
            <text class="info-icon">💼</text>
            <text>{{ job.experience }}</text>
          </view>
          <view class="job-education">
            <text class="info-icon">🎓</text>
            <text>{{ job.education }}</text>
          </view>
        </view>
        <view class="job-tags">
          <view class="tag" v-for="(tag, index) in job.tags" :key="index">
            {{ tag }}
          </view>
        </view>
        <view class="job-footer">
          <view class="job-update-time">{{ job.updateTime }}</view>
          <view class="job-apply-btn" @click.stop="applyJob(job.id)">
            <text>立即申请</text>
          </view>
        </view>
      </view>
    </view>

    <!-- 无数据提示 -->
    <view class="no-data" v-else>
      <text class="no-data-icon">📋</text>
      <text class="no-data-text">暂无符合条件的岗位</text>
      <text class="no-data-hint">请尝试调整筛选条件</text>
    </view>

    <!-- 加载更多 -->
    <view class="load-more" v-if="hasMore && filteredJobs.length > 0">
      <text @click="loadMore">加载更多</text>
    </view>
  </view>
</template>

<script>
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { useJobStore } from '../../store/index'

export default {
  name: 'JobsPage',
  setup() {
    const router = useRouter()
    const jobStore = useJobStore()
    const keyword = ref('')
    const selectedLocation = ref('all')
    const selectedSalary = ref('all')
    const currentPage = ref(1)
    const hasMore = ref(true)

    // 模拟岗位数据
    const jobs = ref([
      {
        id: 1,
        title: '农业技术员',
        company: '绿色生态农场',
        salary: '4000-6000元/月',
        location: '本地',
        experience: '1-3年',
        education: '中专及以上',
        tags: ['农业', '技术支持', '全职'],
        updateTime: '2小时前'
      },
      {
        id: 2,
        title: '乡村电商运营',
        company: '农产品销售公司',
        salary: '5000-8000元/月',
        location: '本地',
        experience: '1-3年',
        education: '大专及以上',
        tags: ['电商', '运营', '全职'],
        updateTime: '昨天'
      },
      {
        id: 3,
        title: '种植顾问',
        company: '现代农业合作社',
        salary: '3500-5500元/月',
        location: '本地',
        experience: '3-5年',
        education: '不限',
        tags: ['农业', '顾问', '全职'],
        updateTime: '3天前'
      },
      {
        id: 4,
        title: '农村淘宝服务站站长',
        company: '阿里巴巴农村淘宝',
        salary: '3000-5000元/月',
        location: '附近',
        experience: '不限',
        education: '高中及以上',
        tags: ['电商', '服务', '全职'],
        updateTime: '1周前'
      },
      {
        id: 5,
        title: '畜牧兽医',
        company: '畜牧养殖基地',
        salary: '5000-7000元/月',
        location: '附近',
        experience: '2-5年',
        education: '大专及以上',
        tags: ['畜牧', '医疗', '全职'],
        updateTime: '1周前'
      }
    ])

    // 根据筛选条件计算显示的岗位列表
    const filteredJobs = computed(() => {
      return jobs.value.filter(job => {
        // 关键词筛选
        const keywordMatch = keyword.value === '' || 
          job.title.toLowerCase().includes(keyword.value.toLowerCase()) ||
          job.company.toLowerCase().includes(keyword.value.toLowerCase())
        
        // 地区筛选
        const locationMatch = selectedLocation.value === 'all' || 
          job.location === (selectedLocation.value === 'local' ? '本地' : '附近')
        
        // 薪资筛选
        let salaryMatch = true
        if (selectedSalary.value !== 'all') {
          const salary = job.salary
          const salaryRange = selectedSalary.value
          
          switch(salaryRange) {
            case '0-3000':
              salaryMatch = salary.includes('3000') && salary.startsWith('3000')
              break
            case '3000-5000':
              salaryMatch = salary.includes('3000') || salary.includes('4000')
              break
            case '5000-8000':
              salaryMatch = salary.includes('5000') || salary.includes('6000') || salary.includes('7000')
              break
            case '8000+':
              salaryMatch = salary.includes('8000') || salary.includes('9000') || salary.includes('10000')
              break
          }
        }
        
        return keywordMatch && locationMatch && salaryMatch
      })
    })

    // 搜索处理
    const onSearch = () => {
      currentPage.value = 1
      // 这里可以触发实际的搜索请求
      console.log('搜索关键词:', keyword.value)
    }

    // 设置地区筛选
    const setLocation = (location) => {
      selectedLocation.value = location
      currentPage.value = 1
      console.log('选择地区:', location)
    }

    // 设置薪资筛选
    const setSalary = (salary) => {
      selectedSalary.value = salary
      currentPage.value = 1
      console.log('选择薪资:', salary)
    }

    // 查看岗位详情
    const viewJobDetail = (jobId) => {
      router.push(`/pages/job-detail/job-detail?id=${jobId}`)
    }

    // 申请岗位
    const applyJob = (jobId) => {
      // 这里可以实现申请岗位的逻辑
      console.log('申请岗位:', jobId)
      // 弹出提示
      if (typeof wx !== 'undefined') {
        wx.showToast({
          title: '申请成功',
          icon: 'success',
          duration: 2000
        })
      } else {
        alert('申请成功')
      }
    }

    // 加载更多
    const loadMore = () => {
      // 这里可以实现分页加载的逻辑
      console.log('加载更多岗位')
      // 模拟没有更多数据的情况
      hasMore.value = false
    }

    // 页面加载时的逻辑
    onMounted(() => {
      console.log('岗位页面加载完成')
    })

    return {
      keyword,
      selectedLocation,
      selectedSalary,
      filteredJobs,
      hasMore,
      onSearch,
      setLocation,
      setSalary,
      viewJobDetail,
      applyJob,
      loadMore
    }
  }
}
</script>

<style scoped>
.jobs-container {
  padding-bottom: 100rpx;
  background-color: #f5f5f5;
  min-height: 100vh;
}

/* 搜索框样式 */
.search-container {
  padding: 20rpx;
  background-color: #ffffff;
  position: sticky;
  top: 0;
  z-index: 10;
}

.search-input-wrapper {
  display: flex;
  align-items: center;
  background-color: #f5f5f5;
  border-radius: 30rpx;
  padding: 0 30rpx;
}

.search-icon {
  font-size: 32rpx;
  color: #999;
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

/* 筛选条件样式 */
.filters {
  display: flex;
  background-color: #ffffff;
  padding: 20rpx;
  overflow-x: auto;
  white-space: nowrap;
  margin-bottom: 10rpx;
}

.salary-filters {
  display: flex;
  background-color: #ffffff;
  padding: 20rpx;
  overflow-x: auto;
  white-space: nowrap;
  margin-bottom: 20rpx;
}

.filter-item {
  padding: 10rpx 20rpx;
  margin-right: 20rpx;
  border-radius: 20rpx;
  background-color: #f5f5f5;
  font-size: 26rpx;
  color: #666666;
}

.filter-item.active {
  background-color: #1a5f23;
  color: #ffffff;
}

.filter-item:active {
  opacity: 0.8;
}

/* 岗位卡片样式 */
.job-list {
  padding: 20rpx;
  display: flex;
  flex-direction: column;
  gap: 20rpx;
}

.job-card {
  background-color: #ffffff;
  border-radius: 12rpx;
  padding: 24rpx;
  box-shadow: 0 2rpx 8rpx rgba(0, 0, 0, 0.05);
}

.job-card:active {
  background-color: #f9f9f9;
}

.job-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12rpx;
}

.job-title {
  font-size: 32rpx;
  font-weight: bold;
  color: #333333;
  flex: 1;
}

.job-salary {
  font-size: 32rpx;
  color: #e64340;
  font-weight: bold;
}

.job-company {
  font-size: 28rpx;
  color: #666666;
  margin-bottom: 16rpx;
}

.job-info {
  display: flex;
  gap: 20rpx;
  margin-bottom: 16rpx;
}

.job-location,
.job-experience,
.job-education {
  display: flex;
  align-items: center;
  font-size: 24rpx;
  color: #999999;
}

.info-icon {
  margin-right: 5rpx;
}

.job-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 10rpx;
  margin-bottom: 16rpx;
}

.tag {
  padding: 5rpx 15rpx;
  background-color: #f0f9f2;
  color: #1a5f23;
  border-radius: 15rpx;
  font-size: 22rpx;
}

.job-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.job-update-time {
  font-size: 22rpx;
  color: #999999;
}

.job-apply-btn {
  background-color: #1a5f23;
  color: #ffffff;
  padding: 10rpx 30rpx;
  border-radius: 20rpx;
  font-size: 26rpx;
}

.job-apply-btn:active {
  opacity: 0.8;
}

/* 无数据提示 */
.no-data {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 100rpx 0;
}

.no-data-icon {
  font-size: 100rpx;
  margin-bottom: 20rpx;
}

.no-data-text {
  font-size: 32rpx;
  color: #666666;
  margin-bottom: 10rpx;
}

.no-data-hint {
  font-size: 26rpx;
  color: #999999;
}

/* 加载更多 */
.load-more {
  text-align: center;
  padding: 30rpx 0;
  color: #999999;
  font-size: 28rpx;
}

.load-more:active {
  color: #1a5f23;
}
</style>