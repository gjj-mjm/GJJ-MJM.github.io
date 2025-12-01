# GitHub代码上传指南

## 准备工作

在使用`upload_to_github.bat`之前，请确保您已完成以下准备工作：

### 1. 安装Git
- 如果尚未安装Git，请从 [Git官网](https://git-scm.com/) 下载并安装
- 安装过程中选择默认选项即可

### 2. 配置GitHub访问权限

#### 方式一：使用HTTPS（简单但需要每次输入密码）
- 无需额外配置，脚本会使用HTTPS URL连接GitHub
- 首次推送时会弹出GitHub登录窗口，请输入您的GitHub账号密码

#### 方式二：配置SSH密钥（推荐，一次配置永久使用）
1. 打开Git Bash（在Windows开始菜单中搜索"Git Bash"）
   - Windows开始菜单位置：点击任务栏左下角的Windows图标按钮（四个方块图标），或者使用键盘快捷键 `Win键`
   - 打开后在搜索框中输入"Git Bash"，然后点击搜索结果中的Git Bash应用程序
2. 执行以下命令生成SSH密钥（按Enter使用默认路径）：
   ```
   ssh-keygen -t ed25519 -C "您的邮箱地址"
   ```
   - 执行命令后，会提示输入保存位置，直接按Enter使用默认路径
   - 然后会提示输入密码（可选），如果不想设置密码可以直接按Enter
   - 再次确认密码，同样可以直接按Enter
3. 执行以下命令复制SSH公钥：
   ```
   cat ~/.ssh/id_ed25519.pub
   ```
   - 如果成功显示以"ssh-ed25519"开头的一长串字符，说明公钥已成功生成
   - 示例成功输出：
     ```
     ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIHfwjTELstp6Mrn0nKX1czNFhtFbYnXiTSn00jT0bj 1678886973@qq.com
     ```
   - 如果出现错误提示"No such file or directory"，表示密钥文件不存在，请确认您已正确执行了步骤2的密钥生成命令
   - 如果使用旧版Git，可能生成的是RSA密钥，可以尝试以下命令：
     ```
     cat ~/.ssh/id_rsa.pub
     ```
4. 登录GitHub，进入 Settings > SSH and GPG keys > New SSH key
   - 在GitHub页面右上角，点击您的头像或个人资料图标（通常是圆形图标）
   - 在下拉菜单中，选择"Settings"（设置）选项
   - 在左侧导航栏中，找到并点击"SSH and GPG keys"选项
   - 在SSH keys页面的右上角，点击绿色的"New SSH key"按钮
5. 粘贴刚才复制的公钥，点击"Add SSH key"
   - 公钥指的是：在Git Bash中通过`cat ~/.ssh/id_ed25519.pub`命令显示的所有内容
   - 有效的SSH公钥特征：
     - 以"ssh-ed25519"开头（对于使用ed25519算法生成的密钥）
     - 中间是一段很长的随机字符序列
     - 最后通常包含您的邮箱地址
     - 示例格式：`ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIHfwjTELstp6Mrn0nKX1czNFhtFbYnXiTSn00jT0bj 邮箱地址`
   - 在GitHub页面操作步骤：
     1. 在"Title"输入框中，给这个SSH密钥起一个名称（例如"我的Windows电脑"）
     2. 在"Key type"下拉菜单中，选择"Authentication Key"（这是默认选项）
     3. 在"Key"文本框中，粘贴您从Git Bash复制的完整公钥内容
     4. 点击页面底部的绿色"Add SSH key"按钮完成添加
6. 修改`upload_to_github.bat`中的仓库URL为SSH格式：
   - 操作步骤：
     1. 在Windows文件资源管理器中找到`upload_to_github.bat`文件
     2. 右键点击该文件，选择"编辑"或"用记事本打开"
     3. 在文件中找到`set GITHUB_REPO=`这一行
     4. 将HTTPS格式的URL替换为SSH格式：
        ```
        set GITHUB_REPO=git@github.com:gjj-mjm/GJJ-MJM.github.io.git
        ```
     5. 保存文件并关闭编辑器
   - 这样设置后，Git将使用SSH密钥进行身份验证，无需每次都输入密码

## 使用方法

1. 双击运行 `upload_to_github.bat` 批处理文件
2. 脚本会自动执行以下操作：
   - 检查Git是否安装
   - 初始化Git仓库（如果尚未初始化）
   - 添加远程仓库
   - 拉取远程内容（避免冲突）
   - 添加所有文件
   - 提交更改
   - 推送到GitHub

3. 查看执行结果：
   - 如果成功，会显示访问网站的URL
   - 如果失败，会提示可能的原因和解决方案

## 常见问题解决

### 1. 推送失败提示权限错误
- 检查您的GitHub账号是否有该仓库的写入权限
- 尝试配置SSH密钥

### 2. 推送失败提示冲突
- 先从GitHub拉取最新代码
- 手动解决冲突后再推送

### 3. 网站访问问题
- GitHub Pages通常需要几分钟来更新
- 确保HTML文件位于仓库根目录
- 检查仓库设置中的GitHub Pages配置

## 访问您的网站

成功上传后，您可以通过以下URL访问您的网站：
- 主页：https://gjj-mjm.github.io
- 特定HTML文件：https://gjj-mjm.github.io/[文件名].html

祝您使用愉快！