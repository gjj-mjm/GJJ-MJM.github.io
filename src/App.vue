<template>
  <router-view />
</template>

<script>
export default {
  name: 'App'
}
</script>

<style>
/* 全局样式 */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
  color: #333;
  background-color: #f5f5f5;
}

.container {
  max-width: 750rpx;
  margin: 0 auto;
  padding: 0 20rpx;
}

/* 主题色 */
:root {
  --primary-color: #1a5f23;
  --text-color: #333333;
  --text-secondary: #666666;
  --background-color: #f5f5f5;
  --white: #ffffff;
  --border-color: #e0e0e0;
}

/* 通用按钮样式 */
.btn-primary {
  background-color: var(--primary-color);
  color: var(--white);
  border: none;
  padding: 20rpx 40rpx;
  border-radius: 8rpx;
  font-size: 28rpx;
  font-weight: 500;
}

.btn-primary:active {
  opacity: 0.8;
}

/* 通用卡片样式 */
.card {
  background-color: var(--white);
  border-radius: 12rpx;
  padding: 24rpx;
  margin-bottom: 20rpx;
  box-shadow: 0 2rpx 8rpx rgba(0, 0, 0, 0.05);
}
</style>