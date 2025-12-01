@echo off

:: 显示SSH公钥内容的批处理脚本

cls
echo ============================
echo 显示SSH公钥工具
echo ============================

echo.
echo 正在查找SSH公钥文件...

:: 检查ed25519格式的公钥
if exist "%USERPROFILE%\.ssh\id_ed25519.pub" (
    echo 找到ED25519格式公钥文件
    echo.
    echo 公钥内容：
    echo ----------------------------------------
    type "%USERPROFILE%\.ssh\id_ed25519.pub"
    echo ----------------------------------------
    echo.
    echo 请复制上面显示的完整公钥内容（从ssh-ed25519开始到邮箱结束）
    echo 然后粘贴到GitHub的SSH key页面中
    echo.
    echo 公钥已经成功生成！您可以继续按照github_upload_guide.md的第5步操作。
) else (
    :: 检查RSA格式的公钥
    if exist "%USERPROFILE%\.ssh\id_rsa.pub" (
        echo 找到RSA格式公钥文件
        echo.
        echo 公钥内容：
        echo ----------------------------------------
        type "%USERPROFILE%\.ssh\id_rsa.pub"
        echo ----------------------------------------
        echo.
        echo 请复制上面显示的完整公钥内容（从ssh-rsa开始到邮箱结束）
        echo 然后粘贴到GitHub的SSH key页面中
    ) else (
        echo 错误：未找到SSH公钥文件
        echo 请先运行generate_ssh_key.bat生成SSH密钥
    )
)

echo.
echo ===========================================
echo 注意事项：
1. 请确保复制完整的公钥内容，不要遗漏任何字符
2. 不要包含输出中的任何其他文本
3. 在GitHub页面粘贴公钥后，点击"Add SSH key"完成配置
echo ===========================================

pause