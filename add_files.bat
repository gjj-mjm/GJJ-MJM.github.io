@echo off

echo 开始添加HTML文件到Git仓库...

REM 检查Git是否可用
where git > nul 2> nul
if %errorlevel% neq 0 (
    echo 错误: 未找到Git命令。请确保Git已安装并添加到环境变量中。
    exit /b 1
)

REM 尝试添加HTML文件
git add index.html rural-tourism-detail.html modern-agriculture-detail.html traditional-crafts-detail.html rural-ecommerce-detail.html

if %errorlevel% eq 0 (
    echo 文件添加成功！
    echo 检查已添加的文件:
    git status
    exit /b 0
) else (
    echo 文件添加失败，请检查错误信息。
    exit /b 1
)