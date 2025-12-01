# Python版本的Taro.js配置文件
# 这个文件模拟了JavaScript中defineConfig的功能，但使用Python语法

def define_config(project=None, device_ratio=None, source_root=None, output_root=None, plugins=None, define=None, alias=None, mini=None, h5=None):
    """
    定义Taro项目配置的函数
    
    参数:
    project: 项目配置字典
    device_ratio: 设备像素比配置
    source_root: 源码根目录
    output_root: 输出目录
    plugins: 插件列表
    define: 全局变量定义
    alias: 路径别名
    mini: 小程序配置
    h5: H5配置
    
    返回:
    完整的配置字典
    """
    config = {
        'project': project or {},
        'deviceRatio': device_ratio or {},
        'sourceRoot': source_root or '',
        'outputRoot': output_root or '',
        'plugins': plugins or [],
        'define': define or {},
        'alias': alias or {},
        'mini': mini or {},
        'h5': h5 or {}
    }
    return config

# 示例配置
if __name__ == '__main__':
    # 模拟JavaScript中的defineConfig调用
    config = define_config(
        project={
            'name': 'taro-demo',
            'date': '2023-09-01',
            'description': 'Taro.js Demo Project'
        },
        device_ratio={
            '640': 2.34 / 2,
            '750': 1,
            '828': 1.81 / 2
        },
        source_root='src',
        output_root='dist',
        plugins=[],
        define={
            'process.env.NODE_ENV': 'development'
        },
        alias={},
        mini={
            'postcss': {}
        },
        h5={
            'postcss': {}
        }
    )
    
    print("Python版本的Taro配置已创建:")
    import json
    print(json.dumps(config, indent=2, ensure_ascii=False))