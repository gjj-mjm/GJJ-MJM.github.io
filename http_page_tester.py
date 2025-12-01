import os
import urllib.request
from urllib.error import URLError, HTTPError

# 定义要测试的HTML文件列表
HTML_FILES = [
    'index.html',
    'contact_us.html',
    'rural_tourism.html', 
    'modern_agriculture.html',
    'traditional_crafts.html',
    'git_installation_guide.html',
    'github_manual_upload_guide.html'
]

# 本地服务器URL
BASE_URL = 'http://localhost:8080/'

def test_page_access(file_name):
    """测试通过HTTP访问页面是否正常"""
    url = f"{BASE_URL}{file_name}"
    try:
        with urllib.request.urlopen(url, timeout=5) as response:
            # 检查状态码
            if response.status == 200:
                # 检查响应内容类型
                content_type = response.getheader('Content-Type', '')
                if 'text/html' in content_type:
                    # 读取少量内容来验证
                    content = response.read(1000).decode('utf-8', errors='ignore')
                    # 简单验证是否包含HTML标签
                    if '<!DOCTYPE html>' in content.lower() or '<html' in content.lower():
                        return True, f"状态码: {response.status}, 内容类型: {content_type}, 包含HTML标签"
                    else:
                        return False, f"状态码: {response.status}, 但响应内容不包含HTML标签"
                else:
                    return False, f"状态码: {response.status}, 但内容类型不是HTML: {content_type}"
            else:
                return False, f"状态码: {response.status}"
    except HTTPError as e:
        return False, f"HTTP错误: {e.code} - {e.reason}"
    except URLError as e:
        return False, f"URL错误: {str(e)}"
    except Exception as e:
        return False, f"未知错误: {str(e)}"

def main():
    print("=" * 80)
    print("本地服务器页面访问测试")
    print("=" * 80)
    print(f"测试服务器: {BASE_URL}")
    print()
    
    all_passed = True
    
    for file in HTML_FILES:
        print(f"测试页面: {file}")
        status, message = test_page_access(file)
        
        if status:
            print(f"  ✅ 通过: {message}")
        else:
            print(f"  ❌ 失败: {message}")
            all_passed = False
        print()
    
    print("=" * 80)
    if all_passed:
        print("🎉 所有页面测试通过!")
        print(f"\n您可以通过以下方式访问网站:")
        print(f"- 本地访问: {BASE_URL}")
        print(f"- 建议使用浏览器访问以上地址进行最终验证")
    else:
        print("❌ 部分页面测试失败，请检查服务器配置和文件完整性")
        print("\n排查建议:")
        print("1. 确保Python HTTP服务器正在运行: python -m http.server 8080")
        print("2. 检查文件是否存在且权限正确")
        print("3. 检查文件编码是否正确")
    print("=" * 80)

if __name__ == "__main__":
    main()