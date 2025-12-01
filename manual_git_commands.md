# 手动执行Git命令指南

由于批处理文件运行时遇到乱码和命令识别问题，我们提供了以下手动执行Git命令的方法，确保您能够成功将代码上传到GitHub。

## 步骤1：打开命令提示符

1. 按 `Win + R` 键打开运行对话框
2. 输入 `cmd` 并按回车
3. 命令提示符窗口将会打开

## 步骤2：导航到项目目录

在命令提示符中输入以下命令并按回车：

```
cd C:\trae
```

## 步骤3：执行Git命令

请按照以下顺序，在命令提示符中逐条输入并执行这些命令：

### 初始化Git仓库（如果尚未初始化）

```
git init
```

### 设置Git用户名和邮箱

```
git config user.name "GJJ-MJM"
git config user.email "1678886973@qq.com"
```

### 设置GitHub远程仓库（使用SSH）

```
git remote add origin git@github.com:gjj-mjm/GJJ-MJM.github.io.git
```

### 添加所有文件

```
git add .
```

### 提交更改

```
git commit -m "更新网站内容"
```

### 推送到GitHub

```
git push -u origin main
```

## 注意事项

1. 请确保每执行完一条命令后，检查是否有错误信息
2. 如果遇到错误，请根据提示进行解决
3. 如果提示找不到git命令，说明Git没有正确安装或未添加到系统环境变量
4. 如果推送时提示权限错误，可能是SSH密钥配置问题

## 故障排除

如果执行 `git push` 时遇到权限问题，请检查：

1. 是否已在GitHub上配置了正确的SSH密钥
2. SSH密钥是否与您的GitHub账户关联
3. 网络连接是否正常

如果需要帮助，请记录下完整的错误信息，以便进一步排查。