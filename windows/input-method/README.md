# 中文输入法键盘布局切换

`中文输入dvorak-qwerty切换.ps1` 是本目录唯一的布局切换入口。它修改中文（简体，中国，`00000804`）输入法对应的 `Layout File` 注册表值。

## 使用方法

请以管理员身份打开 PowerShell，然后在仓库根目录执行：

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\windows\input-method\中文输入dvorak-qwerty切换.ps1
```

按菜单选择 QWERTY 或 Dvorak；修改后须注销或重启 Windows 才会生效。

也可直接指定目标布局，适合快捷方式或自动化：

```powershell
.\windows\input-method\中文输入dvorak-qwerty切换.ps1 -Layout QWERTY
.\windows\input-method\中文输入dvorak-qwerty切换.ps1 -Layout Dvorak
```

## 注意事项

- 脚本会写入 `HKLM`，必须以管理员身份运行。
- 它只影响中文输入法的键盘映射，不会改变其他键盘布局。
- 当前值不是 `KBDUS.DLL` 或 `KBDDV.DLL` 时，脚本显示为“未知”，但仍可选择目标布局覆盖。
- 原有两个 `.bat` 单向切换脚本已删除，避免重复维护。