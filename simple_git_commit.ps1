# 简单的Git提交脚本

Write-Host "开始Git提交操作..."

# 设置Git用户名和邮箱（可以根据需要修改）
git config --local user.name "GitHub User"
git config --local user.email "user@example.com"

# 确保远程仓库已配置
git remote remove origin -f 2>$null
git remote add origin git@github.com:gjj-mjm/GJJ-MJM.github.io.git

# 添加所有文件到暂存区
Write-Host "添加所有文件到暂存区..."
git add .

# 显示当前状态
Write-Host "当前Git状态："
git status

# 执行提交
Write-Host "执行提交..."
git commit -m "初始化仓库并添加乡村人才振兴小程序项目文件"

# 推送到远程仓库
Write-Host "推送到GitHub..."
git push -u origin master

Write-Host "Git提交和推送操作完成！"