@echo off
CHCP 65001

cd /d %~dp0

:: 获取管理员权限
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo 请求管理员权限...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    :: 此处添加你的 xcopy 命令
    xcopy /y "pull.bat" "c:\windows"
    IF ERRORLEVEL 1 (
         echo 拉取失败
         pause)
    else(
    echo 执行 xcopy 命令完成。)
 