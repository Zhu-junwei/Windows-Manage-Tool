@echo off & setlocal EnableDelayedExpansion
:: 获取管理员权限
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit cd /d "%~dp0"
:: 背景，代码页和字体颜色，窗口大小（窗口大小在win11中有些不适用）
color 0A & chcp 65001
set "title=Windows管理小工具" 
set "updated=20250604" 
set "rversion=v2.0.7"
title %title% %rversion%
:: 主菜单 
:main_menu 
mode con cols=60 lines=25
call :print_title "%title%" 
set "main_option="
call :print_separator
echo   1. 右键菜单设置                  11. WIFI密码 
echo   2. 桌面设置                      12. 电源管理 
echo   3. 任务栏设置                    13. 预装应用管理 
echo   4. 资源管理器设置                14. 编辑hosts 
echo   5. 下载 Office                   15. 网络管理 
echo   6. 下载 Windows                  16. 图一乐 
echo   7. 激活 Windows ^& Office         
echo   8. Windows更新设置 
echo   9. UAC（用户账户控制）设置 
echo  10. 上帝模式                      99. 检查更新 
echo   0. 退出(q)                       00. 关于 
call :print_separator
echo. 
set /p main_option=请输入你的选择: 
if "%main_option%"=="1"  call :submenu_right_click
if "%main_option%"=="2"  call :desktop
if "%main_option%"=="3"  call :taskbar
if "%main_option%"=="4"  call :explorer_setting
if "%main_option%"=="5"  call :download_office
if "%main_option%"=="6"  call :download_windows
if "%main_option%"=="7"  call :activate_windows
if "%main_option%"=="8"  call :windows_update
if "%main_option%"=="9"  call :uac_setting
if "%main_option%"=="10" call :god_mod
if "%main_option%"=="11" call :wifi_password
if "%main_option%"=="12" call :power_setting
if "%main_option%"=="13" call :pre_installed_app
if "%main_option%"=="14" call :hosts_editor
if "%main_option%"=="15" call :network_setting
if "%main_option%"=="16" call :hahaha
if "%main_option%"=="99" call :update_script
if "%main_option%"=="00" call :about_me
if "%main_option%"=="0"  goto byebye
if /i "%main_option%"=="q" goto byebye
goto main_menu 

:: 右键菜单设置子菜单 
:submenu_right_click
call :print_title "右键菜单设置" 24 
set "submenu_option="
call :print_separator
echo  1. 切换 Windows 10 右键菜单
echo  2. 恢复 Windows 11 右键菜单
echo  3. 添加超级菜单
echo  4. 删除超级菜单
echo  5. 添加Hash右键菜单
echo  6. 删除Hash右键菜单
echo  0. 返回(q) 
call :print_separator
echo.
set /p submenu_option=请输入你的选择: 
if "%submenu_option%"=="1" ( 
    reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve >nul 2>&1
    call :restart_explorer
) else if "%submenu_option%"=="2" ( 
    reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f  >nul 2>&1
    call :restart_explorer
) else if "%submenu_option%"=="3" (
	echo 添加超级菜单...
	call :add_SuperMenu
	call :sleep "添加超级菜单成功!" 5
) else if "%submenu_option%"=="4" ( 
	echo 删除超级菜单...
	call :delete_SuperMenu
	call :sleep "超级菜单已删除" 5
) else if "%submenu_option%"=="5" ( 
    reg add "HKEY_CLASSES_ROOT\*\shell\GetFileHash" /v "MUIVerb" /t REG_SZ /d "Hash" /f >nul 2>&1
	reg add "HKEY_CLASSES_ROOT\*\shell\GetFileHash" /v "SubCommands" /t REG_SZ /d "" /f >nul 2>&1
	reg add "HKEY_CLASSES_ROOT\*\shell\GetFileHash\shell\01SHA1" /v "MUIVerb" /t REG_SZ /d "SHA1" /f >nul 2>&1
	reg add "HKEY_CLASSES_ROOT\*\shell\GetFileHash\shell\01SHA1\command" /ve /t REG_SZ /d "powershell.exe -noexit get-filehash -literalpath \"%%1\" -algorithm SHA1 | format-list" /f >nul 2>&1
	reg add "HKEY_CLASSES_ROOT\*\shell\GetFileHash\shell\02SHA256" /v "MUIVerb" /t REG_SZ /d "SHA256" /f >nul 2>&1
	reg add "HKEY_CLASSES_ROOT\*\shell\GetFileHash\shell\02SHA256\command" /ve /t REG_SZ /d "powershell.exe -noexit get-filehash -literalpath \"%%1\" -algorithm SHA256 | format-list" /f >nul 2>&1
	reg add "HKEY_CLASSES_ROOT\*\shell\GetFileHash\shell\03SHA384" /v "MUIVerb" /t REG_SZ /d "SHA384" /f >nul 2>&1
	reg add "HKEY_CLASSES_ROOT\*\shell\GetFileHash\shell\03SHA384\command" /ve /t REG_SZ /d "powershell.exe -noexit get-filehash -literalpath \"%%1\" -algorithm SHA384 | format-list" /f >nul 2>&1
	reg add "HKEY_CLASSES_ROOT\*\shell\GetFileHash\shell\04SHA512" /v "MUIVerb" /t REG_SZ /d "SHA512" /f >nul 2>&1
	reg add "HKEY_CLASSES_ROOT\*\shell\GetFileHash\shell\04SHA512\command" /ve /t REG_SZ /d "powershell.exe -noexit get-filehash -literalpath \"%%1\" -algorithm SHA512 | format-list" /f >nul 2>&1
	reg add "HKEY_CLASSES_ROOT\*\shell\GetFileHash\shell\05MACTripleDES" /v "MUIVerb" /t REG_SZ /d "MACTripleDES" /f >nul 2>&1
	reg add "HKEY_CLASSES_ROOT\*\shell\GetFileHash\shell\05MACTripleDES\command" /ve /t REG_SZ /d "powershell.exe -noexit get-filehash -literalpath \"%%1\" -algorithm MACTripleDES | format-list" /f >nul 2>&1
	reg add "HKEY_CLASSES_ROOT\*\shell\GetFileHash\shell\06MD5" /v "MUIVerb" /t REG_SZ /d "MD5" /f >nul 2>&1
	reg add "HKEY_CLASSES_ROOT\*\shell\GetFileHash\shell\06MD5\command" /ve /t REG_SZ /d "powershell.exe -noexit get-filehash -literalpath \"%%1\" -algorithm MD5 | format-list" /f >nul 2>&1
	reg add "HKEY_CLASSES_ROOT\*\shell\GetFileHash\shell\07RIPEMD160" /v "MUIVerb" /t REG_SZ /d "RIPEMD160" /f >nul 2>&1
	reg add "HKEY_CLASSES_ROOT\*\shell\GetFileHash\shell\07RIPEMD160\command" /ve /t REG_SZ /d "powershell.exe -noexit get-filehash -literalpath \"%%1\" -algorithm RIPEMD160 | format-list" /f >nul 2>&1
	call :sleep "添加Hash右键菜单完成!" 3
)  else if "%submenu_option%"=="6" ( 
	echo 正在删除Hash右键菜单...
	reg delete "HKEY_CLASSES_ROOT\*\shell\GetFileHash" /f >nul 2>&1
	call :sleep "Hash右键菜单已删除!" 3
)
if "%submenu_option%"=="0" exit /b
if /i "%submenu_option%"=="q" exit /b
goto submenu_right_click

:: 添加超级菜单，后面看看怎么使用reg文件进行处理
:add_SuperMenu
	reg add "HKCR\*\shell\SuperMenu" /f /v "Icon" /t REG_SZ /d "shell32.dll,-16748">nul 2>&1 
	reg add "HKCR\*\shell\SuperMenu" /f /v "MUIVerb" /t REG_SZ /d "超级菜单(&X)">nul 2>&1 
	reg add "HKCR\*\shell\SuperMenu" /f /v "SeparatorAfter" /t REG_SZ /d "1">nul 2>&1 
	reg add "HKCR\*\shell\SuperMenu" /f /v "SubCommands" /t REG_SZ /d "X.CopyPath;X.CopyName;X.CopyNameNoExt;X.CopyTo;X.MoveTo;X.Attributes;X.ClearClipboard;X.CopyContent;X.GetHash;X.Notepad;X.Makecab;X.Runas;X.PermanentDelete;Windows.RecycleBin.Empty">nul 2>&1 
	reg add "HKCR\DesktopBackground\Shell\SuperMenu" /f /v "Icon" /t REG_SZ /d "shell32.dll,-16748">nul 2>&1 
	reg add "HKCR\DesktopBackground\Shell\SuperMenu" /f /v "MUIVerb" /t REG_SZ /d "超级菜单(&X)">nul 2>&1 
	reg add "HKCR\DesktopBackground\Shell\SuperMenu" /f /v "SeparatorAfter" /t REG_SZ /d "1">nul 2>&1 
	reg add "HKCR\DesktopBackground\Shell\SuperMenu" /f /v "SubCommands" /t REG_SZ /d "X.FolderOpt.Menu;X.Cmd;X.ACmd;X.Powershell;X.APowershell;X.System.Menu;X.ClearClipboard;Windows.RecycleBin.Empty">nul 2>&1 
	reg add "HKCR\DesktopBackground\Shell\SuperMenu" /f /v "Position" /t REG_SZ /d "Top">nul 2>&1 
	reg add "HKCR\Directory\background\shell\SuperMenu" /f /v "Icon" /t REG_SZ /d "shell32.dll,-16748">nul 2>&1 
	reg add "HKCR\Directory\background\shell\SuperMenu" /f /v "MUIVerb" /t REG_SZ /d "超级菜单(&X)">nul 2>&1 
	reg add "HKCR\Directory\background\shell\SuperMenu" /f /v "SeparatorAfter" /t REG_SZ /d "1">nul 2>&1 
	reg add "HKCR\Directory\background\shell\SuperMenu" /f /v "SubCommands" /t REG_SZ /d "X.FolderOpt.Menu;X.Cmd;X.ACmd;X.Powershell;X.APowershell;X.System.Menu;X.ClearClipboard;Windows.RecycleBin.Empty">nul 2>&1 
	reg add "HKCR\Directory\background\shell\SuperMenu" /f /v "Position" /t REG_SZ /d "Top">nul 2>&1 
	reg add "HKCR\Folder\shell\SuperMenu" /f /v "Icon" /t REG_SZ /d "shell32.dll,-16748">nul 2>&1 
	reg add "HKCR\Folder\shell\SuperMenu" /f /v "MUIVerb" /t REG_SZ /d "超级菜单(&X)">nul 2>&1 
	reg add "HKCR\Folder\shell\SuperMenu" /f /v "SeparatorAfter" /t REG_SZ /d "1">nul 2>&1 
	reg add "HKCR\Folder\shell\SuperMenu" /f /v "SubCommands" /t REG_SZ /d "X.CopyPath;X.CopyName;X.CopyNameNoExt;X.CopyTo;X.MoveTo;X.Attributes;X.ClearClipboard;X.Filenames;X.ListedFiles;X.Cmd;X.ACmd;X.RunasD;X.PermanentDelete;Windows.RecycleBin.Empty">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.ACmd" /f /v "Icon" /t REG_SZ /d "imageres.dll,-5324">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.ACmd" /f /v "MUIVerb" /t REG_SZ /d "在此处打开命令窗口 (管理员)">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.ACmd\Command" /f /ve /t REG_SZ /d "PowerShell -windowstyle hidden -Command \"Start-Process cmd.exe -ArgumentList '/s,/k,pushd,%%V' -Verb RunAs\"">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.APowershell" /f /v "Icon" /t REG_SZ /d "imageres.dll,-5373">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.APowershell" /f /v "MUIVerb" /t REG_SZ /d "在此处打开Powershell (管理员)">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.APowershell\Command" /f /ve /t REG_SZ /d "powershell.exe -Command \"Start-Process powershell.exe -ArgumentList '-NoExit','-Command','Set-Location -LiteralPath ''%%V''' -Verb RunAs\"">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Attributes" /f /v "Icon" /t REG_SZ /d "imageres.dll,-5314">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Attributes" /f /v "MUIVerb" /t REG_SZ /d "文件属性">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Attributes" /f /v "SubCommands" /t REG_SZ /d "">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Attributes\Shell\01" /f /v "Icon" /t REG_SZ /d "imageres.dll,-9">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Attributes\Shell\01" /f /v "MUIVerb" /t REG_SZ /d "添加「系统、隐藏」">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Attributes\Shell\01\Command" /f /ve /t REG_SZ /d "attrib +s +h \"%%1\"">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Attributes\Shell\02" /f /v "Icon" /t REG_SZ /d "imageres.dll,-10">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Attributes\Shell\02" /f /v "MUIVerb" /t REG_SZ /d "移除「系统、隐藏、只读、存档」">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Attributes\Shell\02\Command" /f /ve /t REG_SZ /d "attrib -s -h -r -a \"%%1\"">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.ClearClipboard" /f /v "Icon" /t REG_SZ /d "imageres.dll,-5383">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.ClearClipboard" /f /v "MUIVerb" /t REG_SZ /d "清空剪贴板">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.ClearClipboard\Command" /f /ve /t REG_SZ /d "mshta vbscript:CreateObject(\"htmlfile\").parentwindow.clipboardData.clearData()(close)">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Cmd" /f /v "Icon" /t REG_SZ /d "imageres.dll,-5323">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Cmd" /f /v "MUIVerb" /t REG_SZ /d "在此处打开命令窗口">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Cmd\Command" /f /ve /t REG_SZ /d "cmd.exe /s /k pushd \"%%V\"">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.CopyContent" /f /v "Icon" /t REG_SZ /d "imageres.dll,-5367">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.CopyContent" /f /v "MUIVerb" /t REG_SZ /d "复制文件内容">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.CopyContent\Command" /ve /t REG_SZ /d "mshta vbscript:createobject(\"shell.application\").shellexecute(\"cmd.exe\",\"/c clip ^< \"\"%%1\"\"\",\"\",\"open\",0)(close)" /f>nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.CopyName" /f /v "Icon" /t REG_SZ /d "imageres.dll,-90">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.CopyName" /f /v "MUIVerb" /t REG_SZ /d "复制名字">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.CopyName\Command" /ve /t REG_SZ /d "mshta vbscript:clipboarddata.setdata(\"text\",mid(\"%%1\",instrrev(\"%%1\",\"\\\")+1))(close)" /f>nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.CopyNameNoExt" /f /v "Icon" /t REG_SZ /d "imageres.dll,-124">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.CopyNameNoExt" /f /v "MUIVerb" /t REG_SZ /d "复制名字 (无扩展名)">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.CopyNameNoExt\Command" /f /ve /t REG_SZ /d "mshta vbscript:clipboarddata.setdata(\"text\",split(createobject(\"scripting.filesystemobject\").getfilename(\"%%1\"),\".\")(0))(close)">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.CopyPath" /f /v "Icon" /t REG_SZ /d "imageres.dll,-5302">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.CopyPath" /f /v "MUIVerb" /t REG_SZ /d "复制路径">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.CopyPath\Command" /f /ve /t REG_SZ /d "mshta vbscript:clipboarddata.setdata(\"text\",\"%%1\")(close)">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.CopyTo" /f /v "Icon" /t REG_SZ /d "imageres.dll,-5304">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.CopyTo" /f /v "MUIVerb" /t REG_SZ /d "复制到...(&C)">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.CopyTo" /f /v "ExplorerCommandHandler" /t REG_SZ /d "{AF65E2EA-3739-4e57-9C5F-7F43C949CE5E}">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Device" /f /v "Icon" /t REG_SZ /d "DeviceCenter.dll,-1">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Device" /f /v "MUIVerb" /t REG_SZ /d "设备和打印机">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Device\Command" /f /ve /t REG_SZ /d "explorer.exe shell:::{A8A91A66-3A7D-4424-8D24-04E180695C7A}">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.EditEnvVar" /f /v "Icon" /t REG_SZ /d "imageres.dll,-5374">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.EditEnvVar" /f /v "MUIVerb" /t REG_SZ /d "环境变量">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.EditEnvVar\Command" /f /ve /t REG_SZ /d "rundll32.exe sysdm.cpl,EditEnvironmentVariables">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.EditHosts" /f /v "Icon" /t REG_SZ /d "imageres.dll,-114">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.EditHosts" /f /v "MUIVerb" /t REG_SZ /d "编辑Hosts">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.EditHosts\Command" /f /ve /t REG_SZ /d "mshta vbscript:createobject(\"shell.application\").shellexecute(\"notepad.exe\",\"C:\Windows\System32\drivers\etc\hosts\",\"\",\"runas\",1)(close)">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Filenames" /f /v "Icon" /t REG_SZ /d "imageres.dll,-5306">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Filenames" /f /v "MUIVerb" /t REG_SZ /d "生成文件名单">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Filenames\Command" /f /ve /t REG_SZ /d "cmd.exe /c @echo off&(for %%%%i in (\"%%1\*\")do set /p \"=%%%%~nxi \" < nul)> \"%%1_Filenames.txt\"">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.FolderOpt.Menu" /f /v "Icon" /t REG_SZ /d "shell32.dll,-210">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.FolderOpt.Menu" /f /v "MUIVerb" /t REG_SZ /d "文件夹选项">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.FolderOpt.Menu" /f /v "SubCommands" /t REG_SZ /d "Windows.ShowHiddenFiles;Windows.ShowFileExtensions;Windows.folderoptions">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.GetHash" /f /v "Icon" /t REG_SZ /d "imageres.dll,-5340">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.GetHash" /f /v "MUIVerb" /t REG_SZ /d "获取文件校验值 (Hash)">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.GetHash\Command" /ve /t REG_SZ /d "mshta vbscript:createobject(\"shell.application\").shellexecute(\"powershell.exe\",\"-noexit write-host '\"\"%%1\"\"';$args = 'md5', 'sha1', 'sha256', 'sha384', 'sha512', 'mactripledes', 'ripemd160'; foreach($arg in $args){get-filehash '\"\"%%1\"\"' -algorithm $arg ^| select-object algorithm, hash ^| format-table -wrap}\",\"\",\"open\",3)(close)" /f>nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.GodMode" /f /v "Icon" /t REG_SZ /d "control.exe">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.GodMode" /f /v "MUIVerb" /t REG_SZ /d "所有任务">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.GodMode\Command" /f /ve /t REG_SZ /d "explorer.exe shell:::{ED7BA470-8E54-465E-825C-99712043E01C}">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.ListedFiles" /f /v "Icon" /t REG_SZ /d "imageres.dll,-5350">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.ListedFiles" /f /v "MUIVerb" /t REG_SZ /d "生成文件列表 (遍历目录)">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.ListedFiles\Command" /f /ve /t REG_SZ /d "cmd.exe /c @echo off&(for /f \"delims=\" %%%%i in ('dir /b/a-d/s \"%%1\"')do echo \"%%%%i\")>\"%%1_ListedFiles.txt\"">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Makecab" /f /v "Icon" /t REG_SZ /d "imageres.dll,-175">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Makecab" /f /v "MUIVerb" /t REG_SZ /d "Makecab最大压缩">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Makecab\Command" /f /ve /t REG_SZ /d "makecab.exe /D CompressionType=LZX /D CompressionMemory=21 /D Cabinet=ON /D Compress=ON \"%%1\"">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.MoveTo" /f /v "Icon" /t REG_SZ /d "imageres.dll,-5303">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.MoveTo" /f /v "MUIVerb" /t REG_SZ /d "移动到...(&M)">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.MoveTo" /f /v "ExplorerCommandHandler" /t REG_SZ /d "{A0202464-B4B4-4b85-9628-CCD46DF16942}">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Notepad" /f /v "Icon" /t REG_SZ /d "shell32.dll,-152">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Notepad" /f /v "MUIVerb" /t REG_SZ /d "使用记事本打开">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Notepad\Command" /f /ve /t REG_SZ /d "notepad.exe \"%%1\"">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.PermanentDelete" /f /v "CommandStateSync" /t REG_SZ /d "">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.PermanentDelete" /f /v "ExplorerCommandHandler" /t REG_SZ /d "{E9571AB2-AD92-4ec6-8924-4E5AD33790F5}">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.PermanentDelete" /f /v "Icon" /t REG_SZ /d "shell32.dll,-240">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Powershell" /f /v "Icon" /t REG_SZ /d "imageres.dll,-5372">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Powershell" /f /v "MUIVerb" /t REG_SZ /d "在此处打开Powershell">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Powershell\Command" /f /ve /t REG_SZ /d "powershell.exe -noexit -command Set-Location -literalPath '%%V'">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.RestartExplorer" /f /v "Icon" /t REG_SZ /d "shell32.dll,-16739">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.RestartExplorer" /f /v "MUIVerb" /t REG_SZ /d "重启资源管理器">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.RestartExplorer\Command" /f /ve /t REG_SZ /d "mshta vbscript:createobject(\"shell.application\").shellexecute(\"tskill.exe\",\"explorer\",\"\",\"open\",0)(close)">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Runas" /f /v "Icon" /t REG_SZ /d "imageres.dll,-5356">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Runas" /f /v "MUIVerb" /t REG_SZ /d "管理员取得所有权">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Runas\Command" /f /ve /t REG_SZ /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.RunasD" /f /v "Icon" /t REG_SZ /d "imageres.dll,-5356">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.RunasD" /f /v "MUIVerb" /t REG_SZ /d "管理员取得所有权 (遍历目录)">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.RunasD\Command" /f /ve /t REG_SZ /d "cmd.exe /c takeown /f \"%%1\" /r /d y && icacls \"%%1\" /grant administrators:F /t">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.RunasD\Command" /f /v "IsolatedCommand" /t REG_SZ /d "cmd.exe /c takeown /f \"%%1\" /r /d y && icacls \"%%1\" /grant administrators:F /t">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.System.Menu" /f /v "Icon" /t REG_SZ /d "imageres.dll,-5308">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.System.Menu" /f /v "MUIVerb" /t REG_SZ /d "系统命令">nul 2>&1 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.System.Menu" /f /v "SubCommands" /t REG_SZ /d "X.GodMode;X.EditEnvVar;X.EditHosts;X.Device;X.RestartExplorer">nul 2>&1 
	exit /b 

:: 删除超级菜单
:delete_SuperMenu
	reg delete "HKCR\*\shell\SuperMenu" /f >nul 2>&1 
	reg delete "HKCR\DesktopBackground\Shell\SuperMenu" /f >nul 2>&1 
	reg delete "HKCR\Directory\background\shell\SuperMenu" /f >nul 2>&1 
	reg delete "HKCR\Folder\shell\SuperMenu" /f >nul 2>&1 
	reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.ACmd" /f >nul 2>&1 
	reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.APowershell" /f >nul 2>&1 
	reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Attributes" /f >nul 2>&1 
	reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.ClearClipboard" /f >nul 2>&1 
	reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Cmd" /f >nul 2>&1 
	reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.CopyContent" /f >nul 2>&1 
	reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.CopyName" /f >nul 2>&1 
	reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.CopyNameNoExt" /f >nul 2>&1 
	reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.CopyPath" /f >nul 2>&1 
	reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.CopyTo" /f >nul 2>&1 
	reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Device" /f >nul 2>&1 
	reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.EditEnvVar" /f >nul 2>&1 
	reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.EditHosts" /f >nul 2>&1 
	reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Filenames" /f >nul 2>&1 
	reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.FolderOpt.Menu" /f >nul 2>&1 
	reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.GetHash" /f >nul 2>&1 
	reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.GodMode" /f >nul 2>&1 
	reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.ListedFiles" /f >nul 2>&1 
	reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Makecab" /f >nul 2>&1 
	reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.MoveTo" /f >nul 2>&1 
	reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Notepad" /f >nul 2>&1 
	reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.PermanentDelete" /f >nul 2>&1 
	reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Powershell" /f >nul 2>&1 
	reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.RestartExplorer" /f >nul 2>&1 
	reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.Runas" /f >nul 2>&1 
	reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.RunasD" /f >nul 2>&1 
	reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\X.System.Menu" /f >nul 2>&1 
	exit /b

:: 桌面设置
:desktop
call :print_title "桌面设置" 26 
set "submenu_option="
call :print_separator
echo  1. 隐藏桌面图标小箭头 
echo  2. 显示桌面图标小箭头 
echo  3. 隐藏了解此图片（windows聚焦） 
echo  4. 显示了解此图片（windows聚焦） 
echo  5. 打开桌面图标设置 
echo  6. 添加网络连接 
echo  7. 添加IE快捷方式
echo  8. 显示windows版本水印 
echo  9. 隐藏windows版本水印
echo 10. 设置Bing每日桌面背景
echo  0. 返回(q) 
call :print_separator
echo.
set /p submenu_option=请输入你的选择: 
if "%submenu_option%"=="1" (
	echo 正在隐藏桌面图标小箭头...
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29 /d "%systemroot%\system32\imageres.dll,197" /t reg_sz /f >nul 2>&1
	attrib -s -r -h "%userprofile%\AppData\Local\iconcache.db" >nul 2>&1
	del "%userprofile%\AppData\Local\iconcache.db" /f /q >nul 2>&1
	call :restart_explorer
	call :sleep "操作完成！" 2
) else if "%submenu_option%"=="2" (
	echo 正在显示桌面图标小箭头...
	reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29 /f >nul 2>&1
	attrib -s -r -h "%userprofile%\AppData\Local\iconcache.db" >nul 2>&1
	del "%userprofile%\AppData\Local\iconcache.db" /f /q >nul 2>&1
	call :restart_explorer
	call :sleep "操作完成！" 2
) else if "%submenu_option%"=="3" (
	echo 正在隐藏了解此图片...
	REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{2cc5ca98-6485-489a-920e-b3e88a6ccce3}" /t REG_DWORD /d 1 /f >nul 2>&1
	call :restart_explorer
	call :sleep "操作完成！" 2
) else if "%submenu_option%"=="4" (
	echo 正在显示了解此图片...
	REG DELETE "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{2cc5ca98-6485-489a-920e-b3e88a6ccce3}" /f >nul 2>&1
	call :restart_explorer
	call :sleep "操作完成！" 2
) else if "%submenu_option%"=="5" (
	rundll32 shell32.dll,Control_RunDLL desk.cpl,,0
)else if "%submenu_option%"=="6" (
	call :desktop_add_network
	call :sleep "网络连接已添加！" 3
)else if "%submenu_option%"=="7" (
	call :desktop_add_ie
	set "add_result=快捷方式创建成功！"
	if %ERRORLEVEL% equ 1 set "add_result=快捷方式创建失败！"
	echo %add_result%！& timeout /t 3
)else if "%submenu_option%"=="8" (
	REG ADD "HKCU\Control Panel\Desktop" /V PaintDesktopVersion /T REG_DWORD /D 1 /F >nul 2>&1
	call :restart_explorer
	call :sleep "操作完成！" 2
)else if "%submenu_option%"=="9" (
	REG ADD "HKCU\Control Panel\Desktop" /V PaintDesktopVersion /T REG_DWORD /D 0 /F >nul 2>&1
	call :restart_explorer
	call :sleep "操作完成！" 2
)else if "%submenu_option%"=="10" (
	call :set_desktop_background
	call :sleep "操作完成！" 10
)
if "%submenu_option%"=="0" exit /b
if /i "%submenu_option%"=="q" exit /b
goto desktop

:: 桌面添加网络连接
:desktop_add_network
mshta VBScript:Execute("Set ws=CreateObject(""WScript.Shell""):Set lnk=ws.CreateShortcut(ws.SpecialFolders(""Desktop"") & ""\网络连接.lnk""):lnk.TargetPath=""shell:::{7007ACC7-3202-11D1-AAD2-00805FC1270E}"":lnk.Save:close")
exit /b

:: 桌面添加IE快捷方式
:desktop_add_ie
setlocal
set "shortcutName=IE"
set "args=https://www.baidu.com/#ie={inputENcoding}^&wd=%%s -Embedding"
set "programFilesX86=%ProgramFiles(x86)%"
set "targetPath=%programFilesX86%\Internet Explorer\iexplore.exe"
set "workingDir=%programFilesX86%\Internet Explorer"
if not exist "%targetPath%" (
	call :sleep "错误：未找到 Internet Explorer，请确认已安装 IE11 或启用 Windows 功能。" 10
	endlocal & exit /b 1
)
powershell -command "$ws = New-Object -ComObject WScript.Shell; $lnk = $ws.CreateShortcut([Environment]::GetFolderPath('Desktop') + '\%shortcutName%.lnk'); $lnk.TargetPath = '%targetPath%'; $lnk.Arguments = '%args%'; $lnk.WorkingDirectory = '%workingDir%'; $lnk.Save()"
echo 快捷方式已创建在桌面：%shortcutName%.lnk
endlocal & exit /b 0

:: 删除桌面快捷方式
:desktop_delete_shortcut
del /f /q "%USERPROFILE%\Desktop\%~1.lnk" 2>nul
exit /b

:: 设置Bing每日桌面背景
:set_desktop_background
cls
for /f "usebackq delims=" %%P in (`powershell -nologo -noprofile -command "[Environment]::GetFolderPath('MyPictures')"`) do (
    set "downloadDir=%%P\BingWallpapers"
)
if not exist "!downloadDir!" mkdir "!downloadDir!"
for /f %%d in ('powershell -command "Get-Date -Format 'yyyyMMdd'"') do (set "today=%%d")
set "imageFile=!downloadDir!\bing_!today!.jpg"
if not exist "%imageFile%" (
	echo downloading...
    set "baseUrl=https://www.bing.com"
    for /f "delims=" %%i in ('powershell -Command "(Invoke-WebRequest '!baseUrl!/HPImageArchive.aspx?format=js&idx=0&n=1&nc=1614319565639&pid=hp&FORM=BEHPTB&uhd=1&uhdwidth=3840&uhdheight=2160').Content | ConvertFrom-Json | Select-Object -ExpandProperty images | Select-Object -ExpandProperty url" 2^>nul') do (
        set "imageUrl=!baseUrl!%%i"
    )
    if defined imageUrl (
        curl.exe --retry 2 --max-time 30 -so "!imageFile!" "!imageUrl!"
    )
)
if exist "!imageFile!" (
    echo 正在设置桌面背景...
    powershell -Command "Add-Type -TypeDefinition 'using System.Runtime.InteropServices; public class Wallpaper { [DllImport(\"user32.dll\", CharSet=CharSet.Auto)] public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni); }'; [void][Wallpaper]::SystemParametersInfo(20, 0, '!imageFile!', 3)"
	echo 桌面背景已更新为: !imageFile!
) else (
    echo 未能下载或找到图片文件
)
exit /b


:: 任务栏设置 
:taskbar 
mode con cols=70 lines=30
color 0A
call :print_title "任务栏设置" 30 
set "submenu_option=" 
call :print_separator "*" 70
echo   1. 一键净化任务栏                     11. 自动隐藏任务栏 — 开启 
echo   2. 禁用小组件                         12. 自动隐藏任务栏 — 关闭 
echo   3. 启用小组件                         13. 时间显示秒 
echo   4. 卸载小组件                         14. 时间隐藏秒（默认） 
echo   5. 安装小组件 
echo   6. 任务视图 — 隐藏 
echo   7. 任务视图 — 显示 
echo   8. 搜索 - 隐藏 
echo   9. 搜索 - 仅显示搜索图标 
echo  10. 清除固定（Edge、商店、资源管理器） 
echo   0. 返回(q) 
call :print_separator "*" 70
echo. 
set /p submenu_option=请输入你的选择: 
if "%submenu_option%"=="1" (
	call :hide_taskview
	call :hide_search
	call :taskbar_unpin
	call :widgets_uninstall
	call :restart_explorer
    call :sleep "操作完成！" 2
) else if "%submenu_option%"=="2" (
	call :widgets_disable
	call :restart_explorer
    call :sleep "操作完成！" 2
) else if "%submenu_option%"=="3" (
	call :widgets_enable
	call :restart_explorer
    call :sleep "操作完成！" 2
) else if "%submenu_option%"=="4" (
	call :widgets_uninstall
	call :restart_explorer
    call :sleep "操作完成！" 2
) else if "%submenu_option%"=="5" (
	call :widgets_install
	call :restart_explorer
    call :sleep "操作完成！" 2
)  else if "%submenu_option%"=="6" (
	call :hide_taskview
    call :sleep "操作完成！" 2
) else if "%submenu_option%"=="7" (
	call :show_taskview
    call :sleep "操作完成！" 2
) else if "%submenu_option%"=="8" (
	call :hide_search
    call :sleep "操作完成！" 2
) else if "%submenu_option%"=="9" (
	call :search_icon
    call :sleep "操作完成！" 2
) else if "%submenu_option%"=="10" (
	call :taskbar_unpin
	call :restart_explorer
    echo 操作完成！& timeout /t 2
) else if "%submenu_option%"=="11" (
	call :taskbar_auto_hide_on
    call :sleep "操作完成！" 2
) else if "%submenu_option%"=="12" (
	call :taskbar_auto_hide_off
    call :sleep "操作完成！" 2
) else if "%submenu_option%"=="13" (
	call :taskbar_time_second 1
	call :sleep "操作完成！" 2
) else if "%submenu_option%"=="14" (
	call :taskbar_time_second 0
	call :sleep "操作完成！" 2
)
if "%submenu_option%"=="0" exit /b
if /i "%submenu_option%"=="q" exit /b
goto taskbar

:widgets_disable
echo 正在禁用小组件...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarDa" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /t REG_DWORD /d 0 /f >nul 2>&1
sc config Widgets start= disabled >nul
sc stop Widgets >nul
sc config WebExperience start= disabled >nul
sc stop WebExperience >nul
echo 禁用小组件小组件...OK
exit /b

:widgets_enable
echo 正在启用小组件...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarDa" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /f >nul 2>&1
sc config Widgets start= demand >nul
sc config WebExperience start= demand >nul
sc start WebExperience >nul
echo 启用小组件...OK
exit /b

:widgets_uninstall
echo 正在卸载小组件...
winget uninstall "Windows Web Experience Pack" --accept-source-agreements
echo 卸载小组件...OK
exit /b

:widgets_install
echo 正在安装小组件...
winget install 9MSSGKG348SP --accept-package-agreements --accept-source-agreements
echo 安装小组件...OK
exit /b

:hide_taskview
echo 正在隐藏任务视图...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f >nul 2>&1
echo 隐藏任务视图...OK
exit /b

:show_taskview
echo 正在显示任务视图...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 1 /f >nul 2>&1
echo 显示任务视图...OK
exit /b

:hide_search
echo 正在隐藏搜索...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f >nul 2>&1
echo 正在隐藏搜索...OK
exit /b

:search_icon
echo 正在设置搜索图标... 
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 1 /f >nul 2>&1
echo 设置搜索图标...OK 
exit /b

:search_icon
echo 正在设置搜索图标... 
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 1 /f >nul 2>&1
echo 设置搜索图标...OK 
exit /b

:taskbar_unpin
echo 正在清除任务栏固定项目... 
del /f /q "%AppData%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*" >nul 2>&1
reg delete HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband /f >nul 2>&1
echo 正在清除任务栏固定项目...OK 
exit /b

:taskbar_auto_hide_on
echo 开启任务栏自动隐藏... 
powershell -Command "&{$p='HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3'; $v=(Get-ItemProperty -Path $p).Settings; $v[8]=3; Set-ItemProperty -Path $p -Name Settings -Value $v; Stop-Process -Name explorer -Force}"
exit /b

:taskbar_auto_hide_off
echo 关闭任务栏自动隐藏... 
powershell -Command "&{$p='HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3'; $v=(Get-ItemProperty -Path $p).Settings; $v[8]=2; Set-ItemProperty -Path $p -Name Settings -Value $v; Stop-Process -Name explorer -Force}"
exit /b

::任务栏时间显示秒 0:隐藏 1:显示
:taskbar_time_second
set value=%~1
if "%value%"=="1" (
    echo 设置任务栏时间显示秒 
) else if "%value%"=="0" (
    echo 设置任务栏时间隐藏秒 
)
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSecondsInSystemClock" /t REG_DWORD /d %value% /f >nul 2>&1
exit /b

:: 资源管理器设置 
:explorer_setting
call :print_title "资源管理器设置" 24
set "submenu_option=" 
call :print_separator
echo  1. 默认打开 此电脑 
echo  2. 默认打开 主文件夹 
echo  3. 显示 扩展(后缀)名 
echo  4. 隐藏 扩展(后缀)名 
echo  5. 单击 打开文件 
echo  6. 双击 打开文件 
echo  7. 显示 复选框 
echo  8. 隐藏 复选框 
echo  9. 显示 系统隐藏文件 
echo 10. 隐藏 系统隐藏文件 
echo 11. Windows 10 此电脑文件夹设置 
echo  0. 返回(q) 
call :print_separator
echo. 
set /p submenu_option=请输入你的选择: 
if "%submenu_option%"=="1" (
	reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f >nul 2>&1
	call :sleep "已设置默认打开此电脑！" 5
) else if "%submenu_option%"=="2" (
	reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 0 /f >nul 2>&1
	call :sleep "已设置默认打开主文件夹！" 5
) else if "%submenu_option%"=="3" (
	REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f
	call :restart_explorer
	call :sleep "已显示扩展名" 6
) else if "%submenu_option%"=="4" (
	REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 1 /f
	call :restart_explorer
	call :sleep "已隐藏扩展名" 6
) else if "%submenu_option%"=="5" (
	REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V IconUnderline /T REG_DWORD /D 2 /F >nul 2>&1
	REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V ShellState /T REG_BINARY /D 240000001ea8000000000000000000000000000001000000130000000000000062000000 /F >nul 2>&1
	call :restart_explorer
	call :sleep "已设置单击打开文件！" 3
) else if "%submenu_option%"=="6" (
	REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V ShellState /T REG_BINARY /D 240000003ea8000000000000000000000000000001000000130000000000000062000000 /F >nul 2>&1
	call :restart_explorer
	call :sleep "已设置双击打开文件！" 3
) else if "%submenu_option%"=="7" (
	reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "AutoCheckSelect" /t REG_DWORD /d 1 /f >nul 2>&1
	call :sleep "已显示复选框，手动刷新生效" 6
) else if "%submenu_option%"=="8" (
	reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "AutoCheckSelect" /t REG_DWORD /d 0 /f >nul 2>&1
	call :sleep "已隐藏复选框，手动刷新生效" 6
) else if "%submenu_option%"=="9" (
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 1 /f
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSuperHidden /t REG_DWORD /d 1 /f
	call :restart_explorer
	call :sleep "已显示系统隐藏文件，正在重启资源管理器" 6
) else if "%submenu_option%"=="10" (
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 2 /f >nul 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSuperHidden /t REG_DWORD /d 0 /f >nul 2>&1
	call :restart_explorer
	call :sleep "已隐藏系统隐藏文件，正在重启资源管理器" 6
) else if "%submenu_option%"=="11" (
	call :this_computer_folder
)
if "%submenu_option%"=="0" exit /b
if /i "%submenu_option%"=="q" exit /b
goto :explorer_setting

:: 下载 Office 
:download_office
call :print_title "下载 Office" 25
set "submenu_option="
call :print_separator
echo  1. xb21cn 
echo  2. Office Tool Plus 
echo  0. 返回(q) 
call :print_separator
echo.
set /p submenu_option=请输入你的选择: 
if "%submenu_option%"=="1" start "" https://www.xb21cn.com/
if "%submenu_option%"=="2" start powershell -NoProfile -ExecutionPolicy Bypass -Command "irm officetool.plus | iex"
if "%submenu_option%"=="0" exit /b
if /i "%submenu_option%"=="q" exit /b
goto :download_office

:: 下载 Windows
:download_windows
mode con cols=80 lines=25
call :print_title "下载 Windows" 32
set "submenu_option="
call :print_separator * 80
echo   1. 山己几子木      https://msdn.sjjzm.com/ 
echo   2. Microsoft官方   https://www.microsoft.com/zh-cn/software-download/ 
echo   3. NEXT,ITELLYOU   https://next.itellyou.cn/
echo   4. 不忘初心        https://www.pc528.net/
echo   5. 吻妻            https://www.newxitong.com/
echo   0. 返回(q) 
call :print_separator * 80
echo.
set /p submenu_option=请输入你的选择: 
if "%submenu_option%"=="1" start "" https://msdn.sjjzm.com/ 
if "%submenu_option%"=="2" start "" https://www.microsoft.com/zh-cn/software-download/ 
if "%submenu_option%"=="3" start "" https://next.itellyou.cn/
if "%submenu_option%"=="4" start "" https://www.pc528.net/
if "%submenu_option%"=="5" start "" https://www.newxitong.com/
if "%submenu_option%"=="0" exit /b
if /i "%submenu_option%"=="q" exit /b
goto download_windows

:: 激活 Windows & Office
:activate_windows
start powershell -Command "irm https://get.activated.win | iex"
exit /b

@REM From https://www.52pojie.cn/thread-1791338-1-1.html
:: Windows更新设置
:windows_update
call :print_title "Windows更新设置"
set "submenu_option="
call :print_separator
echo  1. 禁用Windows更新 
echo  2. 启用Windows更新 
echo  3. 暂停更新1000周*
echo  4. 暂停更新5周（默认） 
echo  0. 返回(q) 
call :print_separator "."
echo   建议选暂停更新1000周，影响较小。
call :print_separator
echo.
set /p submenu_option=请输入你的选择: 
if "%submenu_option%"=="1" (
	echo 正在禁用系统更新...
	net stop wuauserv
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "PauseDeferrals" /t REG_DWORD /d "0x1" /f  >nul 2>&1
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ElevateNonAdmins" /t REG_DWORD /d "0x1" /f  >nul 2>&1
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "UseWUServer" /t REG_DWORD /d "0x1" /f  >nul 2>&1
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUServer" /t REG_SZ /d "http://127.0.0.1" /f  >nul 2>&1
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUStatusServer" /t REG_SZ /d "http://127.0.0.1" /f  >nul 2>&1
	reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoWindowsUpdate" /t REG_DWORD /d "0x1" /f  >nul 2>&1
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d "0x1" /f  >nul 2>&1
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AutoInstallMinorUpdates" /t REG_DWORD /d "0x1" /f >nul 2>&1
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "DetectionFrequencyEnabled" /t REG_DWORD /d "0x0" /f >nul 2>&1
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "RescheduleWaitTimeEnabled" /t REG_DWORD /d "0x0" /f >nul 2>&1
	reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\WindowsUpdate" /v "DisableWindowsUpdateAccess" /t REG_DWORD /d "0x1" /f >nul 2>&1
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "RescheduleWaitTimeEnabled" /t REG_DWORD /d "0x1" /f >nul 2>&1
	reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\WAU" /v "Disabled" /t REG_DWORD /d "0x1" /f >nul 2>&1
	REG add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableOSUpgrade" /t REG_DWORD /d 1 /f >nul 2>&1
	REG add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
	REG add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
	REG add "HKLM\Software\Microsoft\Windows\CurrentVersion\WindowsUpdate\OSUpgrade" /v "ReservationsAllowed" /t REG_DWORD /d 0 /f >nul 2>&1
	REG add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Gwx" /v "DisableGwx" /t REG_DWORD /d 1 /f >nul 2>&1
	REG add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\EOSNotify" /v "DiscontinueEOS" /t REG_DWORD /d 1 /f >nul 2>&1
	net start wuauserv
	call :sleep "系统已禁止更新" 5
) else if "%submenu_option%"=="2" (
	echo 正在开启系统更新...
    net stop wuauserv
	REG delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "Start"  /f >nul 2>&1
	REG delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "Start"  /f >nul 2>&1
	REG add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "Start" /t REG_DWORD /d 2 /f >nul 2>&1
	REG delete "HKLM\Software\Microsoft\Windows\CurrentVersion\WindowsUpdate\OSUpgrade" /v "ReservationsAllowed" /f >nul 2>&1
	REG delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Gwx" /v "DisableGwx"  /f >nul 2>&1
	REG delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\EOSNotify" /v "DiscontinueEOS" /f >nul 2>&1
	reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "PauseDeferrals" /f >nul 2>&1
	reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ElevateNonAdmins" /f >nul 2>&1
	reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "UseWUServer" /f >nul 2>&1
	reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUServer"  /f >nul 2>&1
	reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUStatusServer" /f >nul 2>&1
	reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoWindowsUpdate" /f >nul 2>&1
	reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /f >nul 2>&1
	reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AutoInstallMinorUpdates" /f >nul 2>&1
	reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "DetectionFrequencyEnabled" /f >nul 2>&1
	reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\WindowsUpdate" /v "DisableWindowsUpdateAccess" /f >nul 2>&1
	reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "RescheduleWaitTimeEnabled" /f >nul 2>&1
	reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\WAU" /v "Disabled" /f >nul 2>&1
	REG delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableOSUpgrade"  /f >nul 2>&1
	net start wuauserv
	call :sleep "系统已开启更新" 5
) else if "%submenu_option%"=="3" (
	echo 暂停更新1000周...
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v FlightSettingsMaxPauseDays /t reg_dword /d 7000 /f >nul 2>&1
	start ms-settings:windowsupdate
	call :sleep "请手动选择暂停更新周期" 5
) else if "%submenu_option%"=="4" (
	echo 恢复默认暂停更新5周...
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v FlightSettingsMaxPauseDays /t reg_dword /d 35 /f >nul 2>&1
	start ms-settings:windowsupdate
	call :sleep "请手动选择暂停更新周期" 5
)
if "%submenu_option%"=="0" exit /b
if /i "%submenu_option%"=="q" exit /b
goto windows_update

:: Windows 10 此电脑文件夹管理
:this_computer_folder
call :print_title "Windows 10 此电脑文件夹管理"
set "submenu_option="
call :print_separator
echo   1. 隐藏 3D	 		 2. 恢复 3D 
echo   3. 隐藏 视频			 4. 恢复 视频 
echo   5. 隐藏 图片			 6. 恢复 图片 
echo   7. 隐藏 文档			 8. 恢复 文档 
echo   9. 隐藏 下载			10. 恢复 下载 
echo  11. 隐藏 音乐			12. 恢复 音乐 
echo  13. 隐藏 桌面			14. 恢复 桌面 
echo  15. 隐藏所有选项		16. 开启所有选项 
echo   0. 返回(q) 
call :print_separator
echo.
set /p submenu_option=请输入你的选择: 
if "%submenu_option%"=="1" (
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	Reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	call :restart_explorer
) else if "%submenu_option%"=="2" (
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	Reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	call :restart_explorer
) else if "%submenu_option%"=="3" (
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	Reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	call :restart_explorer
) else if "%submenu_option%"=="4" (
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	Reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	call :restart_explorer
) else if "%submenu_option%"=="5" (
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	Reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	call :restart_explorer
) else if "%submenu_option%"=="6" (
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	Reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	call :restart_explorer
) else if "%submenu_option%"=="7" (
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	Reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	call :restart_explorer
) else if "%submenu_option%"=="8" (
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	Reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	call :restart_explorer
) else if "%submenu_option%"=="9" (
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	Reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	call :restart_explorer
) else if "%submenu_option%"=="10" (
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	Reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	call :restart_explorer
) else if "%submenu_option%"=="11" (
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	Reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	call :restart_explorer
) else if "%submenu_option%"=="12" (
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	Reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	call :restart_explorer
) else if "%submenu_option%"=="13" (
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	Reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	call :restart_explorer
) else if "%submenu_option%"=="14" (
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	Reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	call :restart_explorer
) else if "%submenu_option%"=="15" (
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	Reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	Reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	Reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	Reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	Reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	Reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	Reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	call :restart_explorer
) else if "%submenu_option%"=="16" (
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	Reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	Reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	Reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	Reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	Reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	Reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	Reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	call :restart_explorer
)
if "%submenu_option%"=="0" exit /b
if /i "%submenu_option%"=="q" exit /b
goto this_computer_folder

:: UAC（用户账户控制）设置 子菜单 
:uac_setting 
call :print_title "UAC（用户账户控制）设置"
set "submenu_option=" 
call :print_separator
echo  1. 从不通知（静默模式，推荐开发调试） 
echo  2. 恢复默认（推荐普通用户） 
echo  3. 彻底关闭（EnableLUA=0，需重启，UWP不可用） 
echo  0. 返回(q) 
call :print_separator
echo.
set /p submenu_option=请输入你的选择: 
if "%submenu_option%"=="1" (
	echo 正在设置为“从不通知”...
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 0 /f >nul 2>&1
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v PromptOnSecureDesktop /t REG_DWORD /d 0 /f >nul 2>&1
	call :sleep "完成！" 3
) else if "%submenu_option%"=="2" (
	echo 正在恢复默认设置... 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 5 /f >nul 2>&1
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v PromptOnSecureDesktop /t REG_DWORD /d 1 /f >nul 2>&1
	call :sleep "完成！" 3
) else if "%submenu_option%"=="3" (
	echo 正在彻底关闭 UAC... 
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0 /f >nul 2>&1
	call :sleep "设置完成！请重启系统以生效。 " 5
)
if "%submenu_option%"=="0" exit /b
if /i "%submenu_option%"=="q" exit /b
goto uac_setting

:: WIFI密码
:wifi_password
call :print_title "WIFI密码" 25 
setlocal
echo 获取系统连接过的WIFI账号和密码
call :print_separator "="
for /f "tokens=2 delims=:" %%i in ('netsh wlan show profiles ^| findstr "All User Profile"') do (
	set "ssid=%%i"
	set "ssid=!ssid:~1!" 
	set "password="
	for /f "tokens=2 delims=:" %%j in ('netsh wlan show profile name^="!ssid!" key^=clear ^| findstr /C:"Key Content"') do (
		set "password=%%j"
		set "password=!password:~1!" 
	)
	set "output=!ssid!                         " 
	echo !output:~0,20! !password!
)
call :print_separator "="
echo 获取完毕,按键任意键继续 & pause>nul
endlocal & exit /b

:: 上帝模式
:god_mod
explorer shell:::{ED7BA470-8E54-465E-825C-99712043E01C}
exit /b

:: 电源管理 
:power_setting
call :print_title "电源管理" 25
set "submenu_option="
call :print_separator
echo  1. 禁用自动睡眠* 
echo  2. 打开电源选项 
echo  3. 禁用休眠(删除 hiberfil.sys)* 
echo  4. 启用休眠 
echo  0. 返回(q) 
call :print_separator "~"
echo 睡眠：保持内存通电，快速恢复(耗电少) 
echo 休眠：将内存数据保存到硬盘 hiberfil.sys 后完全关机(零耗电) 
call :print_separator
echo.
set /p submenu_option=请输入你的选择: 
if "%submenu_option%"=="1" (
	powercfg -change -standby-timeout-ac 0
	powercfg -change -standby-timeout-dc 0
	call :sleep "已禁用自动睡眠" 3
) else if "%submenu_option%"=="2" (
	control powercfg.cpl
) else if "%submenu_option%"=="3" (
	powercfg -h off
	call :sleep "已禁用休眠" 4
) else if "%submenu_option%"=="4" (
	powercfg -h on
	call :sleep "已启用休眠" 4
)
if "%submenu_option%"=="0" exit /b
if /i "%submenu_option%"=="q" exit /b
endlocal
goto power_setting

:: 上帝模式
:god_mod
explorer shell:::{ED7BA470-8E54-465E-825C-99712043E01C}
exit /b

:: 预装应用管理
:pre_installed_app
color 0A
mode con cols=60 lines=30
call :print_title "预装应用管理" 24
set "submenu_option="
call :print_separator
echo  1. 一键卸载预装应用 
echo  2. 打开程序和功能 
echo  3. 卸载OneDrive 
echo  4. 安装OneDrive 
echo  0. 返回(q) 
call :print_separator
where winget >nul 2>&1
if errorlevel 1 (
    echo 未找到winget程序，此功能暂不可用，你可以安装后再尝试
    echo https://apps.microsoft.com/store/detail/9NBLGGH4NNS1 & pause>nul
	exit /b
)
set /p submenu_option=请输入你的选择: 
if "%submenu_option%"=="1" (
	call :uninstall_preinstalled_apps
)else if "%submenu_option%"=="2" (
	start "" appwiz.cpl
)else if "%submenu_option%"=="3" (
	echo 卸载 OneDrive...
	call :uninstall_OneDrive
	call :sleep "OneDrive 已卸载！" 4
)else if "%submenu_option%"=="4" (
	echo 正在安装 OneDrive...
	call :install_OneDrive
	call :sleep "OneDrive 已安装！" 4
)
if "%submenu_option%"=="0" exit /b
if /i "%submenu_option%"=="q" exit /b
goto pre_installed_app

::卸载预装应用
:uninstall_preinstalled_apps
echo 预装的应用包括：
echo   Microsoft 365 Copilot
echo   Microsoft Clipchamp
echo   Microsoft To Do
echo   Microsoft 必应
echo   Solitaire ^& Casual Games
echo   Xbox、Xbox TCUI、Xbox Identity Provider
echo   反馈中心
echo   Power Automate
echo   资讯
echo   Outlook for Windows
echo   小组件
echo.
call :ask_confirm "是否进行卸载? [Y/n]? " y
if errorlevel 1 exit /b
echo 正在卸载Microsoft 365 Copilot
winget uninstall "Microsoft 365 Copilot" --accept-source-agreements
echo 正在卸载Microsoft Clipchamp
winget uninstall "Microsoft Clipchamp"
echo 正在卸载Microsoft To Do
winget uninstall "Microsoft To Do"
echo 正在卸载Microsoft 必应
winget uninstall "Microsoft 必应"
echo 正在卸载Solitaire ^& Casual Games
winget uninstall "Solitaire & Casual Games"
echo 正在卸载Xbox
winget uninstall "Xbox"
echo 正在卸载Xbox TCUI
winget uninstall "Xbox TCUI"
echo 正在卸载Xbox Identity Provider
winget uninstall "Xbox Identity Provider"
echo 正在卸载反馈中心
winget uninstall "反馈中心"
echo 正在卸载资讯
winget uninstall "资讯"
echo 正在卸载Power Automate
winget uninstall "Power Automate"
echo 正在卸载Outlook for Windows
winget uninstall "Outlook for Windows"
call :widgets_uninstall
echo 卸载预装应用完成 & timeout /t 4
exit /b

:: 卸载OneDrive
:uninstall_OneDrive
taskkill /f /im OneDrive.exe >nul 2>&1
if exist "%SystemRoot%\System32\OneDriveSetup.exe" (
	"%SystemRoot%\System32\OneDriveSetup.exe" /uninstall
) else if exist "%SystemRoot%\SysWOW64\OneDriveSetup.exe" (
	"%SystemRoot%\SysWOW64\OneDriveSetup.exe" /uninstall
)
timeout /t 5 /nobreak >nul
rd /s /q "%UserProfile%\OneDrive" >nul 2>&1
rd /s /q "%LocalAppData%\Microsoft\OneDrive" >nul 2>&1
rd /s /q "%ProgramData%\Microsoft OneDrive" >nul 2>&1
rd /s /q "%SystemDrive%\OneDriveTemp" >nul 2>&1
reg delete "HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >nul 2>&1
reg delete "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >nul 2>&1
exit /b

:: 安装OneDrive
:install_OneDrive
if exist "%SystemRoot%\System32\OneDriveSetup.exe" (
	"%SystemRoot%\System32\OneDriveSetup.exe"
) else if exist "%SystemRoot%\SysWOW64\OneDriveSetup.exe" (
	"%SystemRoot%\SysWOW64\OneDriveSetup.exe"
) else (
	call :sleep "找不到 OneDrive 安装程序，请手动下载安装！" 4 silent
	start "" https://www.microsoft.com/zh-cn/microsoft-365/onedrive/download
)
exit /b

:: 编辑hosts 
:hosts_editor
start "" notepad "%SystemRoot%\system32\drivers\etc\hosts"
exit /b

:network_setting
call :print_title "网络管理" 26
set "submenu_option="
call :print_separator
echo  1. 网络信息 
echo  2. 打开网络连接控制面板 
echo  3. 清除DNS缓存 
echo  4. ping检查 
echo  5. tracert路由追踪 
echo  6. 我的外网IP 
echo  7. 检查端口占用 
echo  8. 测速网 
echo  9. 安装telnet客户端 
echo 10. telehack.com
echo  0. 返回(q) 
call :print_separator
echo.
set /p "submenu_option=请输入你的选择: "
if "%submenu_option%"=="1" (
	set "command_line=ipconfig /all"
	start "!command_line!" cmd /k "!command_line!"
) else if "%submenu_option%"=="2" (
	start ncpa.cpl
) else if "%submenu_option%"=="3" (
	ipconfig /flushdns
	call :sleep " " 4
) else if "%submenu_option%"=="4" (
    echo.
    set "ping_target="
    set /p "ping_target=请输入要ping的IP或域名[默认: baidu.com]: "
    if "!ping_target!"=="" set "ping_target=baidu.com"
	call :ask_confirm "是否持续检查? [y/N]? " n
	if errorlevel 1 (
		set "ping_cmd=ping !ping_target! -t"
	) else (
		set "ping_cmd=ping !ping_target! -n 4"
	)
    start "Ping检查: !ping_target!" cmd /k "!ping_cmd!"
) else if "%submenu_option%"=="5" (
    echo.
    set "trace_target="
    set /p "trace_target=请输入要追踪的IP或域名[默认: baidu.com]: "
    if "!trace_target!"=="" set "trace_target=baidu.com"
    start "路由追踪: !trace_target!" cmd /k "tracert !trace_target!"
) else if "%submenu_option%"=="6" (
	echo.
	curl.exe -s -L --connect-timeout 5 --max-time 10 https://myip.ipip.net/
	echo https://myip.ipip.net 提供服务支持 & pause>nul
) else if "%submenu_option%"=="7" (
	call :search_port
	call :sleep "end.." 5
) else if "%submenu_option%"=="8" (
	start "" https://www.speedtest.cn/
) else if "%submenu_option%"=="9" (
	call :install_telnet
) else if "%submenu_option%"=="10" (
	call :start_telehack
)
if "%submenu_option%"=="0" exit /b
if /i "%submenu_option%"=="q" exit /b
goto :network_setting 

:search_port
set "S_PORT="
set /p S_PORT=请输入要查询的端口号： 
if not defined S_PORT exit /b
set "FOUND_PID="
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :%S_PORT% ^| findstr LISTENING') do (
    set "FOUND_PID=%%a"
    call :process_pid !FOUND_PID!
    exit /b
)
echo 没有发现有程序占用端口 %S_PORT%
exit /b

:process_pid
set "K_PID=%~1"
echo 端口 %S_PORT% 被占用，PID：%K_PID%
set "K_EXE="
for /f "usebackq delims=" %%p in (`powershell -NoProfile -Command "Try { (Get-Process -Id %K_PID%).Path } Catch { '' }"`) do (
    set "K_EXE=%%p"
)
if defined K_EXE (
    echo 占用程序路径：!K_EXE!
) else (
    echo 无法获取进程路径（可能是系统进程或权限不足）。
	exit /b
)
set "K_KILL="
set /p K_KILL=是否结束该进程？(y/N)： 
if /i "!K_KILL!"=="Y" (
    taskkill /PID %K_PID% /F
)
exit /b

:: 安装telnet客户端 
:install_telnet
powershell -Command "(Get-WindowsOptionalFeature -Online -FeatureName TelnetClient).State -eq 'Enabled'" | findstr "True" >nul
if %errorlevel% neq 0 (
    echo 安装 telnet 客户端... 
    powershell -Command "Enable-WindowsOptionalFeature -Online -FeatureName TelnetClient -All"
	call :sleep "telnet安装完成!" 4
) else (
	call :sleep "telnet客户端已经安装" 4
)
exit /b

:: 打开telehack
:start_telehack
echo. & echo Telehack是ARPANET和Usenet的风格化界面的在线模拟，于2010年匿名创建。它是一个完整的多用户模拟，包括26,600+模拟主机，其文件时间跨度为1985年至1990年。 
echo.
echo 回车开始 & pause>nul
start cmd /k "telnet telehack.com"
exit /b

:: 图一乐 
:hahaha
mode con cols=70 lines=30
setlocal enabledelayedexpansion
call :print_title "图一乐" 30
set "submenu_option="
call :print_separator "*" 70
echo  1. 假装更新            11. neal.fun             21. Poki(宝玩) 
echo  2. 黑客打字            12. 人类基准测试         22. 邦戈猫 
echo  3. 模拟macOS桌面       13. 时光邮局             23. 全历史 
echo  4. windows93           14. 全球在线广播         24. 对称光绘 
echo  5. IBM PC模拟器        15. 全球天气动态         25. 互联网坟墓 
echo  6. 侏罗纪公园系统      16. 全球航班追踪         26. 语保工程（方言） 
echo  7. Unix 系统模拟器     17. 魔性蠕虫             27. 无限缩放 
echo  8. 卡巴斯基网络威胁    18. 狗屁不通文章生成器   28. 无限马腿 
echo  9. 假装黑客            19. 能不能好好说话       29. 白噪音 
echo 10. 无用网站            20. 自由钢琴             30. 宇宙的刻度 
echo 31. 空难信息网          32. 童年在线游戏
echo  0. 返回(q) 
call :print_separator "*" 70
echo.
set /p "submenu_option=请输入你的选择（回车随机选一个）: "
if "%submenu_option%"=="" (
    set /a "rand_num=!random! %% 32 + 1"
    if !rand_num! lss 10 (set "submenu_option=0!rand_num!") else (set "submenu_option=!rand_num!")
    echo [随机选择了 !submenu_option!]
)
if "%submenu_option%"=="1"  start "" https://fakeupdate.net/ 
if "%submenu_option%"=="2"  start "" https://hackertyper.net/ 
if "%submenu_option%"=="3"  start "" https://turbomac.netlify.app/ 
if "%submenu_option%"=="4"  start "" https://www.windows93.net/ 
if "%submenu_option%"=="5"  start "" https://www.pcjs.org/ 
if "%submenu_option%"=="6"  start "" https://www.jurassicsystems.com/ 
if "%submenu_option%"=="7"  start "" https://www.masswerk.at/jsuix/index.html 
if "%submenu_option%"=="8"  start "" https://cybermap.kaspersky.com/cn 
if "%submenu_option%"=="9"  start "" https://geektyper.com/ 
if "%submenu_option%"=="10" start "" https://theuselessweb.com/ 
if "%submenu_option%"=="11" start "" https://neal.fun/ 
if "%submenu_option%"=="12" start "" https://humanbenchmark.com/ 
if "%submenu_option%"=="13" start "" https://www.hi2future.com/ 
if "%submenu_option%"=="14" start "" https://radio.garden/ 
if "%submenu_option%"=="15" start "" https://earth.nullschool.net/zh-cn/ 
if "%submenu_option%"=="16" start "" https://www.flightradar24.com/ 
if "%submenu_option%"=="17" start "" http://www.staggeringbeauty.com/ 
if "%submenu_option%"=="18" start "" https://suulnnka.github.io/BullshitGenerator/index.html 
if "%submenu_option%"=="19" start "" https://lab.magiconch.com/nbnhhsh/ 
if "%submenu_option%"=="20" start "" https://www.autopiano.cn/ 
if "%submenu_option%"=="21" start "" https://poki.com/zh 
if "%submenu_option%"=="22" start "" https://bongo.cat/ 
if "%submenu_option%"=="23" start "" https://www.allhistory.com/ 
if "%submenu_option%"=="24" start "" http://weavesilk.com/ 
if "%submenu_option%"=="25" start "" https://wiki.archiveteam.org/ 
if "%submenu_option%"=="26" start "" https://zhongguoyuyan.cn 
if "%submenu_option%"=="27" start "" https://zoomquilt.org/ 
if "%submenu_option%"=="28" start "" http://endless.horse/ 
if "%submenu_option%"=="29" start "" https://asoftmurmur.com/ 
if "%submenu_option%"=="30" start "" https://scaleofuniverse.com/zh 
if "%submenu_option%"=="31" start "" https://www.planecrashinfo.com/ 
if "%submenu_option%"=="32" start "" https://www.yikm.net/ 
if "%submenu_option%"=="0" endlocal & exit /b
if /i "%submenu_option%"=="q" endlocal & exit /b
goto :hahaha

:: 检查脚本更新 
:update_script
mode con cols=80 lines=25
call :print_title "检查更新" 35
call :print_separator "*" 80
set "jsonUrl=https://files.cnblogs.com/files/zjw-blog/config.json"
set "BAT_NEW_TMP=%TEMP%\wmtool.tmp"
set "UPDATE_SCRIPT=%TEMP%\_wmtool_update.bat"
echo.
for /f "usebackq tokens=1,* delims==" %%A in (`
    powershell -NoLogo -Command ^
    "$json = Invoke-RestMethod -Uri '%jsonUrl%' -UseBasicParsing;" ^
    "Write-Output ('remote_updated=' + $json.WindowsManageTool.updated);" ^
    "Write-Output ('remote_rversion=' + $json.WindowsManageTool.rversion);"^
	"Write-Output ('download_url=' + $json.WindowsManageTool.url);"
`) do (
    set "%%A=%%B"
)
echo        ┌─────────────────────────────┬────────────────────────────┐ 
echo        │             本地            │             最新           │ 
echo        ├─────────────────────────────┼────────────────────────────│ 
echo        │                             │                            │ 
echo        │     版本号：%rversion%          │     版本号：%remote_rversion%         │ 
echo        │                             │                            │ 
echo        │     更新时间：%updated%      │     更新时间：%remote_updated%     │ 
echo        │                             │                            │ 
echo        └─────────────────────────────┴────────────────────────────┘ 
echo.
if not defined remote_updated (
	call :sleep "无法获取远程更新日期，放弃更新。" 5
	exit /b
)
if %remote_updated% LEQ %updated% (
	call :sleep "已是最新版本，无需更新。" 10
	exit /b
)
echo 更新会替换本地bat文件，如果你有自定义修改请先备份后再更新。 
call :ask_confirm "检测到新版本，是否下载? (Y/n)? " y
if errorlevel 1 exit /b
call :sleep "正在下载..." 3
curl.exe -s -L --connect-timeout 5 --max-time 10 -o "%BAT_NEW_TMP%" "%download_url%"
if not exist "%BAT_NEW_TMP%" (
	call :sleep "下载最新文件文件失败。" 10
	exit /b
)
set "MAIN_SCRIPT_PATH=%~f0"
echo @echo off> "%UPDATE_SCRIPT%"
echo chcp 65001^>nul >> "%UPDATE_SCRIPT%"
echo echo 正在更新脚本，请稍候... >> "%UPDATE_SCRIPT%"
echo copy /Y "%BAT_NEW_TMP%" "%MAIN_SCRIPT_PATH%" >> "%UPDATE_SCRIPT%"
echo echo 更新完成，正在重新启动... >> "%UPDATE_SCRIPT%"
echo del "%BAT_NEW_TMP%" ^>nul 2^>nul >> "%UPDATE_SCRIPT%"
echo start "" "%MAIN_SCRIPT_PATH%" >> "%UPDATE_SCRIPT%"
echo exit >> "%UPDATE_SCRIPT%"
start "" "%UPDATE_SCRIPT%"
exit

:: 关于
:about_me
mode con cols=80 lines=25
call :print_title "关于" 36
call :print_separator "*" 80
echo.
echo    Windows-Manage-Tool(WMT),一个批处理Windows管理小工具，集成了多个系统设置 
echo    管理工具，旨在简化日常维护和系统设置操作。因为我比较懒，所以做了这个工具。 
echo. 
echo. 当前版本：%rversion% 
echo. 
echo  更新地址： 
echo. 
echo      https://github.com/Zhu-junwei/Windows-Manage-Tool
echo      https://wwqn.lanzoul.com/b0fpd626d 密码:enz1
echo      https://files.cnblogs.com/files/zjw-blog/WindowsManageTool.sh
echo.
echo  特别鸣谢： 
echo. 
echo      博客园 批处理之家 吾爱破解 GitHub 蓝奏云 ChatGPT DeepSeek 
echo.
echo ^<- 回车返回 & pause>nul
exit /b

:: 分割线
:: 参数1：分隔符字符，默认 *
:: 参数2：重复次数，默认 60
:print_separator
setlocal ENABLEDELAYEDEXPANSION
set "char=%~1" 
if "%char%"=="" set "char=*"
set "count=%~2"
if "%count%"=="" set "count=60"
set "line="
for /L %%i in (1,1,%count%) do (set "line=!line!!char!")
echo !line!
endlocal
exit /b

:: 打印标题 
:: 参数1 = 文本内容 
:print_title 
setlocal & cls 
set "title=%~1"
set "count=%~2"
if "%count%"=="" (
    set "space_str=                     " 
) else (
    set "space_str="
    for /L %%i in (1,1,%count%) do (set "space_str=!space_str! ")
)
echo.
echo !space_str!!title!
endlocal & exit /b

:restart_explorer
taskkill /f /im explorer.exe >nul 2>&1 & start explorer & exit /b

:: 选择询问 如果选了默认值，errorlevel是0，否则是1
:: 参数1：提示信息 
:: 参数2：默认值 
:ask_confirm
setlocal
set "input="
set /p "input=%~1"
if not defined input set "input=%~2"
if /i "%input%"=="%~2" (endlocal & exit /b 0) else (endlocal & exit /b 1)

:: 等待一会儿再继续 
:: 参数1：提示信息(默认"请稍候...") 
:: 参数2：等待时间(默认1s) 
:: 参数3：可选silent，是否静默等待（默认显示倒计时） 
:sleep
setlocal
set "msg=%~1" & set "sec=%~2" & set "silent=%~3"
if not defined msg set "msg=请稍候..." 
if not defined sec set "sec=1"
echo.%msg%
if /i "%silent%"=="silent" (
    timeout /t %sec% >nul
) else (
    timeout /t %sec%
)
endlocal & exit /b

:byebye
call :sleep "byebye" 1 silent
exit