# 完整的Git提交和推送脚本

# 设置Git路径到环境变量
Write-Host "设置Git路径..."
$env:PATH = "C:\Program Files\Git\bin;C:\Program Files\Git\cmd;$env:PATH"

# 验证Git安装
Write-Host "\n检查Git版本..."
git --version

# 设置Git用户信息（可以根据需要修改）
Write-Host "\n设置Git用户信息..."
git config --local user.name "GitHub User"
git config --local user.email "user@example.com"

# 确保远程仓库配置正确
Write-Host "\n确保远程仓库配置正确..."
git remote remove origin -f 2>$null
git remote add origin git@github.com:gjj-mjm/GJJ-MJM.github.io.git
git remote -v

# 添加所有文件到暂存区
Write-Host "\n添加所有文件到暂存区..."
git add .

# 显示当前状态
Write-Host "\n当前Git状态："
git status

# 执行提交
Write-Host "\n执行提交..."
git commit -m "初始化仓库并添加乡村人才振兴小程序项目文件"

# 推送到远程仓库
Write-Host "\n推送到GitHub..."
git push -u origin master

Write-Host "\nGit操作完成！"
Write-Host "请检查GitHub仓库以确认文件是否成功上传。"