import os
import re
import urllib.request
from urllib.error import URLError, HTTPError
import time

# 定义项目根目录
ROOT_DIR = os.path.dirname(os.path.abspath(__file__))

# 要测试的HTML文件列表
HTML_FILES = [
    'index.html',
    'contact_us.html',
    'rural_tourism.html', 
    'modern_agriculture.html',
    'traditional_crafts.html',
    'git_installation_guide.html',
    'github_manual_upload_guide.html'
]

def check_file_exists(file_path):
    """检查文件是否存在"""
    return os.path.isfile(os.path.join(ROOT_DIR, file_path))

def extract_links(file_path):
    """从HTML文件中提取所有链接"""
    full_path = os.path.join(ROOT_DIR, file_path)
    if not os.path.isfile(full_path):
        return []
    
    with open(full_path, 'r', encoding='utf-8', errors='ignore') as f:
        content = f.read()
    
    # 提取所有href属性的值
    links = re.findall(r'href=["\'](.*?)["\']', content)
    return links

def test_local_link(link, base_file):
    """测试本地链接是否有效"""
    # 跳过纯锚点链接（以#开头但不是完整URL的链接）
    if link.startswith('#') and not link.startswith('#http'):
        return True, "锚点链接，无需验证"
    
    # 处理带有锚点的本地链接（如index.html#section）
    if '#' in link and not link.startswith(('http://', 'https://')):
        file_part = link.split('#')[0]
        if not file_part:  # 如 #section
            return True, "页面内锚点链接，无需验证"
        # 对文件部分进行测试
        file_exists = os.path.isfile(os.path.join(ROOT_DIR, file_part))
        if file_exists:
            return True, f"带锚点的本地链接，文件存在: {file_part}"
        else:
            return False, f"带锚点的本地链接，文件不存在: {file_part}"
    
    # 跳过JavaScript链接
    if link.startswith('javascript:'):
        return True, "JavaScript链接，无需验证"
    
    # 跳过mailto链接
    if link.startswith('mailto:'):
        return True, "邮件链接，无需验证"
    
    # 跳过外部链接
    if link.startswith(('http://', 'https://')):
        return True, "外部链接，跳过本地验证"
    
    # 处理普通相对路径
    if link:
        # 获取基础文件所在的目录
        base_dir = os.path.dirname(base_file)
        # 构建完整路径
        full_path = os.path.normpath(os.path.join(ROOT_DIR, base_dir, link))
        if os.path.isfile(full_path):
            return True, f"文件存在: {full_path}"
        elif os.path.isdir(full_path):
            # 检查目录中是否有index.html
            index_path = os.path.join(full_path, 'index.html')
            if os.path.isfile(index_path):
                return True, f"目录存在且包含index.html: {full_path}"
            else:
                return False, f"目录存在但缺少index.html: {full_path}"
        else:
            return False, f"文件不存在: {full_path}"
    
    return True, "空链接，无需验证"

def test_http_link(url):
    """测试HTTP链接是否可以访问"""
    if not url.startswith(('http://', 'https://')):
        return True, "非HTTP链接，跳过"
    
    try:
        with urllib.request.urlopen(url, timeout=5) as response:
            return response.status < 400, f"HTTP状态码: {response.status}"
    except HTTPError as e:
        return False, f"HTTP错误: {e.code}"
    except URLError as e:
        return False, f"URL错误: {str(e)}"
    except Exception as e:
        return False, f"未知错误: {str(e)}"

def generate_report(results):
    """生成测试报告"""
    print("=" * 80)
    print("网站链接测试报告")
    print("=" * 80)
    
    all_passed = True
    for file, file_results in results.items():
        print(f"\n文件: {file}")
        print("-" * 80)
        
        if not file_results['exists']:
            print(f"✗ 文件不存在: {file}")
            all_passed = False
            continue
        
        print(f"✓ 文件存在")
        
        local_links = file_results['local_links']
        external_links = file_results['external_links']
        
        if local_links:
            print(f"\n本地链接 ({len(local_links)}):")
            for link, (status, message) in local_links.items():
                status_icon = "✓" if status else "✗"
                print(f"  {status_icon} {link}: {message}")
                if not status:
                    all_passed = False
        
        if external_links:
            print(f"\n外部链接 ({len(external_links)}):")
            for link, (status, message) in external_links.items():
                status_icon = "✓" if status else "✗"
                print(f"  {status_icon} {link}: {message}")
                if not status:
                    all_passed = False
    
    print("\n" + "=" * 80)
    if all_passed:
        print("✅ 所有测试通过!")
    else:
        print("❌ 测试发现问题，请查看以上报告")
    print("=" * 80)

def main():
    print("开始测试网站链接...")
    print(f"测试目录: {ROOT_DIR}")
    print()
    
    results = {}
    
    for file in HTML_FILES:
        file_results = {
            'exists': check_file_exists(file),
            'local_links': {},
            'external_links': {}
        }
        
        if file_results['exists']:
            print(f"正在处理: {file}")
            links = extract_links(file)
            
            for link in links:
                if link.startswith(('http://', 'https://')):
                    # 对外部链接进行采样测试，避免测试太慢
                    if len(file_results['external_links']) < 10:  # 限制测试的外部链接数量
                        status, message = test_http_link(link)
                        file_results['external_links'][link] = (status, message)
                else:
                    status, message = test_local_link(link, file)
                    file_results['local_links'][link] = (status, message)
        
        results[file] = file_results
    
    generate_report(results)
    
    # 检查本地服务器是否运行
    print("\n检查本地服务器是否可用...")
    try:
        with urllib.request.urlopen('http://localhost:8080', timeout=3) as response:
            print("✅ 本地服务器运行正常 (http://localhost:8080)")
    except Exception as e:
        print(f"❌ 无法连接到本地服务器: {str(e)}")
        print("请确保已启动Python HTTP服务器: python -m http.server 8080")

if __name__ == "__main__":
    main()