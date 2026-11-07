#Requires -RunAsAdministrator
[CmdletBinding()]
param(
    [ValidateSet('QWERTY', 'Dvorak')]
    [string]$Layout
)

$ErrorActionPreference = 'Stop'
$regPath = 'HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\00000804'
$layouts = @{ QWERTY = 'KBDUS.DLL'; Dvorak = 'KBDDV.DLL' }

try {
    $current = (Get-ItemProperty -Path $regPath -Name 'Layout File').'Layout File'
}
catch {
    throw "无法读取中文输入法布局注册表项：$regPath。$($_.Exception.Message)"
}

$currentName = ($layouts.GetEnumerator() | Where-Object Value -ieq $current | Select-Object -First 1 -ExpandProperty Key)
if (-not $currentName) { $currentName = '未知' }

if (-not $Layout) {
    Write-Host "当前布局：$currentName（$current）" -ForegroundColor Cyan
    Write-Host ''
    Write-Host '  [1] 切换为 QWERTY（KBDUS.DLL）'
    Write-Host '  [2] 切换为 Dvorak（KBDDV.DLL）'
    Write-Host '  [0] 退出，不做修改'
    Write-Host ''
    $Layout = switch (Read-Host '请选择目标布局') {
        '1' { 'QWERTY'; break }
        '2' { 'Dvorak'; break }
        '0' { return }
        default { Write-Host '无效选择，未做任何修改。' -ForegroundColor Red; return }
    }
}

$target = $layouts[$Layout]
if ($current -ieq $target) {
    Write-Host "当前已经是 $Layout，无需修改。" -ForegroundColor Yellow
    return
}

Set-ItemProperty -Path $regPath -Name 'Layout File' -Value $target
Write-Host "已设为 $Layout（$target）。注销或重启后生效。" -ForegroundColor Green