# Git配置故障排除指南

## 为什么会出现"无法识别"的错误？

当您运行 `.\setup_git_user.ps1` 时出现的错误通常有以下几个原因：

1. **PowerShell执行策略限制** - Windows默认限制PowerShell脚本的执行
2. **文件路径问题** - 当前工作目录可能不正确
3. **脚本权限问题** - 脚本文件可能没有执行权限

## 解决方案

### 方案一：使用批处理文件（推荐）

我已经为您创建了一个更简单的批处理文件 `run_git_setup.bat`，您可以：

1. 在文件资源管理器中导航到 `c:\trae` 目录
2. 双击 `run_git_setup.bat` 文件运行
3. 按照提示完成Git配置

### 方案二：手动在PowerShell中执行Git命令

打开PowerShell，直接运行以下命令：

```powershell
# 1. 设置Git用户信息
git config --global user.name "您的用户名"
git config --global user.email "您的邮箱@example.com"

# 2. 初始化Git仓库
cd c:\trae
git init

# 3. 添加文件
git add .

# 4. 提交更改
git commit -m "初始化项目"
```

### 方案三：更改PowerShell执行策略

如果您确实想运行PowerShell脚本：

```powershell
# 以管理员身份打开PowerShell，然后运行：
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

# 然后再尝试运行脚本：
cd c:\trae
.\setup_git_user.ps1
```

## 检查Git是否已正确安装

如果以上方法都不工作，请确保Git已正确安装：

1. 打开命令提示符（CMD）
2. 运行 `git --version`
3. 如果显示版本信息，则Git已安装；否则需要安装Git

## 常见错误及其解决方法

1. **"git不是内部或外部命令"** - Git未安装或未添加到PATH环境变量
2. **"无法初始化仓库"** - 可能需要管理员权限
3. **"提交失败"** - 确保已正确配置用户信息

如果您仍然遇到问题，请参考 `git_setup_guide.md` 文件中的详细安装指南。