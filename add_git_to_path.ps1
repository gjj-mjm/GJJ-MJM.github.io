# 临时将Git添加到环境变量脚本

Write-Host "Adding Git to PATH temporarily..."

# 设置Git安装目录路径
$gitPath = "C:\Program Files\Git\bin"
$gitCmdPath = "C:\Program Files\Git\cmd"

# 检查路径是否存在
if (Test-Path $gitPath -and Test-Path $gitCmdPath) {
    # 添加Git到当前会话的PATH环境变量
    $env:PATH = "$gitPath;$gitCmdPath;$env:PATH"
    
    Write-Host "Git paths added to PATH successfully!"
    Write-Host "Current PATH: $env:PATH"
    
    # 验证Git是否可以访问
    Write-Host "\nChecking Git version..."
    git --version
    
    Write-Host "\nNow you can use Git commands directly in this PowerShell session."
    Write-Host "To make this permanent, you should add Git to your system environment variables."
} else {
    Write-Host "Error: Git installation not found at expected location."
    Write-Host "Please verify your Git installation path."
}