@echo off

REM 测试批处理文件格式和编码是否正确

echo 测试批处理文件格式和编码...
echo 1. 这是一个测试消息，检查是否显示正常
echo 2. 中文显示测试：你好，世界！
echo 3. 特殊字符测试：!@#$%^&*

REM 检查simple_upload_new.bat是否存在
if exist simple_upload_new.bat (
    echo 测试文件simple_upload_new.bat存在
    echo 请手动双击运行simple_upload_new.bat文件进行实际测试
) else (
    echo 错误：未找到simple_upload_new.bat文件
)

pause