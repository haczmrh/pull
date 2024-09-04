@echo off
CHCP 65001

setlocal enabledelayedexpansion
set "repo_directory=g:\repo"

for /d %%i in ("%repo_directory%\*") do (
    cd /d "%%i"
    echo 正在更新代码库：%%~nxi

    :retry_pull
    git pull -f --rebase
    if ERRORLEVEL 1 (
        echo 存在本地更改，正在删除本地更改：%%~nxi

        :retry_clean
        git clean -d -f
        if ERRORLEVEL 1 (
            echo git clean 失败，尝试删除 .git\index.lock 文件

            :retry_delete
            del /f .git\index.lock
            if EXIST .git\index.lock (
                echo 删除失败，正在重试...
                timeout /t 2 >nul
                goto retry_delete
            )
        )
        git clean -d -f
        git pull -f --rebase
        if ERRORLEVEL 1 (
            echo 拉取失败，请检查
            goto retry_pull
        ) else (
            echo 拉取成功
        )
    ) else (
        echo 拉取成功
    )

    echo 正在更新子模块：%%~nxi
    git submodule update --init --recursive
    if ERRORLEVEL 1 (
        echo 更新子模块失败，请检查
    ) else (
        echo 子模块更新成功
    )
)

endlocal
cd /d G:/Repo/Majhong/ConfigData
git pull -f --rebase
