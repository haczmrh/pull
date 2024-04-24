@echo off
CHCP 65001

setlocal enabledelayedexpansion
set repo_directory=C:

for /d %%i in ("%repo_directory%\*") do (
    cd /d "%%i"

    echo 正在更新代码库：%%~nxi
    git pull -f --rebase)
    REM 检查 git pull 的返回值
    IF NOT ERRORLEVEL 0 (
      echo 存在local changes，正在删除本地更改：%%~nxi
      git checkout .
      git clean -d -f

      REM 检查 git clean 的返回值
      IF NOT ERRORLEVEL 0 (
          echo git clean 失败，删除 .git\index.lock 文件
          del /f .git\index.lock
          git checkout .
          git clean -d -f
          git pull -f --rebase
      )
    )
) 
endlocal
