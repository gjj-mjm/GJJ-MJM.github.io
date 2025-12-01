@echo off

echo 开始上传到GitHub...

rem 检查Git是否安装
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo 错误：未找到Git，请先安装Git
    pause
    exit /b 1
)

rem 设置仓库地址
set repo=git@github.com:gjj-mjm/GJJ-MJM.github.io.git

echo 检查Git仓库...
if not exist .git (
    echo 初始化Git仓库...
    git init
    git config user.name "GJJ-MJM"
    git config user.email "1678886973@qq.com"
)

echo 设置远程仓库...
git remote remove origin 2>nul
set remote_exists=false
for /f "tokens=*" %%a in ('git remote') do if "%%a"=="origin" set remote_exists=true
if %remote_exists%==false (
    git remote add origin %repo%
)

echo 添加文件...
git add .

echo 提交更改...
git commit -m "更新网站内容" 2>nul || echo 没有更改

echo 推送到GitHub...
git push -u origin main

echo 完成！请检查是否成功上传。
pause