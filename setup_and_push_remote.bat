@echo off
rem Git远程仓库配置和推送指南

:menu
echo  ================================
echo       Git远程仓库配置向导
rem 使用完整路径
set GIT_PATH="C:\Program Files\Git\bin\git.exe"
echo  ================================
echo 1. 添加远程仓库
echo 2. 查看远程仓库信息
echo 3. 推送当前分支到远程仓库
echo 4. 设置上游分支并推送
echo 5. 推送所有分支和标签
echo 6. 退出
set /p choice="请选择操作 (1-6): "

if "%choice%"=="1" goto add_remote
if "%choice%"=="2" goto view_remote
if "%choice%"=="3" goto push_current
if "%choice%"=="4" goto set_upstream
if "%choice%"=="5" goto push_all
if "%choice%"=="6" exit

echo 无效的选择，请重试
goto menu

:add_remote
cls
echo 添加远程仓库
echo 请输入远程仓库URL（例如: https://github.com/username/repo.git）:
set /p repo_url=""
set /p remote_name="请输入远程仓库名称（默认为origin）: "

if "%remote_name%"=="" set remote_name=origin

echo 添加远程仓库 %remote_name%...
%GIT_PATH% remote add %remote_name% %repo_url%
if %errorlevel%==0 (
    echo 远程仓库添加成功！
) else (
    echo 远程仓库添加失败，请检查URL是否正确。
)
pause
goto menu

:view_remote
cls
echo 远程仓库信息：
%GIT_PATH% remote -v
pause
goto menu

:push_current
cls
echo 推送当前分支
echo 正在获取当前分支名...
for /f "tokens=*" %%a in ('%GIT_PATH% rev-parse --abbrev-ref HEAD') do set current_branch=%%a
echo 当前分支: %current_branch%

echo 请输入远程仓库名称（默认为origin）:
set /p remote_name=""
if "%remote_name%"=="" set remote_name=origin

echo 推送分支 %current_branch% 到远程仓库 %remote_name%...
%GIT_PATH% push %remote_name% %current_branch%

if %errorlevel%==0 (
    echo 推送成功！
) else (
    echo 推送失败。请检查远程仓库是否正确配置，以及您是否有权限推送。
    echo 可能需要先拉取最新更改：%GIT_PATH% pull %remote_name% %current_branch%
)
pause
goto menu

:set_upstream
cls
echo 设置上游分支并推送
for /f "tokens=*" %%a in ('%GIT_PATH% rev-parse --abbrev-ref HEAD') do set current_branch=%%a
echo 当前分支: %current_branch%

echo 请输入远程仓库名称（默认为origin）:
set /p remote_name=""
if "%remote_name%"=="" set remote_name=origin

echo 设置上游分支并推送...
%GIT_PATH% push -u %remote_name% %current_branch%

if %errorlevel%==0 (
    echo 上游分支设置成功！现在您可以使用 '%GIT_PATH% push' 直接推送。
) else (
    echo 设置上游分支失败。
)
pause
goto menu

:push_all
cls
echo 推送所有分支和标签
echo 请输入远程仓库名称（默认为origin）:
set /p remote_name=""
if "%remote_name%"=="" set remote_name=origin

echo 推送所有分支...
%GIT_PATH% push --all %remote_name%
if %errorlevel%==0 (
    echo 所有分支推送成功！
) else (
    echo 分支推送失败。
)

echo 推送所有标签...
%GIT_PATH% push --tags %remote_name%
if %errorlevel%==0 (
    echo 所有标签推送成功！
) else (
    echo 标签推送失败。
)
pause
goto menu