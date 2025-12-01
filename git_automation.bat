@echo off

:: 检查Git是否可用
echo 检查Git是否可用...
git --version >nul 2>nul
if %errorlevel% neq 0 (
    echo 错误：Git未找到或未正确安装。请确保Git已安装并添加到系统环境变量中。
    pause
    exit /b 1
)

echo Git已安装，开始初始化仓库...

:: 检查是否已初始化Git仓库
if exist ".git" (
    echo Git仓库已存在，跳过初始化步骤
) else (
    echo 初始化新的Git仓库...
    git init
    if %errorlevel% neq 0 (
        echo 错误：Git初始化失败
        pause
        exit /b 1
    )
)

:: 添加.gitignore文件（如果不存在）
if not exist ".gitignore" (
    echo 创建.gitignore文件...
    echo # 忽略node_modules文件夹 >> .gitignore
    echo node_modules/ >> .gitignore
    echo # 忽略dist文件夹 >> .gitignore
    echo dist/ >> .gitignore
    echo # 忽略临时文件 >> .gitignore
    echo *.tmp >> .gitignore
    echo *.temp >> .gitignore
    echo # 忽略日志文件 >> .gitignore
    echo *.log >> .gitignore
    echo # 忽略编辑器配置文件 >> .gitignore
    echo .vscode/ >> .gitignore
    echo .idea/ >> .gitignore
    echo *.suo >> .gitignore
    echo *.ntvs* >> .gitignore
    echo *.njsproj >> .gitignore
    echo *.sln >> .gitignore
    echo *.sw? >> .gitignore
)

:: 添加所有HTML文件
echo 添加HTML文件到Git仓库...
git add *.html
git add x/index.html

:: 添加配置文件
git add package.json
git add taro.config.js

:: 添加Markdown文件
git add *.md

:: 检查是否有需要提交的更改
git status

echo 请按任意键继续进行提交...
pause

:: 设置用户名和邮箱（如果需要）
git config user.name "GitHub User"
git config user.email "user@example.com"

:: 提交更改
echo 提交更改...
git commit -m "添加乡村人才培训课程网站的HTML文件"
if %errorlevel% neq 0 (
    echo 警告：提交失败，可能没有新的更改需要提交
)

echo Git操作完成！
echo 注意：请手动设置远程仓库并推送到GitHub
pause