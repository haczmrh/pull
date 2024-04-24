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

      :retry_checkout
      git checkout .

      IF ERRORLEVEL 1 (
          echo git clean 失败，删除 .git\index.lock 文件

             :retry_delete
              del /f .git\index.lock
                IF EXIST .git\index.lock (
                echo 删除失败，正在重试...
                timeout /t 2 >nul
                goto retry_delete
        )
        git checkout .
      )
      git pull -f --rebase
         IF ERRORLEVEL 1 (
         echo 拉取失败
         goto retry_checkout
         )
         else (
         echo 拉取成功
         )

    )
) 
endlocal
pause
