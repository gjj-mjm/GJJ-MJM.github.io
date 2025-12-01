@echo off

REM 简单的Git上传脚本 - 仅用于联系我们页面
set REPO_URL=https://github.com/yourusername/rural-talent-training.git
set BRANCH=main
set MESSAGE="添加联系我们页面"

echo 开始Git操作...

REM 初始化Git（如果尚未初始化）
if not exist ".git" (
    echo 初始化Git仓库...
    git init
    git config --global user.name "Your Name"
    git config --global user.email "your.email@example.com"
    git remote add origin %REPO_URL%
)

REM 添加联系我们页面
echo 添加联系我们页面...
git add contact_us.html

REM 添加更新的index.html
git add index.html

REM 提交更改
echo 提交更改...
git commit -m %MESSAGE%

REM 推送更改
echo 推送更改...
git push -u origin %BRANCH%

echo 操作完成！
pause