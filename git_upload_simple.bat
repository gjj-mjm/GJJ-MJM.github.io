@echo off

REM 简单的Git上传脚本
set REPO_URL=https://github.com/yourusername/rural-talent-training.git
set BRANCH=main
set MESSAGE="更新所有课程详情页面"

echo 开始Git操作...

REM 初始化Git（如果尚未初始化）
if not exist ".git" (
    echo 初始化Git仓库...
    git init
    git config --global user.name "Your Name"
    git config --global user.email "your.email@example.com"
    git remote add origin %REPO_URL%
)

REM 添加所有文件
echo 添加文件...
git add *.html

REM 提交更改
echo 提交更改...
git commit -m %MESSAGE%

REM 推送更改
echo 推送更改...
git push -u origin %BRANCH%

echo 操作完成！
pause