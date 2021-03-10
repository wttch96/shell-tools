@echo off
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\00000804" /v "Layout File" /t REG_SZ /d "KBDUS.DLL" /f
