# 简化的Git上传脚本 - 避免编码问题
$REPO_URL = "https://github.com/yourusername/rural-talent-training.git"
$BRANCH = "main"
$MESSAGE = "添加联系我们页面"

Write-Output "开始Git操作..."

# 初始化Git（如果尚未初始化）
if (-not (Test-Path ".git")) {
    Write-Output "初始化Git仓库..."
    git init
    git config --global user.name "Your Name"
    git config --global user.email "your.email@example.com"
    git remote add origin $REPO_URL
}

# 添加文件
Write-Output "添加文件..."
git add contact_us.html
git add index.html

# 提交更改
Write-Output "提交更改..."
git commit -m $MESSAGE

# 推送更改
Write-Output "推送更改..."
git push -u origin $BRANCH

Write-Output "操作完成！"