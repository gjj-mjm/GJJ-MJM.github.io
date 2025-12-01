# Git首次提交脚本

Write-Host "开始Git初始化和首次提交操作..."
Write-Host "当前目录: $(Get-Location)"

# 1. 初始化Git仓库
Write-Host "\n1. 初始化Git仓库..."
git init

# 2. 添加所有文件到暂存区
Write-Host "\n2. 添加所有文件到暂存区..."
git add .

# 3. 显示暂存的文件
Write-Host "\n3. 当前暂存的文件："
git status

# 4. 执行首次提交
Write-Host "\n4. 执行首次提交..."
git commit -m "初始化项目 - 乡村人才小程序项目"

# 5. 显示提交日志
Write-Host "\n5. 显示提交日志："
git log

Write-Host "\nGit首次提交操作完成！"
Write-Host "提示: 请确保已正确配置Git用户信息（用户名和邮箱）"