# 简单的Git上传PowerShell脚本
$ErrorActionPreference = "Stop"

Write-Host "开始Git操作..."

# 设置变量
$REPO_URL = "https://github.com/yourusername/rural-talent-training.git"
$BRANCH = "main"
$MESSAGE = "更新所有课程详情页面"

# 初始化Git（如果尚未初始化）
if (-not (Test-Path ".git")) {
    Write-Host "初始化Git仓库..."
    git init
    git config --global user.name "Your Name"
    git config --global user.email "your.email@example.com"
    git remote add origin $REPO_URL
}

# 添加所有HTML文件
Write-Host "添加文件..."
git add *.html

# 提交更改
Write-Host "提交更改..."
git commit -m $MESSAGE

# 推送更改
Write-Host "推送更改..."
git push -u origin $BRANCH

Write-Host "操作完成！"