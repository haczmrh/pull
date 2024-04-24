@echo off
CHCP 65001

setlocal enabledelayedexpansion
set repo_directory=C:

for /d %%i in ("%repo_directory%\*") do (
    cd /d "%%i"

    echo 正在更新代码库：%%~nxi
    git pull -f --rebase
    REM 检查 git pull 的返回值
    IF ERRORLEVEL 1 (
      echo 存在local changes，正在删除本地更改：%%~nxi
      git checkout .

      REM 检查的返回值
      IF ERRORLEVEL 1 (
          echo git clean 失败，删除 .git\index.lock 文件
          del /f .git\index.lock
          git checkout .
          git pull -f --rebase
      )
    )
) 
endlocal
