# 简单的PowerShell脚本，将HTML文件添加到Git仓库

Write-Host "开始添加HTML文件到Git仓库..."

# 检查Git是否已安装
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "错误: 未找到Git命令。请确保Git已安装并添加到环境变量中。"
    exit 1
}

# 添加所有HTML文件
try {
    Write-Host "添加index.html和课程详情页文件..."
    git add index.html rural-tourism-detail.html modern-agriculture-detail.html traditional-crafts-detail.html rural-ecommerce-detail.html
    Write-Host "文件添加成功！"
    
    # 检查添加的文件
    Write-Host "已添加的文件:"
    git status
    
    exit 0
}
catch {
    Write-Host "错误: 文件添加失败: $_"
    exit 1
}