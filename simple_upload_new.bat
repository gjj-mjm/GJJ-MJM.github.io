@echo off

REM 上传代码到GitHub仓库的简化批处理文件
REM 使用正确的编码格式，避免乱码问题

echo 开始将代码上传到GitHub仓库...

REM 检查Git是否安装
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo 错误：未找到Git，请确保已正确安装Git并添加到系统环境变量中。
    pause
    exit /b 1
)

REM 设置GitHub仓库地址（SSH格式）
set GITHUB_REPO=git@github.com:gjj-mjm/GJJ-MJM.github.io.git

REM 初始化Git（如果尚未初始化）
if not exist .git (
    echo 初始化Git仓库...
    git init
    git config --local user.name "GJJ-MJM"
    git config --local user.email "1678886973@qq.com"
    echo Git仓库已初始化
)

REM 添加或更新远程仓库
set remote_exists=false
for /f "tokens=*" %%a in ('git remote') do (
    if "%%a"=="origin" (
        set remote_exists=true
    )
)

if not %remote_exists%==true (
    echo 添加GitHub远程仓库...
    git remote add origin %GITHUB_REPO%
) else (
    echo 更新远程仓库地址...
    git remote set-url origin %GITHUB_REPO%
)

REM 拉取远程内容（可选）
git pull origin main --allow-unrelated-histories 2>nul || echo 远程仓库可能为空，跳过拉取

REM 添加所有文件
echo 添加文件到Git...
git add .

REM 提交更改
git commit -m "更新网站内容" 2>nul || echo 没有更改需要提交

REM 推送到GitHub
echo 推送到GitHub...
git push -u origin main

if %errorlevel% equ 0 (
    echo 成功：代码已上传到GitHub仓库！
    echo 请访问 https://gjj-mjm.github.io 查看您的网站
) else (
    echo 错误：上传失败，请检查：
    echo 1. SSH密钥是否正确配置
    echo 2. 网络连接是否正常
    echo 3. 仓库URL是否正确
)

pause