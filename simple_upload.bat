@echo off

REM 简单的GitHub上传脚本
echo 开始上传到GitHub...

REM 检查Git是否安装
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo 错误：未找到Git
    pause
    exit /b 1
)

REM 设置仓库地址
set GITHUB_REPO=git@github.com:gjj-mjm/GJJ-MJM.github.io.git

REM 初始化Git（如果需要）
if not exist .git (
    git init
    git config --local user.name "GJJ-MJM"
    git config --local user.email "your_email@example.com"
    git remote add origin %GITHUB_REPO%
)

REM 基本Git操作
git add .
git commit -m "更新内容" 2>nul || echo 没有更改

REM 推送
echo 推送到GitHub...
git push origin main

if %errorlevel% equ 0 (
    echo 上传成功！
) else (
    echo 上传失败，请检查SSH密钥配置
)

pause