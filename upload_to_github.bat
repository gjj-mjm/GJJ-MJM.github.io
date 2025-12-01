@echo off

REM 设置变量
set REPO_URL=https://github.com/yourusername/rural-talent-training.git
set BRANCH=main
set MESSAGE="更新所有课程详情页面：乡村旅游、现代农业技术和传统手工艺"

REM 确保使用正确的编码
chcp 65001

echo 开始上传文件到GitHub仓库...

REM 初始化Git（如果尚未初始化）
if not exist ".git" (
    echo 初始化Git仓库...
    git init
    git config --global user.name "Your Name"
    git config --global user.email "your.email@example.com"
    git remote add origin %REPO_URL%
    echo 仓库初始化完成
)

REM 添加所有HTML文件和相关文件
echo 添加文件到暂存区...
git add *.html

REM 提交更改
echo 提交更改...
git commit -m %MESSAGE%

REM 推送更改
echo 推送到远程仓库...
git push -u origin %BRANCH%

echo 上传完成！
pause