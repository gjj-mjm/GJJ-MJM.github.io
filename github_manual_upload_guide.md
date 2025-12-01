# GitHub 手动上传与公开访问指南

## 概述
由于当前系统中未安装Git命令行工具，本指南提供通过GitHub网页界面手动上传文件并配置公开访问的详细步骤。

## 第一部分：在GitHub上创建新仓库

1. **登录GitHub账户**
   - 打开浏览器，访问 [GitHub官网](https://github.com)
   - 使用您的GitHub账号登录

2. **创建新仓库**
   - 点击右上角的"+"图标，选择"New repository"
   - 为仓库命名（建议使用：`rural-talent-training`）
   - 添加简短的仓库描述（可选）
   - 选择仓库可见性：**Public**（公开）
   - 不要勾选"Initialize this repository with a README"（因为我们要上传现有文件）
   - 点击"Create repository"按钮

## 第二部分：上传文件到GitHub仓库

1. **进入上传界面**
   - 创建仓库后，您会看到"Quick setup"页面
   - 滚动到页面底部，找到"Import code"或"Upload files"选项
   - 点击"Upload files"按钮

2. **选择并上传文件**
   - 点击"choose your files"或直接拖放文件到浏览器窗口
   - 从`c:\trae`目录中选择以下文件进行上传：
     - **HTML文件**：
       - `index.html`
       - `rural-tourism-detail.html`
       - `modern-agriculture-detail.html`
       - `traditional-crafts-detail.html`
       - `rural-ecommerce-detail.html`
       - `rural-tourism-course.html`
     - **配置文件**：
       - `package.json`
       - `taro.config.js`
     - **文档文件**：
       - `github_pages_setup_guide.md`

3. **提交更改**
   - 向下滚动到页面底部
   - 在"Commit changes"部分添加提交信息（例如：`Add rural talent training course website files`）
   - 选择"Commit directly to the main branch"
   - 点击"Commit changes"按钮

## 第三部分：配置GitHub Pages实现公开访问

1. **进入仓库设置**
   - 在仓库页面顶部导航栏中，点击"Settings"选项

2. **配置GitHub Pages**
   - 在左侧边栏中找到并点击"Pages"选项
   - 在"Source"部分，点击下拉菜单
   - 选择分支：**main**（或**master**，取决于您的仓库使用的默认分支名）
   - 选择文件夹：**/(root)**
   - 点击"Save"按钮

3. **获取公开访问URL**
   - 保存设置后，页面会自动刷新
   - 在"GitHub Pages"部分，您将看到一个绿色的提示信息，显示"Your site is published at..."
   - 复制提供的URL（格式通常为：`https://[your-username].github.io/[repository-name]/`）

## 第四部分：验证与后续操作

1. **验证网站是否正常访问**
   - 打开新的浏览器标签页
   - 粘贴刚刚获取的URL
   - 按Enter键访问
   - 网站应该能够正常加载`index.html`页面

2. **访问其他页面**
   - 在浏览器地址栏中，在基础URL后添加具体的HTML文件名
   - 例如：`https://[your-username].github.io/[repository-name]/rural-tourism-detail.html`

3. **更新网站内容**
   - 当您需要更新网站内容时，只需重复"第二部分：上传文件到GitHub仓库"的步骤
   - 上传更新后的文件并提交更改
   - GitHub Pages会自动重新构建您的网站（通常需要1-2分钟）

## 注意事项

- GitHub Pages可能需要几分钟时间来构建和发布您的网站
- 确保您的网站包含`index.html`文件，这是GitHub Pages的默认入口页面
- 如果您的网站包含图片或其他资源，请确保文件路径正确（使用相对路径）
- 对于复杂的网站，建议您后续安装Git命令行工具，以便更高效地管理您的代码

## 故障排除

如果您的网站无法访问，请检查以下几点：

1. 确保您选择了正确的分支和文件夹
2. 确认`index.html`文件已成功上传
3. 检查文件权限（通常应为公开可读）
4. 等待几分钟后再次尝试访问（GitHub Pages可能正在构建）

---

当您的系统中安装了Git后，也可以使用我们创建的脚本（`simple_git_setup.bat`）来简化本地仓库的设置过程。