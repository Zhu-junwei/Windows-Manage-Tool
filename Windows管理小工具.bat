@echo off & setlocal EnableDelayedExpansion & chcp 65001>nul

:: 使用管理员权限 
if "%1" neq "runas" mshta vbscript:CreateObject("Shell.Application").ShellExecute("conhost.exe","cmd.exe /c ""%~f0"" runas %*","","runas",1)(window.close)&&exit
shift && cd /d "%~dp0"

:: 一些配置参数 
set "color=0A"
set "title=Windows管理小工具"
set "updated=20250808"
set "rversion=v2.1.6"
set "cols=100"
set "lines=40"
set "separator=="
title %title% %rversion%
call :reset_color_size
:: 接收传参来直接调用特定的子程序 
if not "%~1"=="" (call :%~1 & exit)

:: 主菜单 
:main_menu 
call :reset_color_size
call :print_title "%title%"
set "c="
call :print_separator
echo			1. 右键菜单设置                  11. 电源管理 &echo.
echo			2. 桌面设置                      12. 应用管理 &echo.
echo			3. 任务栏设置                    13. 编辑hosts &echo.
echo			4. 资源管理器设置                14. 网络管理 &echo.
echo			5. 下载 Windows ^& Office         15. 设备管理 &echo.
echo			6. 激活 Windows ^& Office         16. 图一乐 &echo.
echo			7. Windows更新设置                &echo.
echo			8. UAC（用户账户控制）设置 &echo.
echo			9. 上帝模式 &echo.
echo			10. WIFI密码 &echo.
echo			0. 退出(q)                       00. 关于&echo.
call :print_separator
set /p c=请输入你的选择: 
if "%c%"=="1"  call :submenu_right_click
if "%c%"=="2"  call :desktop
if "%c%"=="3"  call :taskbar
if "%c%"=="4"  call :explorer_setting
if "%c%"=="5"  call :download_windows_office
if "%c%"=="6"  call :activate_windows_office
if "%c%"=="7"  call :windows_update
if "%c%"=="8"  call :uac_setting
if "%c%"=="9" call :god_mod
if "%c%"=="10" call :wifi_password
if "%c%"=="11" call :power_setting
if "%c%"=="12" call :app_setting
if "%c%"=="13" call :hosts_editor
if "%c%"=="14" call :network_setting
if "%c%"=="15" call :device_setting
if "%c%"=="16" call :hahaha
if "%c%"=="00" call :about_me
if "%c%"=="0"  goto byebye
if /i "%c%"=="q" goto byebye
goto main_menu 

:: 右键菜单设置子菜单 
:submenu_right_click
call :print_title "右键菜单设置"
set "a="
call :print_separator
echo				1. 切换 Windows 10 右键菜单 & echo.
echo				2. 恢复 Windows 11 右键菜单 & echo.
echo				3. 添加超级菜单 & echo.
echo				4. 删除超级菜单 & echo.
echo				5. 添加Hash右键菜单 & echo.
echo				6. 删除Hash右键菜单 & echo.
echo				0. 返回(q)  & echo.
call :print_separator
set /p a=请输入你的选择: 
if "%a%"=="1" ( 
    reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve >nul 2>&1
    call :restart_explorer
) else if "%a%"=="2" ( 
    reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f  >nul 2>&1
    call :restart_explorer
) else if "%a%"=="3" (
	echo 添加超级菜单...
	call :add_SuperMenu
	call :sleep "添加超级菜单成功!" 5
) else if "%a%"=="4" ( 
	echo 删除超级菜单...
	call :delete_SuperMenu
	call :sleep "超级菜单已删除" 5
) else if "%a%"=="5" ( 
	reg add "HKCR\*\shell\GetFileHash" /v "MUIVerb" /t REG_SZ /d "Hash" /f >nul 2>&1
	reg add "HKCR\*\shell\GetFileHash" /v "Icon" /t REG_SZ /d "shell32.dll,-42" /f>nul 2>&1 
	reg add "HKCR\*\shell\GetFileHash" /v "SubCommands" /t REG_SZ /d "" /f >nul 2>&1
	reg add "HKCR\*\shell\GetFileHash\shell\01SHA1" /v "MUIVerb" /t REG_SZ /d "SHA1" /f >nul 2>&1
	reg add "HKCR\*\shell\GetFileHash\shell\01SHA1\command" /ve /t REG_SZ /d "powershell -noexit -command \"get-filehash -literalpath '%%1' -algorithm SHA1 ^| format-list\"" /f >nul 2>&1
	reg add "HKCR\*\shell\GetFileHash\shell\02SHA256" /v "MUIVerb" /t REG_SZ /d "SHA256" /f >nul 2>&1
	reg add "HKCR\*\shell\GetFileHash\shell\02SHA256\command" /ve /t REG_SZ /d "powershell -noexit -command \"get-filehash -literalpath '%%1' -algorithm SHA256 ^| format-list\"" /f >nul 2>&1
	reg add "HKCR\*\shell\GetFileHash\shell\03SHA384" /v "MUIVerb" /t REG_SZ /d "SHA384" /f >nul 2>&1
	reg add "HKCR\*\shell\GetFileHash\shell\03SHA384\command" /ve /t REG_SZ /d "powershell -noexit -command \"get-filehash -literalpath '%%1' -algorithm SHA384 ^| format-list\"" /f >nul 2>&1
	reg add "HKCR\*\shell\GetFileHash\shell\04SHA512" /v "MUIVerb" /t REG_SZ /d "SHA512" /f >nul 2>&1
	reg add "HKCR\*\shell\GetFileHash\shell\04SHA512\command" /ve /t REG_SZ /d "powershell -noexit -command \"get-filehash -literalpath '%%1' -algorithm SHA512 ^| format-list\"" /f >nul 2>&1
	reg add "HKCR\*\shell\GetFileHash\shell\05MACTripleDES" /v "MUIVerb" /t REG_SZ /d "MACTripleDES" /f >nul 2>&1
	reg add "HKCR\*\shell\GetFileHash\shell\05MACTripleDES\command" /ve /t REG_SZ /d "powershell -noexit -command \"get-filehash -literalpath '%%1' -algorithm MACTripleDES ^| format-list\"" /f >nul 2>&1
	reg add "HKCR\*\shell\GetFileHash\shell\06MD5" /v "MUIVerb" /t REG_SZ /d "MD5" /f >nul 2>&1
	reg add "HKCR\*\shell\GetFileHash\shell\06MD5\command" /ve /t REG_SZ /d "powershell -noexit -command \"get-filehash -literalpath '%%1' -algorithm MD5 ^| format-list\"" /f >nul 2>&1
	reg add "HKCR\*\shell\GetFileHash\shell\07RIPEMD160" /v "MUIVerb" /t REG_SZ /d "RIPEMD160" /f >nul 2>&1
	reg add "HKCR\*\shell\GetFileHash\shell\07RIPEMD160\command" /ve /t REG_SZ /d "powershell -noexit -command \"get-filehash -literalpath '%%1' -algorithm RIPEMD160 ^| format-list\"" /f >nul 2>&1
	call :sleep "添加Hash右键菜单完成!" 3
)  else if "%a%"=="6" ( 
	echo 正在删除Hash右键菜单...
	reg delete "HKCR\*\shell\GetFileHash" /f >nul 2>&1
	call :sleep "Hash右键菜单已删除!" 3
)
if "%a%"=="0" exit /b
if /i "%a%"=="q" exit /b
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
call :print_title "桌面设置" 
set "a="
call :print_separator
echo				1. 隐藏桌面图标小箭头 & echo.
echo				2. 显示桌面图标小箭头 & echo.
echo				3. 隐藏了解此图片（windows聚焦） & echo.
echo				4. 显示了解此图片（windows聚焦） & echo.
echo				5. 打开桌面图标设置 & echo.
echo				6. 添加网络连接 & echo.
echo				7. 添加IE快捷方式& echo.
echo				8. 显示windows版本水印 & echo.
echo				9. 隐藏windows版本水印& echo.
echo				10. 设置Bing每日桌面背景& echo.
echo				0. 返回(q) & echo.
call :print_separator
set /p a=请输入你的选择: 
if "%a%"=="1" (
	echo 正在隐藏桌面图标小箭头...
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29 /d "%systemroot%\system32\imageres.dll,197" /t reg_sz /f >nul 2>&1
	attrib -s -r -h "%userprofile%\AppData\Local\iconcache.db" >nul 2>&1
	del "%userprofile%\AppData\Local\iconcache.db" /f /q >nul 2>&1
	call :restart_explorer
	call :sleep "操作完成！" 2
) else if "%a%"=="2" (
	echo 正在显示桌面图标小箭头...
	reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29 /f >nul 2>&1
	attrib -s -r -h "%userprofile%\AppData\Local\iconcache.db" >nul 2>&1
	del "%userprofile%\AppData\Local\iconcache.db" /f /q >nul 2>&1
	call :restart_explorer
	call :sleep "操作完成！" 2
) else if "%a%"=="3" (
	echo 正在隐藏了解此图片...
	REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{2cc5ca98-6485-489a-920e-b3e88a6ccce3}" /t REG_DWORD /d 1 /f >nul 2>&1
	call :restart_explorer
	call :sleep "操作完成！" 2
) else if "%a%"=="4" (
	echo 正在显示了解此图片...
	REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{2cc5ca98-6485-489a-920e-b3e88a6ccce3}" /f >nul 2>&1
	call :restart_explorer
	call :sleep "操作完成！" 2
) else if "%a%"=="5" (
	rundll32 shell32.dll,Control_RunDLL desk.cpl,,0
)else if "%a%"=="6" (
	call :desktop_add_network
	call :sleep "网络连接已添加！" 3
)else if "%a%"=="7" (
	call :desktop_add_ie
	set "add_result=快捷方式创建成功！"
	if %ERRORLEVEL% equ 1 set "add_result=快捷方式创建失败！"
	echo %add_result%！& timeout /t 3
)else if "%a%"=="8" (
	REG ADD "HKCU\Control Panel\Desktop" /V PaintDesktopVersion /T REG_DWORD /D 1 /F >nul 2>&1
	call :restart_explorer
	call :sleep "操作完成！" 2
)else if "%a%"=="9" (
	REG ADD "HKCU\Control Panel\Desktop" /V PaintDesktopVersion /T REG_DWORD /D 0 /F >nul 2>&1
	call :restart_explorer
	call :sleep "操作完成！" 2
)else if "%a%"=="10" (
	call :set_desktop_background
	call :sleep "10秒后自动返回..." 10
)
if "%a%"=="0" exit /b
if /i "%a%"=="q" exit /b
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
setlocal EnableDelayedExpansion
for /f "usebackq delims=" %%P in (`powershell -nologo -noprofile -command "[Environment]::GetFolderPath('MyPictures')"`) do (
    set "downloadDir=%%P\BingWallpapers"
)
if not exist "!downloadDir!" mkdir "!downloadDir!"
echo 正在获取图片信息... 
set "baseUrl=https://www.bing.com"
set "jsonUrl=!baseUrl!/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=zh-CN&nc=1614319565639&pid=hp&FORM=BEHPTB&uhd=1&uhdwidth=3840&uhdheight=2160"
for /f "usebackq tokens=1,* delims==" %%A in (`
	powershell -nologo -command ^
    "$json = Invoke-RestMethod -Uri '!jsonUrl!' -UseBasicParsing;" ^
    "$img = $json.images[0];" ^
    "Write-Output ('imageUrl=!baseUrl!' + $img.url);" ^
    "Write-Output ('imageName=' + $img.enddate + '_'+ $img.title);" ^
`) do (
    set "%%A=%%B"
)
set "imageFile=!downloadDir!\!imageName!.jpg"
if not exist !imageFile! (
    if "!imageUrl:~20,1!" NEQ "" (
		echo 正在下载图片：!imageName!.jpg
		curl.exe --retry 2 --max-time 30 -so "!imageFile!" "!imageUrl!"
	)
) else echo 图片!imageName!.jpg已存在，跳过下载 
if exist "!imageFile!" (
    echo 正在设置桌面背景...
    powershell -Command "Add-Type -TypeDefinition 'using System.Runtime.InteropServices; public class Wallpaper { [DllImport(\"user32.dll\", CharSet=CharSet.Auto)] public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni); }'; [void][Wallpaper]::SystemParametersInfo(20, 0, '!imageFile!', 3)"
	echo 桌面背景已更新为: !imageFile!
) else (
    echo 未能下载或找到图片文件 
)
endlocal & exit /b

:: 任务栏设置 
:taskbar 
call :reset_color_size
call :print_title "任务栏设置"
set "a=" 
call :print_separator
echo			1. 一键净化任务栏                     11. 自动隐藏任务栏 — 开启 &echo.
echo			2. 禁用小组件                         12. 自动隐藏任务栏 — 关闭 &echo.
echo			3. 启用小组件                         13. 时间显示秒 &echo.
echo			4. 卸载小组件                         14. 时间隐藏秒（默认） &echo.
echo			5. 安装小组件 &echo.
echo			6. 任务视图 — 隐藏 &echo.
echo			7. 任务视图 — 显示 &echo.
echo			8. 搜索 - 隐藏 &echo.
echo			9. 搜索 - 仅显示搜索图标 &echo.
echo			10. 清除固定（Edge、商店、资源管理器） &echo.
echo			0. 返回(q) &echo.
call :print_separator
set /p a=请输入你的选择: 
if "%a%"=="1" (
	call :hide_taskview
	call :hide_search
	call :taskbar_unpin
	call :widgets_uninstall
	call :restart_explorer
	call :sleep "操作完成！" 2
) else if "%a%"=="2" (
	call :widgets_disable
	call :restart_explorer
	call :sleep "操作完成！" 2
) else if "%a%"=="3" (
	call :widgets_enable
	call :restart_explorer
	call :sleep "操作完成！" 2
) else if "%a%"=="4" (
	call :widgets_uninstall
	call :restart_explorer
	call :sleep "操作完成！" 2
) else if "%a%"=="5" (
	call :widgets_install
	call :restart_explorer
	call :sleep "操作完成！" 2
) else if "%a%"=="6" (
	call :hide_taskview
	call :sleep "操作完成！" 2
) else if "%a%"=="7" (
	call :show_taskview
    call :sleep "操作完成！" 2
) else if "%a%"=="8" (
	call :hide_search
    call :sleep "操作完成！" 2
) else if "%a%"=="9" (
	call :search_icon
    call :sleep "操作完成！" 2
) else if "%a%"=="10" (
	call :taskbar_unpin
	call :restart_explorer
    echo 操作完成！& timeout /t 2
) else if "%a%"=="11" (
	call :taskbar_auto_hide_on
    call :sleep "操作完成！" 2
) else if "%a%"=="12" (
	call :taskbar_auto_hide_off
    call :sleep "操作完成！" 2
) else if "%a%"=="13" (
	call :taskbar_time_second 1
	call :sleep "操作完成！" 2
) else if "%a%"=="14" (
	call :taskbar_time_second 0
	call :sleep "操作完成！" 2
)
if "%a%"=="0" exit /b
if /i "%a%"=="q" exit /b
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
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSecondsInSystemClock" /t REG_DWORD /d %value% /f >nul 2>&1
exit /b

:: 资源管理器设置 
:explorer_setting
call :print_title "资源管理器设置"
set "a=" 
call :print_separator
echo			 1. 默认打开[此电脑/主文件夹]         11. Windows 10此电脑文件夹设置 &echo.
echo			 2. 文件扩展(后缀)名开关 &echo.
echo			 3. [单击/双击]打开文件 &echo.
echo			 4. [显示/隐藏]复选框 &echo.
echo			 5. [显示/隐藏]系统隐藏文件 &echo.
echo			 6. U盘禁用开关 &echo.
echo			 7. 导航栏-主文件夹开关 &echo.
echo			 8. 导航栏-图库开关 &echo.
echo			 9. 导航栏-控制面板开关 &echo.
echo			10. 清理图标/缩略图缓存 &echo.
echo			 0. 返回(q) &echo.
call :print_separator
set /p "a=请输入你的选择:"
if "%a%"=="1" (
	echo 正在执行默认打开此电脑主文件夹设置...
	choice /c 12 /n /m "请选择你的操作? [1.主文件夹(系统默认) 2.此电脑]:"
	if errorlevel 2 (
		reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f >nul 2>&1
		call :sleep "已设置默认打开此电脑！" 5
	) else (
		reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 0 /f >nul 2>&1
		call :sleep "已设置默认打开主文件夹！" 5
	)
) else if "%a%"=="2" (
	echo.&echo 文件扩展（后缀）名设置 
	choice /c 12 /n /m "请选择你的操作? [1.显示 2.隐藏（系统默认）]: "
	if errorlevel 2 (
		reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 1 /f >nul 2>&1
		call :restart_explorer
		call :sleep "已隐藏扩展名" 6
	) else (
		reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f >nul 2>&1
		call :restart_explorer
		call :sleep "已显示扩展名" 6
	)
) else if "%a%"=="3" (
	echo.&echo [单击/双击]打开文件设置 
	choice /c 12 /n /m "请选择你的操作? [1.单击 2.双击（系统默认）]: "
	if errorlevel 2 (
		reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V ShellState /T REG_BINARY /D 240000003ea8000000000000000000000000000001000000130000000000000062000000 /F >nul 2>&1
		call :restart_explorer
		call :sleep "已设置双击打开文件！" 3
	) else (
		reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V IconUnderline /T REG_DWORD /D 2 /F >nul 2>&1
		reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V ShellState /T REG_BINARY /D 240000001ea8000000000000000000000000000001000000130000000000000062000000 /F >nul 2>&1
		call :restart_explorer
		call :sleep "已设置单击打开文件！" 3
	)
) else if "%a%"=="4" (
	echo.&echo [显示/隐藏]复选框 
	choice /c 12 /n /m "请选择你的操作? [1.显示 2.隐藏（系统默认）]: "
	if errorlevel 2 (
		reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "AutoCheckSelect" /t REG_DWORD /d 0 /f >nul 2>&1
		call :sleep "已隐藏复选框，手动刷新生效" 6
	) else (
		reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "AutoCheckSelect" /t REG_DWORD /d 1 /f >nul 2>&1
		call :sleep "已显示复选框，手动刷新生效" 6
	)
) else if "%a%"=="5" (
	echo.&echo [显示/隐藏]系统隐藏文件 
	choice /c 12 /n /m "请选择你的操作? [1.显示 2.隐藏（系统默认）]: "
	if errorlevel 2 (
		reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 2 /f >nul 2>&1
		reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSuperHidden /t REG_DWORD /d 0 /f >nul 2>&1
		call :restart_explorer
		call :sleep "已隐藏系统隐藏文件，正在重启资源管理器" 6
	) else (
		reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 1 /f >nul 2>&1
		reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSuperHidden /t REG_DWORD /d 1 /f >nul 2>&1
		call :restart_explorer
		call :sleep "已显示系统隐藏文件，正在重启资源管理器" 6
	)
) else if "%a%"=="6" (
	echo.echo 开启或禁用插入U盘 
	choice /c 12 /n /m "请选择你的操作? [1.启用（系统默认） 2.禁用]:"
	if errorlevel 2 (
		reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBSTOR" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
		call :sleep "已禁用U盘使用" 6
	) else (
		reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBSTOR" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
		call :sleep "已启用U盘使用" 6
	)
) else if "%a%"=="7" (
	call :explorer_home_folder_toggle
) else if "%a%"=="8" (
	call :explorer_gallery_toggle
) else if "%a%"=="9" (
	choice /c 12 /n /m "控制面板设置? [1.隐藏（系统默认） 2.显示]: "
	if errorlevel 2 (
		reg add "HKCU\Software\Classes\CLSID\{26EE0668-A00A-44D7-9371-BEB064C98683}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 1 /f >nul 2>&1
		call :restart_explorer
		call :sleep "已显示控制面板" 6
	) else (
		reg add "HKCU\Software\Classes\CLSID\{26EE0668-A00A-44D7-9371-BEB064C98683}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f >nul 2>&1
		call :restart_explorer
		call :sleep "已隐藏控制面板" 6
	)
) else if "%a%"=="10" (
	call :clear_icon_cache
) else if "%a%"=="11" (
	call :this_computer_folder
)
if "%a%"=="0" exit /b
if /i "%a%"=="q" exit /b
goto :explorer_setting

:: 资源管理器-导航栏-主文件夹 
:explorer_home_folder_toggle
set "HOME_FOLDER_TOGGLE_REG=tmp.reg"
choice /c 123 /n /m "主文件夹设置? [1.隐藏 2.显示 3.返回]: "
if "%errorlevel%"=="3" exit /b
if "%errorlevel%"=="1" (set "v=0" & set "op_name=隐藏") else (set "v=1" & set "op_name=显示")
(
	echo Windows Registry Editor Version 5.00
	echo.
	echo [HKEY_CURRENT_USER\Software\Classes\CLSID\{f874310e-b6b7-47dc-bc84-b9e6b38f5903}]
	echo "System.IsPinnedToNameSpaceTree"=dword:0000000%v%
) > "%HOME_FOLDER_TOGGLE_REG%"
regedit.exe /s "%HOME_FOLDER_TOGGLE_REG%"
IF EXIST "%HOME_FOLDER_TOGGLE_REG%" DEL "%HOME_FOLDER_TOGGLE_REG%"
call :sleep "已设置主文件夹 %op_name% ，请重新打开资源管理器查看效果" 10
exit /b

:: 资源管理器设置-导航栏-图库 
:explorer_gallery_toggle
set "GALLERY_TOGGLE_REG=tmp.reg"
choice /c 123 /n /m "图库设置? [1.隐藏 2.显示 3.返回]: "
if "%errorlevel%"=="3" exit /b
if "%errorlevel%"=="1" (set "v=0" & set "op_name=隐藏") else (set "v=1" & set "op_name=显示")
(
	echo Windows Registry Editor Version 5.00
	echo.
	echo [HKEY_CURRENT_USER\Software\Classes\CLSID\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}]
	echo "System.IsPinnedToNameSpaceTree"=dword:0000000%v%
) > "%GALLERY_TOGGLE_REG%"
regedit.exe /s "%GALLERY_TOGGLE_REG%"
IF EXIST "%GALLERY_TOGGLE_REG%" DEL "%GALLERY_TOGGLE_REG%"
call :sleep "已设置图库 %op_name% ，请重新打开资源管理器查看效果" 10
exit /b

:: 清理图标/缩略图缓存 
:clear_icon_cache
taskkill /f /im explorer.exe >nul 2>&1
echo 正在删除图标缓存...
del /f /s /q "%localappdata%\IconCache.db" >nul 2>&1
del /f /s /q "%localappdata%\Microsoft\Windows\Explorer\iconcache*" >nul 2>&1
echo 正在清理缩略图缓存...
del /f /s /q "%localappdata%\Microsoft\Windows\Explorer\thumbcache_*" >nul 2>&1
call :restart_explorer
call :sleep "清理完成" 6
exit /b

:: Windows 10 此电脑文件夹管理
:this_computer_folder
call :print_title "Windows 10 此电脑文件夹管理"
set "a="
call :print_separator
echo			1. 隐藏 3D	 		 2. 恢复 3D &echo.
echo			3. 隐藏 视频			 4. 恢复 视频 &echo.
echo			5. 隐藏 图片			 6. 恢复 图片 &echo.
echo			7. 隐藏 文档			 8. 恢复 文档 &echo.
echo			9. 隐藏 下载			10. 恢复 下载 &echo.
echo			11. 隐藏 音乐			12. 恢复 音乐 &echo.
echo			13. 隐藏 桌面			14. 恢复 桌面 &echo.
echo			15. 隐藏所有选项		16. 开启所有选项 &echo.
echo			0. 返回(q) &echo.
call :print_separator
echo.
set /p b=请输入你的选择: 
if "%b%"=="1" (
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	Reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	call :restart_explorer
) else if "%b%"=="2" (
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	Reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	call :restart_explorer
) else if "%b%"=="3" (
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	Reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	call :restart_explorer
) else if "%b%"=="4" (
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	Reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	call :restart_explorer
) else if "%b%"=="5" (
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	Reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	call :restart_explorer
) else if "%b%"=="6" (
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	Reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	call :restart_explorer
) else if "%b%"=="7" (
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	Reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	call :restart_explorer
) else if "%b%"=="8" (
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	Reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	call :restart_explorer
) else if "%b%"=="9" (
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	Reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	call :restart_explorer
) else if "%b%"=="10" (
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	Reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	call :restart_explorer
) else if "%b%"=="11" (
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	Reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	call :restart_explorer
) else if "%b%"=="12" (
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	Reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	call :restart_explorer
) else if "%b%"=="13" (
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	Reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
	call :restart_explorer
) else if "%b%"=="14" (
	Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	Reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Show" /f
	call :restart_explorer
) else if "%b%"=="15" (
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
) else if "%b%"=="16" (
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
if "%b%"=="0" exit /b
if /i "%b%"=="q" exit /b
goto this_computer_folder

:: 下载 Windows
:download_windows_office
call :print_title "下载 Windows & Office"
set "a="
call :print_separator
echo		Windows:&echo.
echo			1. 山己几子木      https://msdn.sjjzm.com/ &echo.
echo			2. Microsoft官方   https://www.microsoft.com/zh-cn/software-download/ &echo.
echo			3. NEXT,ITELLYOU   https://next.itellyou.cn/ &echo.
echo			4. 不忘初心        https://www.pc528.net/ &echo.
echo			5. 吻妻            https://www.newxitong.com/ &echo.
echo		Office:&echo.
echo			a. xb21cn              https://www.xb21cn.com/ &echo.
echo			b. Office Tool Plus    https://www.officetool.plus/zh-cn/ &echo.
echo			c. Microsoft官方       https://setup.office.com/ &echo.&echo.
echo			0. 返回(q) &echo.
call :print_separator
set /p a=请输入你的选择: 
if "%a%"=="1" start "" https://msdn.sjjzm.com/ 
if "%a%"=="2" start "" https://www.microsoft.com/zh-cn/software-download/ 
if "%a%"=="3" start "" https://next.itellyou.cn/
if "%a%"=="4" start "" https://www.pc528.net/
if "%a%"=="5" start "" https://www.newxitong.com/
if /i "%a%"=="a" start "" https://www.xb21cn.com/
if /i "%a%"=="b" start powershell -NoProfile -ExecutionPolicy Bypass -Command "irm officetool.plus | iex"
if /i "%a%"=="c" start "" https://setup.office.com/
if "%a%"=="0" exit /b
if /i "%a%"=="q" exit /b
goto download_windows_office

:: 激活 Windows & Office
:activate_windows_office
call :print_title "激活 Windows & Office"
set "a="
call :print_separator
echo			1. Microsoft Activation Scripts (MAS) &echo.
echo			2. HEU_KMS_Activator &echo.
echo			3. KMS_VL_ALL_AIO &echo.
echo			0. 返回(q) &echo.
call :print_separator
echo.
set /p a=请输入你的选择: 
if "%a%"=="1" (
	start powershell -Command "irm https://get.activated.win | iex"
) else if "%a%"=="2" (
	start "" https://github.com/zbezj/HEU_KMS_Activator/releases
) else if "%a%"=="3" (
	start "" https://github.com/abbodi1406/KMS_VL_ALL_AIO/releases
)
if "%a%"=="0" exit /b
if /i "%a%"=="q" exit /b
goto activate_windows_office
exit /b

@REM From https://www.52pojie.cn/thread-1791338-1-1.html
:: Windows更新设置
:windows_update
call :print_title "Windows更新设置"
set "a="
call :print_separator
echo			1. 禁用Windows更新 &echo.
echo			2. 启用Windows更新 &echo.
echo			3. 暂停更新1000周* &echo.
echo			4. 暂停更新5周（默认） &echo.
echo			0. 返回(q) &echo.
call :print_separator "."
echo		建议选暂停更新1000周，影响较小。&echo.
call :print_separator
echo.
set /p a=请输入你的选择: 
if "%a%"=="1" (
	echo 正在禁用系统更新...
	net stop wuauserv
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "PauseDeferrals" /t REG_DWORD /d "0x1" /f  >nul 2>&1
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ElevateNonAdmins" /t REG_DWORD /d "0x1" /f  >nul 2>&1
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "UseWUServer" /t REG_DWORD /d "0x1" /f  >nul 2>&1
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUServer" /t REG_SZ /d "http://127.0.0.1" /f  >nul 2>&1
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUStatusServer" /t REG_SZ /d "http://127.0.0.1" /f  >nul 2>&1
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoWindowsUpdate" /t REG_DWORD /d "0x1" /f  >nul 2>&1
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d "0x1" /f  >nul 2>&1
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AutoInstallMinorUpdates" /t REG_DWORD /d "0x1" /f >nul 2>&1
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "DetectionFrequencyEnabled" /t REG_DWORD /d "0x0" /f >nul 2>&1
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "RescheduleWaitTimeEnabled" /t REG_DWORD /d "0x0" /f >nul 2>&1
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\WindowsUpdate" /v "DisableWindowsUpdateAccess" /t REG_DWORD /d "0x1" /f >nul 2>&1
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "RescheduleWaitTimeEnabled" /t REG_DWORD /d "0x1" /f >nul 2>&1
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\WAU" /v "Disabled" /t REG_DWORD /d "0x1" /f >nul 2>&1
	REG add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableOSUpgrade" /t REG_DWORD /d 1 /f >nul 2>&1
	REG add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
	REG add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
	REG add "HKLM\Software\Microsoft\Windows\CurrentVersion\WindowsUpdate\OSUpgrade" /v "ReservationsAllowed" /t REG_DWORD /d 0 /f >nul 2>&1
	REG add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Gwx" /v "DisableGwx" /t REG_DWORD /d 1 /f >nul 2>&1
	REG add "HKCU\Software\Microsoft\Windows\CurrentVersion\EOSNotify" /v "DiscontinueEOS" /t REG_DWORD /d 1 /f >nul 2>&1
	net start wuauserv
	call :sleep "系统已禁止更新" 5
) else if "%a%"=="2" (
	echo 正在开启系统更新...
    net stop wuauserv
	REG delete "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "Start"  /f >nul 2>&1
	REG delete "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "Start"  /f >nul 2>&1
	REG add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "Start" /t REG_DWORD /d 2 /f >nul 2>&1
	REG delete "HKLM\Software\Microsoft\Windows\CurrentVersion\WindowsUpdate\OSUpgrade" /v "ReservationsAllowed" /f >nul 2>&1
	REG delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Gwx" /v "DisableGwx"  /f >nul 2>&1
	REG delete "HKCU\Software\Microsoft\Windows\CurrentVersion\EOSNotify" /v "DiscontinueEOS" /f >nul 2>&1
	reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "PauseDeferrals" /f >nul 2>&1
	reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ElevateNonAdmins" /f >nul 2>&1
	reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "UseWUServer" /f >nul 2>&1
	reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUServer"  /f >nul 2>&1
	reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUStatusServer" /f >nul 2>&1
	reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoWindowsUpdate" /f >nul 2>&1
	reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /f >nul 2>&1
	reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AutoInstallMinorUpdates" /f >nul 2>&1
	reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "DetectionFrequencyEnabled" /f >nul 2>&1
	reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\WindowsUpdate" /v "DisableWindowsUpdateAccess" /f >nul 2>&1
	reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "RescheduleWaitTimeEnabled" /f >nul 2>&1
	reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\WAU" /v "Disabled" /f >nul 2>&1
	REG delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableOSUpgrade"  /f >nul 2>&1
	net start wuauserv
	call :sleep "系统已开启更新" 5
) else if "%a%"=="3" (
	echo 暂停更新1000周...
	reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v FlightSettingsMaxPauseDays /t reg_dword /d 7000 /f >nul 2>&1
	start ms-settings:windowsupdate
	call :sleep "请手动选择暂停更新周期" 5
) else if "%a%"=="4" (
	echo 恢复默认暂停更新5周...
	reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v FlightSettingsMaxPauseDays /t reg_dword /d 35 /f >nul 2>&1
	start ms-settings:windowsupdate
	call :sleep "请手动选择暂停更新周期" 5
)
if "%a%"=="0" exit /b
if /i "%a%"=="q" exit /b
goto windows_update

:: UAC（用户账户控制）设置 子菜单 
:uac_setting 
call :print_title "UAC（用户账户控制）设置"
set "a=" 
call :print_separator
echo				1. 从不通知 &echo.
echo				2. 恢复默认 &echo.
echo				3. UAC开启/关闭 &echo.
echo				4. 打开UAC手动设置 &echo.
echo				0. 返回(q) &echo.
call :print_separator
set /p a=请输入你的选择: 
if "%a%"=="1" (
	echo 正在设置为“从不通知”...
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 0 /f >nul 2>&1
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v PromptOnSecureDesktop /t REG_DWORD /d 0 /f >nul 2>&1
	call :sleep "完成！" 3
) else if "%a%"=="2" (
	call :uac_toggle 1
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 5 /f >nul 2>&1
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v PromptOnSecureDesktop /t REG_DWORD /d 1 /f >nul 2>&1
	call :sleep "完成！" 3
) else if "%a%"=="3" (
	choice /c 123 /n /m "选择你的操作? [1.彻底关闭 2.启用 3.取消]: "
	if "!errorlevel!"=="3" goto :uac_setting
	if "!errorlevel!"=="1" (
		call :ask_confirm "彻底关闭UAC会造成系统的不稳定，你要继续关闭吗? [y/N]: " n
		if "!errorlevel!" == "0" goto :uac_setting
		call :ask_confirm "你需要承担可能的风险，确定继续关闭吗? [y/N]: " n
		if "!errorlevel!" == "0" goto :uac_setting
		echo 正在彻底关闭 UAC... 
		call :uac_toggle 0
		call :ask_confirm "设置完成，重启系统以生效。 现在重启吗? [y/N]: " n
		if "!errorlevel!" == "1" (shutdown /r /t 0)
	) else if "!errorlevel!"=="2" (
		echo 正在开启 UAC... 
		call :uac_toggle 1
		call :ask_confirm "设置完成，重启系统以生效。 现在重启吗? [y/N]: " n
		if "!errorlevel!" == "1" (shutdown /r /t 0)
	)
) else if "%a%"=="4" (
	start "" UserAccountControlSettings.exe
)
if "%a%"=="0" exit /b
if /i "%a%"=="q" exit /b
goto :uac_setting

:: UAC开关 0:关闭 1开启 
:uac_toggle
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d %~1 /f >nul 2>&1
exit /b

:: WIFI密码
:wifi_password
call :print_title "WIFI密码"
setlocal
echo 	获取系统连接过的WIFI名称和密码
call :print_separator
for /f "tokens=2 delims=:" %%i in ('netsh wlan show profiles ^| findstr "All User Profile"') do (
	set "ssid=%%i"
	set "ssid=!ssid:~1!" 
	set "password="
	for /f "tokens=2 delims=:" %%j in ('netsh wlan show profile name^="!ssid!" key^=clear ^| findstr /C:"Key Content"') do (
		set "password=%%j"
		set "password=!password:~1!" 
	)
	set "output=!ssid!                         " 
	echo 	!output:~0,20! !password!
)
call :print_separator
call :wait_keydown
endlocal & exit /b

:: 上帝模式
:god_mod
explorer shell:::{ED7BA470-8E54-465E-825C-99712043E01C}
exit /b

:: 电源管理 
:power_setting
call :print_title "电源管理"
set "a="
call :print_separator
echo				1. 设置定时关机/重启/休眠 &echo.
echo				2. 禁用自动睡眠* &echo.
echo				3. 打开电源选项 &echo.
echo				4. 禁用休眠(删除 hiberfil.sys)* &echo.
echo				5. 启用休眠 &echo.
echo				0. 返回(q) &echo.
call :print_separator "~"
echo 睡眠：保持内存通电，快速恢复(耗电少) 
echo 休眠：将内存数据保存到硬盘 hiberfil.sys 后完全关机(零耗电) &echo.
call :print_separator
echo.
set /p a=请输入你的选择: 
if "%a%"=="1" (
	call :power_schedule
) else if "%a%"=="2" (
	powercfg -change -standby-timeout-ac 0
	powercfg -change -standby-timeout-dc 0
	echo 已禁用自动睡眠 & timeout /t 3
) else if "%a%"=="3" (
	control powercfg.cpl
) else if "%a%"=="4" (
	powercfg -h off
	echo 已禁用休眠 & timeout /t 4
) else if "%a%"=="5" (
	powercfg -h on
	echo 已启用休眠 & timeout /t 4
)
if "%a%"=="0" exit /b
if /i "%a%"=="q" exit /b
goto power_setting

::定时关机/重启/休眠 
:power_schedule
setlocal
echo  1.关机  2.重启 3.休眠 4.取消计划
choice /c 1234 /n /m "请选择要执行的操作: "
if "%errorlevel%"=="1" (
    set operation=/s
    set op_name=关机 
) else if "%errorlevel%"=="2" (
    set operation=/r
    set op_name=重启 
) else if "%errorlevel%"=="3" (
    set operation=/h
    set op_name=休眠 
) else if "%errorlevel%"=="4" (
    shutdown /a >nul 2>&1
	if "!errorlevel!"=="1116" (call :sleep "没有正在运行的计划" 5 ) else ( call :sleep "已取消计划" 5)
	endlocal & exit /b
)
echo 1.设置分钟数  2.设置具体时间(HH:MM) 
choice /c 12 /n /m "请选择时间设置方式: "
if "%errorlevel%"=="1" (
    set /p minu="请输入延迟分钟数(默认10分钟): "
    if "!minu!"=="" set "minu=10" 
    set /a seconds=minu*60
) else if "%errorlevel%"=="2" (
    set /p target_time="请输入目标时间 (如 23:30): "
	set target_time=!target_time:：=:!
	for /f %%s in ('powershell -Command "$now = Get-Date; $target = [datetime]::ParseExact(\"!target_time!\", \"HH:mm\", $now.Culture); if ($target -lt $now) { $target = $target.AddDays(1) } ; [int]($target - $now).TotalSeconds"') do (
		set seconds=%%s
	)
)
call :sleep "正在检查注销计划，请稍等..." 1 silent
shutdown /a >nul 2>&1
if "!errorlevel!"=="1116" (call :sleep "没有正在运行的计划" 1 silent) else ( call :sleep "已取消原计划" 1 silent)
call :sleep "正在设置!op_name!，请稍等..." 1 silent
shutdown !operation! /t !seconds!
call :sleep "已设置!op_name!" 10
endlocal & exit /b

:: 上帝模式
:god_mod
explorer shell:::{ED7BA470-8E54-465E-825C-99712043E01C}
exit /b

:: 应用管理
:app_setting
call :reset_color_size
call :print_title "应用管理"
set "a="
call :print_separator
echo				1. 一键卸载预装应用 &echo.
echo				2. 打开程序和功能 &echo.
echo				3. 高级winget应用管理 &echo.
echo				4. OneDrive安装/卸载 &echo.
echo				5. 微软拼音输入法设置 &echo.
echo				0. 返回(q) &echo.
call :print_separator
set /p a=请输入你的选择: 
if "%a%"=="1" (
	call :uninstall_preinstalled_apps
)else if "%a%"=="2" (
	start "" appwiz.cpl
)else if "%a%"=="3" (
	call :winget_app
)else if "%a%"=="4" (
	choice /c 123 /n /m "OneDrive应用? [1.卸载 2.安装 3.取消]: "
	set /a op=!errorlevel!
	if !op! == 1 call :uninstall_OneDrive
	if !op! == 2 call :install_OneDrive
	if !op! == 3 goto :app_setting
)else if "%a%"=="5" (
	call :microsoft_pinyin
)
if "%a%"=="0" exit /b
if /i "%a%"=="q" exit /b
goto app_setting

:check_winget
where winget >nul 2>&1
if errorlevel 1 (
	echo 未找到 winget 程序，此功能暂不可用，请先安装 winget。
	call :wait_keydown "https://apps.microsoft.com/store/detail/9NBLGGH4NNS1"
	exit /b 1
)
exit /b 0

::卸载预装应用
:uninstall_preinstalled_apps
call :check_winget
if errorlevel 1 exit /b
echo	预装的应用包括：
echo		Microsoft 365 Copilot
echo		Microsoft Clipchamp
echo		Microsoft To Do
echo		Microsoft 必应
echo		Microsoft 资讯
echo		Game Bar
echo		Solitaire ^& Casual Games
echo		Xbox、Xbox TCUI、Xbox Identity Provider
echo		反馈中心
echo		Power Automate
echo		资讯
echo		Outlook for Windows
echo		小组件
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
echo 正在卸载Microsoft 资讯 
winget uninstall "Microsoft 资讯"
echo 正在卸载Game Bar
winget uninstall "Game Bar"
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

:: 高级winget应用管理 
:winget_app
call :check_winget
if errorlevel 1 exit /b
call :reset_color
call :print_title "高级winget应用管理"
set "d="
call :print_separator
echo				1. 搜索应用 &echo.
echo				2. 安装应用 &echo.
echo				3. 查看已安装 &echo.
echo				4. 更新 &echo.
echo				5. 卸载 &echo.
echo				0. 返回(q) &echo.
call :print_separator
echo	本功能使用winget进行应用的管理
echo	https://learn.microsoft.com/zh-cn/windows/package-manager/winget/ &echo.
call :print_separator
set /p "d=请输入你的选择: "
if "%d%"=="1" (
	call :winget_search
) else if "%d%"=="2" (
	call :winget_install
) else if "%d%"=="3" (
	set "command_line=winget list"
	start "!command_line!" /max cmd /k "!command_line!"
) else if "%d%"=="4" (
	call :winget_upgrade
) else if "%d%"=="5" (
	call :winget_uninstall
) 
if "%d%"=="0" exit /b
if /i "%d%"=="q" exit /b
goto :winget_app 

:: winget搜索应用 
:winget_search
set /p "app_name=请输入要搜索的应用关键词（例如 微信）: "
set "command_line=winget search !app_name!"
start "!command_line!" cmd /k "!command_line! -s winget"
exit /b

:: winget安装应用 
:winget_install
call :ask_confirm "根据搜索结果id安装应用，是否继续? [Y/n]: " y
if errorlevel 1 goto :winget_app
echo.
:winget_intstall_input_id
echo 输入需要安装的应用id，如果有多个应用使用空格分割（例如 Tencent.WeChat） 
set "app_ids="
set /p "app_ids=你要安装的应用ID是? : "
if not defined app_ids (echo 请重新输入 & goto :winget_intstall_input_id)
set "install_location="
if /i "%SystemDrive%"=="C:" if exist "D:\" set "install_location=D:\apps"
echo.
if defined install_location (
	echo 如果可以，我会为你安装在!install_location! ，当然这取决应用是否支持修改路径。
) else (
	echo 我会安装在系统默认位置。
)
choice /c 123 /n /m "是否同意? [1.好的 2.应用默认安装位置 3. 自定义位置]: "
if %errorlevel%==2 (
	set "install_location="
) else if %errorlevel%==3 (
	set /p "install_location=请输入安装的位置（例如 D:\apps）: "
)
if defined install_location if not exist "%install_location%\" mkdir "%install_location%"
cls
for %%i in (%app_ids%) do (
	if defined install_location (
		echo 正在安装 %%i 到 %install_location%...
		winget install --id "%%i" -e -l %install_location% -s winget --accept-source-agreements --accept-package-agreements
	) else (
		echo 正在安装 %%i 到默认位置...
		winget install --id "%%i" -e -s winget --accept-source-agreements --accept-package-agreements
	)
)
call :wait_keydown "安装结束，按任意键继续"
call :reset_color
exit /b

:: winget升级应用 
:winget_upgrade 
choice /c 123 /n /m "更新选项? [1.更新所有 2.更新指定应用 3.取消]: "
if "!errorlevel!"=="3" exit /b
if "!errorlevel!"=="1" (
	winget upgrade --all
) else if "!errorlevel!"=="2" (
	set /p "app_id=输入需要更新的应用id（例如 Tencent.WeChat）: "
	winget upgrade !app_id!
)
call :sleep "更新完成" 10
call :reset_color
exit /b

:: winget卸载应用 
:winget_uninstall 
choice /c 12 /n /m "卸载应用吗? [1.是的 2.取消]: "
if "!errorlevel!"=="2" exit /b
set "app_id="
set /p "app_id=输入需要卸载的应用id（例如 Tencent.WeChat）: "
if not defined app_ids (call :sleep "ID不正确" 5 & exit /b)
winget uninstall !app_id!
call :sleep "卸载完成" 10
call :reset_color
exit /b

:: 卸载OneDrive
:uninstall_OneDrive
echo 正在卸载 OneDrive...
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
reg delete "HKCR\WOW6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >nul 2>&1
reg delete "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >nul 2>&1
call :sleep "卸载 OneDrive...OK" 5
exit /b

:: 安装OneDrive
:install_OneDrive
echo 正在安装 OneDrive...
if exist "%SystemRoot%\System32\OneDriveSetup.exe" (
	"%SystemRoot%\System32\OneDriveSetup.exe"
) else if exist "%SystemRoot%\SysWOW64\OneDriveSetup.exe" (
	"%SystemRoot%\SysWOW64\OneDriveSetup.exe"
) else (
	call :sleep "找不到 OneDrive 安装程序，请手动下载安装！" 4 silent
	start "" https://www.microsoft.com/zh-cn/microsoft-365/onedrive/download
)
call :sleep "已经完成" 5
exit /b

:: 微软拼音输入法设置 
:microsoft_pinyin
call :print_title "微软拼音输入法设置"
set "d="
call :print_separator
echo				1. 双拼输入 &echo.
echo				2. 全拼输入 &echo.
echo				3. 打开微软拼音设置 &echo.
echo				0. 返回(q) &echo.
call :print_separator "~"
echo  该设置仅用于【微软拼音输入法】，其他输入法请勿使用。 
call :print_separator
echo.
set /p "d=请输入你的选择: "
if "%d%"=="1" (
	echo.&echo		可选双拼方案： 
	echo				1. 软微双拼 
	echo				2. 智能ABC 
	echo				3. 自然码 
	choice /c 123 /n /m "请输入双拼方案: " 
	set /a sp_option=!errorlevel!
	if !sp_option! == 1 set "sp_code=0"
	if !sp_option! == 2 set "sp_code=1"
	if !sp_option! == 3 set "sp_code=3"
	call :microsoft_pinyin_select 1
	call :microsoft_pinyin_sp !sp_code!
	call :sleep "已设置双拼输入法" 6
)else if "%d%"=="2" (
	call :microsoft_pinyin_select 0
	call :sleep "已设置全拼输入法" 6
)else if "%d%"=="3" (
	start ms-settings:regionlanguage-chsime-pinyin
)
if "%d%"=="0" endlocal & exit /b
if /i "%d%"=="q" endlocal & exit /b
goto :microsoft_pinyin

:: 双拼输入法 0软微双拼 1智能ABC 3自然码 
:microsoft_pinyin_sp
reg add "HKCU\Software\Microsoft\InputMethod\Settings\CHS" /v DoublePinyinScheme /t REG_DWORD /d %~1 /f >nul 2>&1
exit /b

:: 输入法 1双拼 0全拼
:microsoft_pinyin_select
reg add "HKCU\Software\Microsoft\InputMethod\Settings\CHS" /v "Enable Double Pinyin" /t REG_DWORD /d %~1 /f >nul 2>&1
exit /b

:: 编辑hosts 
:hosts_editor
start "" notepad "%SystemRoot%\system32\drivers\etc\hosts"
exit /b

:network_setting
setlocal enabledelayedexpansion
call :print_title "网络管理"
set "a="
call :print_separator
echo			1. 网络信息                  11. 远程桌面 &echo.
echo			2. 打开网络连接控制面板      12. 一键断网/联网 &echo.
echo			3. 清除DNS缓存               13. 防火墙设置 &echo.
echo			4. MAC地址                   14. 系统代理设置 &echo.
echo			5. ping检查                  15. 端口转发&echo.
echo			6. tracert路由追踪 &echo.
echo			7. 我的外网IP &echo.
echo			8. 检查端口占用 &echo.
echo			9. 测速网 &echo.
echo			10. telnet设置&echo.
echo			0. 返回(q) &echo.
call :print_separator
set /p "a=请输入你的选择: "
if "%a%"=="1" (
	set "command_line=ipconfig /all"
	start "!command_line!" cmd /k "!command_line!"
) else if "%a%"=="2" (
	start ncpa.cpl
) else if "%a%"=="3" (
	ipconfig /flushdns
	call :sleep " " 4
) else if "%a%"=="4" (
	echo.
	getmac /v & pause
) else if "%a%"=="5" (
	echo.
	set "ping_target="
	set /p "ping_target=请输入要ping的IP或域名[默认: baidu.com]: "
	if "!ping_target!"=="" set "ping_target=baidu.com"
	call :ask_confirm "是否持续检查? [y/N]: " n
	if errorlevel 1 (
		set "ping_cmd=ping !ping_target! -t"
	) else (
		set "ping_cmd=ping !ping_target! -n 4"
	)
	start "Ping检查: !ping_target!" cmd /k "!ping_cmd!"
) else if "%a%"=="6" (
	echo.
	set "trace_target="
	set /p "trace_target=请输入要追踪的IP或域名[默认: baidu.com]: "
	if "!trace_target!"=="" set "trace_target=baidu.com"
	start "路由追踪: !trace_target!" cmd /k "tracert !trace_target!"
) else if "%a%"=="7" (
	echo.
	curl.exe -s -L --connect-timeout 5 --max-time 10 https://myip.ipip.net/
	echo https://myip.ipip.net 提供服务支持 & pause
) else if "%a%"=="8" (
	call :search_port
	call :sleep "end.." 5
) else if "%a%"=="9" (
	start "" https://www.speedtest.cn/
) else if "%a%"=="10" (
	call :telnet_setting
) else if "%a%"=="11" (
	call :remote_desktop
) else if "%a%"=="12" (
	call :internet_control
	if "!errorlevel!"=="1" (set "net_status=断网") else (set "net_status=联网")
	call :sleep "已设置!net_status!！" 5
) else if "%a%"=="13" (
	call :advfirewall_setting
) else if "%a%"=="14" (
	call :system_proxy
) else if "%a%"=="15" (
	call :port_forward
)
if "%a%"=="0" endlocal & exit /b
if /i "%a%"=="q" endlocal &  exit /b
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

:: telnet设置 
:telnet_setting
setlocal enabledelayedexpansion
call :print_title "telnet设置"
set "a="
call :print_separator
echo			1. 安装telnet客户端 &echo.
echo			2. telehack.com&echo.
echo			0. 返回(q) &echo.
call :print_separator
set /p "a=请输入你的选择: "
if "%a%"=="1" (
	call :install_telnet
) else if "%a%"=="2" (
	call :start_telehack
)
if "%a%"=="0" endlocal & exit /b
if /i "%a%"=="q" endlocal &  exit /b
goto :telnet_setting 

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
call :wait_keydown "回车开始"
start cmd /k "telnet telehack.com"
exit /b

:: 远程桌面 
:remote_desktop
setlocal
choice /c 123 /n /m "远程桌面设置? [1.启用 2.关闭 3.返回]: "
if "%errorlevel%"=="3" exit /b
if "%errorlevel%"=="1" (set "value=0") else ( set "value=1")
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d %value% /f
call :sleep "远程桌面设置成功" 5
endlocal & exit /b

:: 一键联网控制 
:internet_control
choice /c 12 /n /m "一键联网控制? [1.断网 2.联网]: "
if "%errorlevel%"=="1" (
	powershell -Command "$ProgressPreference = 'SilentlyContinue';Get-NetAdapter | Disable-NetAdapter -Confirm:$false"
	exit /b 1
) else (
	powershell -Command "$ProgressPreference = 'SilentlyContinue';Get-NetAdapter | Enable-NetAdapter -Confirm:$false"
	exit /b 2
)

:: 防火墙设置 
:advfirewall_setting
set "firwall_c="
choice /c 1234 /n /m "防火墙设置 [1.关闭 2.开启 3.重置 4.手动]: "
if "%errorlevel%"=="1" (
	netsh advfirewall set allprofiles state off >nul 2>&1
	call :sleep "防火墙已关闭" 3
) else if "%errorlevel%"=="2" (
	netsh advfirewall set allprofiles state on >nul 2>&1
	call :sleep "防火墙已开启" 3
) else if "%errorlevel%"=="3" (
	netsh advfirewall set allprofiles state reset >nul 2>&1
	call :sleep "防火墙已重置" 3
) else if "%errorlevel%"=="4" (
	start "" wf.msc
)
exit /b

:: 系统代理 
:system_proxy
call :print_title "系统代理设置"
set "sp="
set "system_proxy_reg_location=HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
call :print_separator
echo				1. 设置代理 &echo.
echo				2. 关闭代理 &echo.
echo				3. 当前状态 &echo.
echo				4. 打开系统代理设置界面 &echo.
echo				0. 返回(q) &echo.
call :print_separator
set /p "sp=请输入你的选择: "
if "%sp%"=="1" ( 
	set /p proxy_ip_port="请输入代理服务器地址及端口（例如 127.0.0.1:8099）: "
	set proxy_ip_port=!proxy_ip_port:：=:!
	echo.
	echo 正在设置代理 !proxy_ip_port! ...
	reg add "!system_proxy_reg_location!" /v ProxyEnable /t REG_DWORD /d 1 /f >nul
	reg add "!system_proxy_reg_location!" /v ProxyServer /t REG_SZ /d "!proxy_ip_port!" /f >nul
	reg add "!system_proxy_reg_location!" /v ProxyOverride /t REG_SZ /d "<local>" /f >nul
	call :sleep "代理已设置为 !proxy_ip_port!" 5
) else if "%sp%"=="2" (
	reg add "!system_proxy_reg_location!" /v ProxyEnable /t REG_DWORD /d 0 /f >nul
	reg delete "!system_proxy_reg_location!" /v ProxyServer /f >nul 2>nul
	reg add "!system_proxy_reg_location!" /v ProxyOverride /t REG_SZ /d "" /f >nul
	call :sleep "代理已关闭" 3
) else if "%sp%"=="3" (
	call :read_reg_value "!system_proxy_reg_location!" "ProxyEnable"
	if "!ret_value!"=="0x1" (
		echo 代理启用状态: 已启用
		call :read_reg_value "!system_proxy_reg_location!" "ProxyServer"
		echo 当前代理服务器: !ret_value!
	) else if "!ret_value!"=="0x0" (
		echo 代理启用状态: 已关闭 
	) else echo 无法读取代理状态（可能未设置） 
	pause
) else if "%sp%"=="4" (
	start ms-settings:network-proxy
)
if "%sp%"=="0" exit /b
if /i "%sp%"=="q" exit /b
goto :system_proxy

:: 端口转发 
:port_forward
call :print_title "端口转发"
set "pf="
call :print_separator
echo				1. 添加端口转发规则 &echo.
echo				2. 删除端口转发规则 &echo.
echo				3. 查看当前规则 &echo.
echo				4. 清空所有规则 &echo.
echo				0. 返回(q) &echo.
call :print_separator
set /p "pf=请输入你的选择: "
if "%pf%"=="1" (
	echo 添加端口转发规则...&echo.
	set /p "listen_ip_port=请输入监听IP地址及端口(例如：127.0.0.1:8999):"
	set /p "connect_ip_port=请输入目标IP地址及端口(例如：127.0.0.1:8080):"
	set "listen_ip_port=!listen_ip_port:： =:!"
	set "connect_ip_port=!connect_ip_port:： =:!"
	for /f "tokens=1,2 delims=:" %%a in ("!listen_ip_port!") do (set "listen_ip=%%a" & set "listen_port=%%b")
	for /f "tokens=1,2 delims=:" %%a in ("!connect_ip_port!") do (set "connect_ip=%%a" & set "connect_port=%%b")
	netsh interface portproxy add v4tov4 listenaddress=!listen_ip! listenport=!listen_port! connectaddress=!connect_ip! connectport=!connect_port!
	call :sleep "添加完成" 10
) else if "%pf%"=="2" (
	echo 删除端口转发规则...&echo.
	set /p "listen_ip_port=请输入要删除的监听IP地址及端口(例如：127.0.0.1:8999):"
	set "listen_ip_port=!listen_ip_port:： =:!"
	for /f "tokens=1,2 delims=:" %%a in ("!listen_ip_port!") do (set "listen_ip=%%a" & set "listen_port=%%b")
	netsh interface portproxy delete v4tov4 listenaddress=!listen_ip! listenport=!listen_port!
	call :sleep "删除完成" 10
) else if "%pf%"=="3" (
	echo 当前转发规则 
	netsh interface portproxy show all
	call :wait_keydown "按任意键继续"
) else if "%pf%"=="4" (
	netsh interface portproxy reset
	call :wait_keydown "规则已清空，按任意键继续"
)
if "%pf%"=="0" exit /b
if /i "%pf%"=="q" exit /b
goto :port_forward

:: 设备管理 
:device_setting
setlocal enabledelayedexpansion
call :print_title "设备管理"
set "c="
call :print_separator
echo				1. 照相机开关 &echo.
echo				2. 蓝牙开关 &echo.
echo				0. 返回(q) &echo.
call :print_separator "~" 
echo    通过禁用或开启对应功能来保护系统安全。& echo.
call :print_separator
set /p "c=请选择你要管理的设备: "
if not defined c goto :device_setting
if "%c%"=="0" endlocal & exit /b
if /i "%c%"=="q" endlocal & exit /b
choice /c 123 /n /m "选择你的操作? [1.禁用 2.启用 3.取消]: "
if "%errorlevel%"=="3" goto :device_setting
if "%errorlevel%"=="1" (set "opt=Disable" & set "opt_cn=禁用") else (set "opt=Enable" & set "opt_cn=启用")
if "%c%"=="1" (
	call :device_status_toggle "Camera" %opt%
	call :device_status_toggle "Image" %opt%
	set "device_name=照相机"
)else if "%c%"=="2" (
	call :device_status_toggle "Bluetooth" %opt%
	set "device_name=蓝牙"
)
if defined device_name call :sleep "已%opt_cn%%device_name%" 5
goto :device_setting

:: 设备状态切换
:: 参数1：设备，如Camera
:: 参数2：操作，如Disable、Enable 
:device_status_toggle
set "device=%~1" & set "%opt%=%~2"
powershell.exe -nologo -noprofile -Command "$ProgressPreference = 'SilentlyContinue';Get-PnpDevice -Class %device% | %opt%-PnpDevice -Confirm:$false" >nul 2>&1
exit /b

:: 图一乐 
:hahaha
setlocal
call :print_title "图一乐"
set "c="
call :print_separator
echo         1. 假装更新             16. 全球航班追踪         31. 空难信息网 
echo         2. 黑客打字             17. 魔性蠕虫             32. 童年在线游戏 
echo         3. 模拟macOS桌面        18. 狗屁不通文章生成器   33. 一分钟公园
echo         4. windows93            19. 能不能好好说话       34. 图寻 
echo         5. IBM PC模拟器         20. 自由钢琴             35. 梦乡 
echo         6. 侏罗纪公园系统       21. Poki                 36. 猜密码 
echo         7. Unix 系统模拟器      22. 邦戈猫               37. A Real Me 
echo         8. 卡巴斯基网络威胁     23. 全历史               38. 人生重开模拟器  
echo         9. 假装黑客             24. 对称光绘             39. 寻找隐藏的牛 
echo        10. 无用网站             25. 互联网坟墓           40. 开车 
echo        11. neal.fun             26. 语保工程             41. 实况摄像头 
echo        12. 人类基准测试         27. 无限缩放             42. 狗神 
echo        13. 时光邮局             28. 无限马腿             43. 有趣网址之家 
echo        14. 全球在线广播         29. 白噪音               44. 很相思 
echo        15. 全球天气动态         30. 宇宙的刻度           45. 秘密花园 
echo.
echo        0. 返回(q) 
call :print_separator
set /p "c=请输入你的选择（回车随机选一个）: "
if "%c%"=="" (
	set /a "rand_num=!random! %% 45 + 1"
	set "c=!rand_num!"
	call :sleep "随机选择了 !c! 正在打开网站……" 3
)
if "%c%"=="1"  start "" https://fakeupdate.net
if "%c%"=="2"  start "" https://hackertyper.net
if "%c%"=="3"  start "" https://turbomac.netlify.app
if "%c%"=="4"  start "" https://www.windows93.net
if "%c%"=="5"  start "" https://www.pcjs.org
if "%c%"=="6"  start "" https://www.jurassicsystems.com
if "%c%"=="7"  start "" https://www.masswerk.at/jsuix/index.html
if "%c%"=="8"  start "" https://cybermap.kaspersky.com/cn 
if "%c%"=="9"  start "" https://geektyper.com
if "%c%"=="10" start "" https://theuselessweb.com
if "%c%"=="11" start "" https://neal.fun
if "%c%"=="12" start "" https://humanbenchmark.com
if "%c%"=="13" start "" https://www.hi2future.com
if "%c%"=="14" start "" https://radio.garden
if "%c%"=="15" start "" https://earth.nullschool.net/zh-cn
if "%c%"=="16" start "" https://www.flightradar24.com
if "%c%"=="17" start "" http://www.staggeringbeauty.com
if "%c%"=="18" start "" https://suulnnka.github.io/BullshitGenerator/index.html
if "%c%"=="19" start "" https://lab.magiconch.com/nbnhhsh
if "%c%"=="20" start "" https://www.autopiano.cn
if "%c%"=="21" start "" https://poki.com/zh
if "%c%"=="22" start "" https://bongo.cat
if "%c%"=="23" start "" https://www.allhistory.com
if "%c%"=="24" start "" http://weavesilk.com
if "%c%"=="25" start "" https://wiki.archiveteam.org
if "%c%"=="26" start "" https://zhongguoyuyan.cn
if "%c%"=="27" start "" https://zoomquilt.org
if "%c%"=="28" start "" http://endless.horse
if "%c%"=="29" start "" https://asoftmurmur.com
if "%c%"=="30" start "" https://scaleofuniverse.com/zh
if "%c%"=="31" start "" https://www.planecrashinfo.com
if "%c%"=="32" start "" https://www.yikm.net
if "%c%"=="33" start "" https://oneminutepark.tv
if "%c%"=="34" start "" https://tuxun.fun
if "%c%"=="35" start "" http://yume.ly
if "%c%"=="36" start "" https://www.guessthepin.com
if "%c%"=="37" start "" https://www.arealme.com/cn
if "%c%"=="38" start "" https://rest.latiao.online
if "%c%"=="39" start "" https://findtheinvisiblecow.com
if "%c%"=="40" start "" https://slowroads.io
if "%c%"=="41" start "" https://www.skylinewebcams.com
if "%c%"=="42" start "" https://dogod.io
if "%c%"=="43" start "" https://youquhome.com
if "%c%"=="44" start "" https://henxiangsi.com
if "%c%"=="45" start "" http://www.yini.org
if "%c%"=="0" endlocal & exit /b
if /i "%c%"=="q" endlocal & exit /b
goto :hahaha

:: 检查脚本更新 
:update_script
call :print_title "检查更新"
call :print_separator
set "jsonUrl=https://files.cnblogs.com/files/zjw-blog/config.json"
set "BAT_NEW_TMP=%TEMP%\wmtool.tmp"
set "UPDATE_SCRIPT=%TEMP%\wmtool_update.bat"
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
echo			┌─────────────────────────────┬────────────────────────────┐ 
echo			│             本地            │             最新           │ 
echo			├─────────────────────────────┼────────────────────────────│ 
echo			│                             │                            │ 
echo			│     版本号：%rversion%          │     版本号：%remote_rversion%         │ 
echo			│                             │                            │ 
echo			│     更新时间：%updated%      │     更新时间：%remote_updated%     │ 
echo			│                             │                            │ 
echo			└─────────────────────────────┴────────────────────────────┘ 
echo.
if not defined remote_updated (
	call :sleep "无法获取远程更新日期，请检查网络设置或到更新地址手动下载。" 5
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
(
    echo @echo off ^& chcp 65001^>nul
    echo copy /Y "%BAT_NEW_TMP%" "%MAIN_SCRIPT_PATH%"
    echo del /F /Q "%BAT_NEW_TMP%"
    echo start "" "%MAIN_SCRIPT_PATH%"
    echo ping 127.0.0.1 -n 2 ^>nul
    echo del /F /Q "%%~f0" ^>nul 2^>nul
    echo exit
) > "%UPDATE_SCRIPT%"
start "" /B cmd /c call "%UPDATE_SCRIPT%" & exit

:: 关于 
:about_me
call :print_title "关于"
call :print_separator
echo.
echo    Windows-Manage-Tool(WMT),是一个主要在Windows11上使用的批处理 
echo    小工具，集成了多个系统设置，旨在简化日常维护和系统设置操作。 
echo. 
echo  当前版本：
echo. 
echo     %rversion% 
echo. 
echo  更新地址： 
echo. 
echo      https://github.com/Zhu-junwei/Windows-Manage-Tool
echo      https://wwqn.lanzoul.com/b0fpd626d 密码:enz1
echo      https://files.cnblogs.com/files/zjw-blog/WindowsManageTool.sh
echo.
echo  特别鸣谢： 
echo. 
echo      博客园 批处理之家 吾爱破解 致美化 GitHub 蓝奏云 ChatGPT DeepSeek 
echo.
call :print_separator
echo			0. 返回(q)		1. 检查更新 &echo.
call :print_separator
set "a="
set /p "a=请输入你的选择: "
if "%a%"=="1" call :update_script & goto :about_me
exit /b

:: 分割线
:: 参数1：分隔符字符，默认 *
:: 参数2：重复次数，默认为窗口宽度 
:print_separator
setlocal
set "char=%~1" 
if "%char%"=="" set "char=%separator%"
set "count=%~2"
if "%count%"=="" set "count=%cols%"
set "line="
for /L %%i in (1,1,%count%) do (set "line=!line!!char!")
echo !line!
echo.
endlocal & exit /b

:: 打印标题 
:: 参数1 = 文本内容 
:print_title 
setlocal & cls 
set "title=%~1"
set "count=%~2"
if "%count%"=="" (
    set "space_str=                                       " 
) else (
    set "space_str="
    for /L %%i in (1,1,%count%) do (set "space_str=!space_str! ")
)
echo.
echo !space_str!!title!
echo.
endlocal & exit /b

:: 重启资源管理器 
:restart_explorer
taskkill /f /im explorer.exe >nul 2>&1 & start explorer & exit /b

:: 读取注册表键值 
:: 参数1=注册表路径，参数2=值名称 
:: 返回值：ret_value 
:read_reg_value
set "ret_value="
set "reg_cmd=reg query "%~1" /v "%~2" 2^>nul ^| findstr /I /C:"%~2""
for /f "tokens=1,2,*" %%G in ('%reg_cmd%') do (
	set "ret_value=%%I"
)
exit /b

:: 询问选择 
:: 如果选了默认值，errorlevel是0，否则是1 
:: 参数1：提示信息 
:: 参数2：默认值 
:ask_confirm
setlocal
set "input="
set /p "input=%~1"
if not defined input set "input=%~2"
if /i "%input%"=="%~2" (endlocal & exit /b 0) else (endlocal & exit /b 1)

:: 等待后运行 
:: 参数1：提示信息(默认"请稍候...") 
:: 参数2：等待时间(默认1s) 
:: 参数3：可选silent，是否静默等待（默认显示倒计时） 
:sleep
setlocal
set "msg=%~1" & set "sec=%~2" & set "silent=%~3"
if not defined msg set "msg=请稍候..." 
if not defined sec set "sec=1"
if not "%msg%"=="" if not "%msg%"==" " echo %msg%
if /i "%silent%"=="silent" (
    timeout /t %sec% >nul
) else (
    timeout /t %sec%
)
endlocal & exit /b

:: 等待按键后继续 
:wait_keydown
if "%~1" neq "" (echo %~1 & pause >nul) else (echo 按任意键继续 & pause >nul)
exit /b

:: 重启系统 
:restart_system
shutdown /r /t 0 & exit /b

:: 设置颜色和窗口大小 
:reset_color_size
call :reset_color
call :reset_size
exit /b

:reset_color
color %color% &  exit /b

:reset_size
mode con cols=%cols% lines=%lines%
exit /b

:: 程序退出 
:byebye
call :sleep "byebye" 1 silent & exit