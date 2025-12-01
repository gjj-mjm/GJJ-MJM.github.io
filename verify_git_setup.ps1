# Git安装和配置验证脚本

Write-Host "================================================="
Write-Host "Git环境验证工具"
Write-Host "================================================="

# 1. 检查Git是否安装
Write-Host "\n1. 检查Git是否安装..."
try {
    $gitVersion = git --version
    Write-Host "✅ Git已安装: $gitVersion"
} catch {
    Write-Host "❌ Git未安装或未添加到环境变量中"
    Write-Host "请参考git_setup_guide.md文件进行Git安装"
    exit 1
}

# 2. 检查Git用户配置
Write-Host "\n2. 检查Git用户配置..."
$userName = git config --global user.name
$userEmail = git config --global user.email

if ($userName -and $userEmail) {
    Write-Host "✅ Git用户信息已配置:"
    Write-Host "   用户名: $userName"
    Write-Host "   邮箱: $userEmail"
} else {
    Write-Host "❌ Git用户信息未配置"
    Write-Host "请运行setup_git_user.ps1脚本配置用户信息"
}

# 3. 检查当前目录是否有Git仓库
Write-Host "\n3. 检查Git仓库..."
if (Test-Path .git) {
    Write-Host "✅ 当前目录已有Git仓库"
    
    # 4. 检查是否有提交记录
    Write-Host "\n4. 检查提交记录..."
    try {
        $commitCount = git rev-list --count HEAD
        if ($commitCount -gt 0) {
            Write-Host "✅ 仓库已有提交记录，共 $commitCount 次提交"
            Write-Host "\n最近的提交信息:"
            git log -n 1 --oneline
        } else {
            Write-Host "❌ 仓库尚未有提交记录"
            Write-Host "请运行initial_commit.ps1脚本执行首次提交"
        }
    } catch {
        Write-Host "❌ 仓库尚未有提交记录"
        Write-Host "请运行initial_commit.ps1脚本执行首次提交"
    }
} else {
    Write-Host "❌ 当前目录没有Git仓库"
    Write-Host "请运行initial_commit.ps1脚本初始化仓库并提交"
}

Write-Host "\n================================================="
Write-Host "验证完成！请根据以上提示完成相应操作。"