import os
import subprocess

# 配置信息
repo_url = "https://github.com/yourusername/rural-talent-training.git"
branch = "main"
message = "添加联系我们页面"

def run_command(command):
    """执行命令并返回结果，处理不同编码"""
    print(f"执行: {command}")
    try:
        # 先尝试utf-8编码
        result = subprocess.run(command, shell=True, check=True, 
                               stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        try:
            output = result.stdout.decode('utf-8')
            print(output)
        except UnicodeDecodeError:
            # 如果utf-8解码失败，尝试gbk编码
            output = result.stdout.decode('gbk')
            print(output)
        return True
    except subprocess.CalledProcessError as e:
        try:
            error_output = e.stderr.decode('utf-8')
        except UnicodeDecodeError:
            error_output = e.stderr.decode('gbk')
        print(f"错误: {error_output}")
        return False

print("开始Git操作...")

# 检查是否已初始化Git仓库
if not os.path.exists(".git"):
    print("初始化Git仓库...")
    run_command("git init")
    run_command("git config --global user.name 'Your Name'")
    run_command("git config --global user.email 'your.email@example.com'")
    run_command(f"git remote add origin {repo_url}")

# 添加文件
print("添加文件...")
run_command("git add contact_us.html")
run_command("git add index.html")

# 提交更改
print("提交更改...")
run_command(f"git commit -m '{message}'")

# 推送更改
print("推送更改...")
run_command(f"git push -u origin {branch}")

print("操作完成！")