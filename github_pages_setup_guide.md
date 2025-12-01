# GitHub Pages 设置指南

本文档将指导您如何配置GitHub Pages，使您的乡村旅游服务与管理课程网站可以公开访问。

## 步骤一：访问GitHub仓库设置

1. 登录您的GitHub账号
2. 导航到您的仓库页面（`https://github.com/yourusername/rural-talent-training`）
3. 点击页面顶部导航栏中的 **Settings** 选项卡

## 步骤二：配置GitHub Pages

1. 在Settings页面左侧导航栏中，找到并点击 **Pages** 选项
2. 在 **Build and deployment** 部分：
   - **Source**: 选择 `Deploy from a branch`
   - **Branch**: 从下拉菜单中选择 `main`（或您用于存放网站文件的分支）
   - 目录选择 `/(root)`
3. 点击 **Save** 按钮保存设置

## 步骤三：等待部署完成

GitHub会自动为您的仓库构建和部署GitHub Pages网站。这个过程通常需要1-2分钟。您可以在GitHub Pages部分看到部署状态。

## 步骤四：获取公开访问URL

部署完成后，GitHub会在Pages页面顶部显示您的网站URL，格式通常为：
`https://yourusername.github.io/rural-talent-training/`

## 步骤五：验证网站访问

1. 复制生成的URL并在浏览器中打开
2. 验证您的网站是否正常显示，特别是乡村旅游服务与管理课程的详情页面
3. 测试所有页面链接是否正常工作

## 高级设置（可选）

### 自定义域名

如果您有自己的域名，可以在GitHub Pages设置中配置自定义域名：

1. 在 **Custom domain** 部分，输入您的自定义域名
2. 点击 **Save**
3. 然后在您的域名注册商处，添加相应的DNS记录指向GitHub Pages服务器

### HTTPS设置

GitHub Pages默认提供HTTPS支持。确保在设置页面勾选 **Enforce HTTPS** 选项，以确保访问者使用加密连接访问您的网站。

## 常见问题解决

### 网站未更新
如果您推送了新的更改，但GitHub Pages网站没有更新：
- 等待几分钟，GitHub Pages的更新可能会有延迟
- 检查是否有构建错误（可以在Actions标签页查看）

### 页面显示404错误
- 确保您的仓库中包含index.html文件
- 检查文件路径是否正确
- 验证您选择了正确的分支和目录

### 图片或资源无法加载
- 确保使用相对路径引用资源（如 `images/logo.png` 而不是绝对路径）
- 检查文件权限设置

## 后续维护

每次您对网站内容进行更改并推送到GitHub仓库后，GitHub Pages会自动重新构建和部署您的网站。您无需手动触发部署。

---

完成以上步骤后，您的乡村旅游服务与管理课程网站将可以通过GitHub Pages公开访问。如有任何问题，请参考GitHub官方文档或联系技术支持。