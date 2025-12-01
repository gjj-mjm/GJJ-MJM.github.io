# Git安装和配置指南

## 第一步：下载并安装Git

1. 访问官方Git下载页面：https://git-scm.com/download/win
2. 下载适合你操作系统的64位安装程序
3. 运行安装程序，按照默认选项进行安装
   - 确保勾选"Add Git to PATH"选项，这样Git命令才能在命令行中使用
   - 其余选项保持默认即可
4. 安装完成后，重新启动计算机以确保环境变量生效

## 第二步：验证Git安装

打开PowerShell，运行以下命令验证Git是否正确安装：

```powershell
git --version
```

如果显示Git版本信息，则表示安装成功。

## 第三步：配置Git用户信息

安装完成后，配置你的Git用户名和邮箱：

```powershell
git config --global user.name "你的用户名"
git config --global user.email "你的邮箱@example.com"
```

## 第四步：初始化本地Git仓库

在你的项目目录中初始化Git仓库：

```powershell
cd c:\trae
git init
```

## 第五步：添加文件到暂存区

```powershell
git add .
```

## 第六步：执行首次提交

```powershell
git commit -m "初始化项目"
```

## 第七步：验证提交是否成功

```powershell
git log
```

如果看到提交记录，则表示所有操作都已成功完成！

## 常见问题解决

1. 如果执行Git命令时出现"无法将git识别为命令"的错误：
   - 检查Git是否正确安装
   - 检查环境变量PATH中是否包含Git的安装路径（通常是C:\Program Files\Git\cmd）
   - 尝试重新安装Git并确保勾选了"Add Git to PATH"选项
   - 重新启动计算机

2. 如果提交失败，请确保已正确配置了用户名和邮箱

完成以上步骤后，你就可以正常使用Git来管理你的项目代码了！