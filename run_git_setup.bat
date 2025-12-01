@echo off

echo ====================================
echo Git环境设置快速启动器
echo ====================================
echo.
echo 此批处理文件将帮助您配置Git环境并初始化仓库
echo.

REM 1. 等待用户按任意键继续
echo 按任意键开始...
pause > nul

REM 2. 打开PowerShell并运行Git配置命令
echo 正在配置Git用户信息...
powershell -Command "
# 设置默认的Git用户信息
Write-Host '设置Git用户信息...' -ForegroundColor Green

# 这里设置默认的用户名和邮箱
$defaultUsername = 'rural-talent-user'
$defaultEmail = 'rural-talent@example.com'

# 显示当前配置
try {
    $currentUsername = git config --global user.name
    $currentEmail = git config --global user.email
    
    if ($currentUsername -and $currentEmail) {
        Write-Host '当前Git用户配置:' -ForegroundColor Yellow
        Write-Host "  用户名: $currentUsername"
        Write-Host "  邮箱: $currentEmail"
    } else {
        Write-Host 'Git用户信息未配置，正在设置默认值...' -ForegroundColor Yellow
        git config --global user.name $defaultUsername
        git config --global user.email $defaultEmail
        Write-Host '已设置默认Git用户信息:' -ForegroundColor Green
        Write-Host "  用户名: $defaultUsername"
        Write-Host "  邮箱: $defaultEmail"
    }
} catch {
    Write-Host '无法配置Git用户信息，请确保Git已正确安装' -ForegroundColor Red
}

# 3. 初始化Git仓库
echo "\n初始化Git仓库..." -ForegroundColor Green
try {
    git init
    git add .
    git commit -m "初始化项目 - 乡村人才小程序项目"
    Write-Host "\nGit仓库初始化成功！" -ForegroundColor Green
    
    # 4. 显示提交日志
    echo "\n提交日志:" -ForegroundColor Yellow
    git log
} catch {
    Write-Host 'Git操作失败，请确保Git已正确安装' -ForegroundColor Red
}

Write-Host "\n====================================" -ForegroundColor White
Write-Host "操作完成！请按任意键退出..." -ForegroundColor Green
Read-Host
""
pause