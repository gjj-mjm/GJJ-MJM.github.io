# Git用户信息配置脚本
# 请根据需要修改以下用户名和邮箱

$username = "YourUsername"
$email = "your.email@example.com"

Write-Host "配置Git用户信息..."
Write-Host "用户名: $username"
Write-Host "邮箱: $email"

# 设置全局Git用户名
Write-Host "\n正在设置用户名..."
git config --global user.name "$username"

# 设置全局Git邮箱
Write-Host "\n正在设置邮箱..."
git config --global user.email "$email"

# 验证配置是否成功
Write-Host "\n验证配置是否成功..."
Write-Host "用户名设置: $(git config --global user.name)"
Write-Host "邮箱设置: $(git config --global user.email)"

Write-Host "\nGit用户信息配置完成！"
Write-Host "提示: 请先确保Git已正确安装并添加到PATH中"