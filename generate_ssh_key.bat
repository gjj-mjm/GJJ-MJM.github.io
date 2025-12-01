@echo off

:: 生成SSH密钥并显示公钥的批处理脚本

cls
echo ============================
echo SSH密钥生成工具
echo ============================

echo.
echo 检查Git是否安装...
git --version > nul 2>&1
if %errorlevel% neq 0 (
    echo 错误：未找到Git。请先安装Git后再运行此脚本。
    echo 您可以从 https://git-scm.com/ 下载并安装Git。
    pause
    exit /b 1
)

echo.
echo 开始生成SSH密钥...
echo 提示：所有提示都可以直接按Enter使用默认值

echo.
echo 正在执行SSH密钥生成命令...
setlocal enabledelayedexpansion

:: 使用Git Bash执行SSH密钥生成命令
for /f "tokens=*" %%a in ('where git') do set GIT_PATH=%%~dpa
echo 使用Git路径：%GIT_PATH%

:: 执行SSH密钥生成
call "%GIT_PATH%usr\bin\ssh-keygen.exe" -t ed25519 -C "%USERNAME%@%COMPUTERNAME%.local"

:: 检查密钥是否生成成功
if exist "%USERPROFILE%\.ssh\id_ed25519.pub" (
    echo.
    echo 成功：SSH密钥已生成！
    echo.
    echo 以下是您的公钥内容（请复制并粘贴到GitHub）：
    echo -------------------------------------------------
    type "%USERPROFILE%\.ssh\id_ed25519.pub"
    echo -------------------------------------------------
    echo.
    echo 注意：请复制上面的完整公钥内容（从ssh-ed25519开始到邮箱结束）
    echo 然后粘贴到GitHub的SSH key页面中。
) else if exist "%USERPROFILE%\.ssh\id_rsa.pub" (
    echo.
    echo 成功：SSH RSA密钥已生成！
    echo.
    echo 以下是您的RSA公钥内容（请复制并粘贴到GitHub）：
    echo -------------------------------------------------
    type "%USERPROFILE%\.ssh\id_rsa.pub"
    echo -------------------------------------------------
    echo.
    echo 注意：请复制上面的完整公钥内容（从ssh-rsa开始到邮箱结束）
    echo 然后粘贴到GitHub的SSH key页面中。
) else (
    echo.
    echo 错误：SSH密钥文件未生成。请检查上面的错误信息。
    echo 可能是您在生成过程中取消了操作。
)

echo.
echo ===========================================
echo 使用说明：
1. 复制上面显示的完整公钥内容
2. 登录GitHub，进入Settings > SSH and GPG keys
3. 点击"New SSH key"，粘贴公钥内容
4. 点击"Add SSH key"完成配置
echo ===========================================

pause