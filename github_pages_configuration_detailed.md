# GitHub Pages 详细配置指南

## 目标
本指南将详细介绍如何配置GitHub Pages，使您的乡村人才培训课程网站能够通过互联网公开访问。

## 前提条件
- 已在GitHub上创建了仓库
- 已将所有HTML文件上传到仓库
- 确保仓库包含`index.html`作为主页

## 步骤一：访问仓库设置

1. **打开GitHub仓库页面**
   - 使用浏览器访问您的GitHub仓库
   - 确保您已登录GitHub账户

2. **进入设置页面**
   - 在仓库页面顶部导航栏中，点击"Settings"选项卡
   
   ![进入设置页面](https://docs.github.com/assets/cb-36277/mw-1000/images/help/repository/repo-actions-settings.webp)

## 步骤二：配置GitHub Pages

1. **导航到Pages设置**
   - 在左侧边栏中，向下滚动找到"Pages"选项并点击
   
   ![Pages设置位置](https://docs.github.com/assets/cb-15865/mw-1000/images/help/pages/pages-tab.webp)

2. **选择发布源**
   - 在"Source"（发布源）部分，点击下拉菜单
   - **选择分支**：通常为 `main` 或 `master`
   - **选择文件夹**：选择 `/(root)` 根目录
   - 点击"Save"按钮保存设置
   
   ![选择发布源](https://docs.github.com/assets/cb-53455/mw-1000/images/help/pages/publishing-source-drop-down.webp)

3. **等待部署完成**
   - 保存设置后，GitHub将开始构建您的网站
   - 页面顶部会显示一个临时消息："Your site is ready to be published at..."
   - 构建通常需要1-2分钟完成
   - 构建完成后，消息会变成绿色："Your site is published at [URL]"

## 步骤三：获取公开访问URL

1. **复制公开URL**
   - 配置成功后，您会在GitHub Pages设置页面看到一个绿色的成功消息
   - 消息中包含您的网站公开访问地址（URL）
   - 地址格式通常为：`https://[您的GitHub用户名].github.io/[仓库名]/`
   - 复制这个URL以便后续使用
   
   ![获取公开URL](https://docs.github.com/assets/cb-27608/mw-1000/images/help/pages/site-url.webp)

## 步骤四：验证网站访问

1. **访问网站首页**
   - 打开新的浏览器标签页
   - 粘贴您刚才复制的URL
   - 按Enter键访问
   - 您应该能看到网站的首页（index.html）

2. **测试其他页面**
   - 尝试访问其他HTML页面，例如：
     - `https://[用户名].github.io/[仓库名]/rural-tourism-detail.html`
     - `https://[用户名].github.io/[仓库名]/modern-agriculture-detail.html`
     - 确保所有页面都能正常访问

3. **测试导航链接**
   - 在网站首页点击各个"了解详情"按钮
   - 确认能正确跳转到对应的详情页面

## 高级设置（可选）

1. **自定义域名**（可选）
   - 如果您有自己的域名，可以在GitHub Pages设置中配置
   - 在"Custom domain"部分输入您的域名
   - 点击"Save"按钮
   - 然后需要在您的域名注册商处设置DNS记录

2. **HTTPS加密**
   - GitHub Pages默认支持HTTPS
   - 确保"Enforce HTTPS"选项已被勾选
   - 这样访问者将始终通过安全连接访问您的网站

## 常见问题与解决方案

### 问题1：网站显示404错误

**可能原因**：
- 未上传`index.html`文件
- 选择了错误的分支或文件夹
- GitHub Pages构建尚未完成

**解决方案**：
- 确认`index.html`已成功上传到仓库
- 检查GitHub Pages设置中的分支和文件夹选择是否正确
- 等待几分钟后刷新页面重试

### 问题2：页面样式丢失

**可能原因**：
- CSS文件路径引用错误
- 资源文件未上传或路径不正确

**解决方案**：
- 确保所有CSS、图片等资源文件都已上传
- 使用相对路径引用资源文件（例如：`./styles.css`而不是`http://example.com/styles.css`）

### 问题3：网站更新后未显示最新内容

**可能原因**：
- 浏览器缓存问题
- GitHub Pages缓存
- 构建延迟

**解决方案**：
- 尝试使用Ctrl+F5强制刷新浏览器页面
- 等待几分钟让GitHub Pages完成构建
- 在GitHub Pages设置页查看构建状态

## 维护与更新

1. **更新网站内容**
   - 当您需要更新网站内容时，只需修改并重新上传相应文件
   - GitHub Pages会自动检测到更改并重新构建网站
   - 构建通常在几分钟内完成

2. **监控构建状态**
   - 对于较大的更改，可以在Actions选项卡中查看构建状态
   - 确保每次更新后构建都成功完成

## 安全考虑

- 确保不将敏感信息（如API密钥、密码等）上传到GitHub仓库
- 定期检查和更新网站内容
- 考虑启用Google Analytics等工具来监控网站访问情况

## 总结

通过以上步骤，您的乡村人才培训课程网站将能够通过GitHub Pages在互联网上公开访问。GitHub Pages提供了一个免费、简单的方式来托管静态网站，非常适合展示教育资源和课程信息。

如果您在配置过程中遇到任何问题，可以参考[GitHub Pages官方文档](https://docs.github.com/cn/pages)获取更多帮助。