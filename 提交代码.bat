@echo off & chcp 65001 > nul
setlocal enabledelayedexpansion

:: 要检查的文件列表 
set files=Windows管理小工具.bat README.md config.json img/run.png

:: 检查是否有修改 
set changes=0
for %%f in (%files%) do (
	git status --porcelain "%%f" | findstr /R /C:"^." > nul
	if !errorlevel! equ 0 (
		echo 检测到修改或未跟踪文件: %%f
		set changes=1
	)
)

if %changes% equ 0 (
	echo 没有需要提交的文件，程序退出。 
	pause
	exit /b
)

set /p message=请输入提交说明： 
for %%f in (%files%) do (
	git add "%%f"
)
git commit -m "%message%"
git push origin master

if !errorlevel! equ 0 (
	echo 代码已成功推送到远程仓库！ 
) else (
	echo 推送失败，请检查网络或远程仓库设置。 
)

timeout /t 2