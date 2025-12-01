@echo off

REM 最简化的Git提交批处理文件
REM 不使用复杂变量或逻辑，仅包含基本Git命令

echo 开始Git提交过程...

REM 检查Git是否安装
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo 错误：未找到Git。请先安装Git。
    pause
    exit /b 1
)

echo Git已找到，继续执行...

REM 设置用户名和邮箱（如果需要可以取消注释并修改）
REM git config --global user.name "Your Name"
REM git config --global user.email "your.email@example.com"

REM 初始化Git仓库（如果需要）
git init

REM 添加远程仓库（如果需要可以取消注释并修改URL）
git remote add origin git@github.com:gjj-mjm/GJJ-MJM.github.io.git

REM 拉取最新代码
git pull origin main --allow-unrelated-histories

REM 添加所有文件
echo 添加所有文件到暂存区...
git add .

REM 提交更改
echo 提交更改...
git commit -m "更新网站内容"

REM 推送到远程仓库
echo 推送到GitHub...
git push -u origin main

echo Git提交过程完成！
pause