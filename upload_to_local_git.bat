@echo off

REM 简单的Git本地仓库上传批处理脚本
REM 双击运行即可完成Git仓库初始化和文件提交

color 0A
echo ========================================
echo       Git本地仓库上传一键脚本        
echo ========================================
echo.

REM 检查Git是否安装
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo 错误: 未找到Git! 请先安装Git
    echo 您可以从 https://git-scm.com/download/win 下载安装
    pause
    exit /b 1
)

REM 显示Git版本
echo Git已安装，版本信息:
git --version
echo.

REM 设置Git用户信息
set /p userName="请输入您的Git用户名 (默认为'rural-talent-user'): "
if "%userName%"=="" set userName=rural-talent-user

set /p userEmail="请输入您的Git邮箱 (默认为'rural-talent@example.com'): "
if "%userEmail%"=="" set userEmail=rural-talent@example.com

echo 设置Git用户信息...
git config --global user.name "%userName%"
git config --global user.email "%userEmail%"
echo Git用户信息设置完成!
echo.

REM 初始化Git仓库
echo 初始化Git仓库...
git init
if %errorlevel% neq 0 (
    echo 错误: 初始化Git仓库失败!
    pause
    exit /b 1
)
echo Git仓库初始化成功!
echo.

REM 检查.gitignore文件是否存在
if not exist .gitignore (
    echo 创建.gitignore文件...
    echo # 日志文件 > .gitignore
    echo *.log >> .gitignore
    echo npm-debug.log* >> .gitignore
    echo yarn-debug.log* >> .gitignore
    echo yarn-error.log* >> .gitignore
    echo pnpm-debug.log* >> .gitignore
    echo lerna-debug.log* >> .gitignore
    echo .DS_Store >> .gitignore
    echo node_modules >> .gitignore
    echo dist >> .gitignore
    echo .vscode >> .gitignore
    echo .idea >> .gitignore
    echo *.suo >> .gitignore
    echo *.ntvs* >> .gitignore
    echo *.njsproj >> .gitignore
    echo *.sln >> .gitignore
    echo *.sw? >> .gitignore
    echo .env >> .gitignore
    echo .env.local >> .gitignore
    echo .env.*.local >> .gitignore
    echo.
)

echo 添加文件到暂存区...
git add .
if %errorlevel% neq 0 (
    echo 错误: 添加文件到暂存区失败!
    pause
    exit /b 1
)
echo 文件添加成功!
echo.

REM 提交文件
echo 提交文件到本地仓库...
git commit -m "初始化项目 - 乡村人才小程序项目"
if %errorlevel% neq 0 (
    echo 错误: 提交文件失败!
    pause
    exit /b 1
)
echo 文件提交成功!
echo.

REM 显示提交历史
echo 提交历史:
git log --oneline
echo.
echo ========================================
echo Git本地仓库上传完成!
echo 您的项目已成功初始化并提交到本地仓库。
echo 如需推送到远程仓库，请使用相关Git命令。
echo ========================================

pause