@echo off & chcp 65001>nul
setlocal enabledelayedexpansion

for /f "usebackq tokens=2 delims==" %%a in (`findstr /r /c:"rversion=v" "Windows管理小工具.bat"`) do (
	set "rversion=%%a"
    set "rversion=!rversion:~0,-1!"
)
echo 读取到版本: %rversion% 

copy /y "Windows管理小工具.bat" "WindowsManageTool.sh" >nul 2>&1

echo 使用 PowerShell 打包... 
set "zipPath=release"
if not exist "%zipPath%" mkdir "%zipPath%"
powershell -command "$ProgressPreference = 'SilentlyContinue';Compress-Archive -Path 'Windows管理小工具.bat','README.md','img' -DestinationPath '%zipPath%\Windows_%rversion%.zip' -Force"
echo 打包完成: %zipPath%\Windows管理小工具_%rversion%.zip

timeout /t 2
