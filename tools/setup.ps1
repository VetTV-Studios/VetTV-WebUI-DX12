# VetTV Setup - Microsoft 30-min Official Prerequisites
# Run as Administrator

$ErrorActionPreference = 'Continue'

function Refresh-SessionPath {
    $machine = [Environment]::GetEnvironmentVariable('Path', 'Machine')
    $user    = [Environment]::GetEnvironmentVariable('Path', 'User')
    $env:Path = "$machine;$user"

    $dotnetRoots = @(
        "$env:ProgramFiles\dotnet",
        "${env:ProgramFiles(x86)}\dotnet",
        "$env:USERPROFILE\.dotnet",
        "$env:LOCALAPPDATA\Microsoft\dotnet"
    )
    foreach ($root in $dotnetRoots) {
        if (Test-Path (Join-Path $root 'dotnet.exe')) {
            if ($env:Path -notlike "*$root*") {
                $env:Path = "$root;$env:Path"
            }
        }
    }
}

function Resolve-Dotnet {
    Refresh-SessionPath
    $cmd = Get-Command dotnet -ErrorAction SilentlyContinue
    if ($cmd) { return $cmd.Source }
    $candidates = @(
        "$env:ProgramFiles\dotnet\dotnet.exe",
        "${env:ProgramFiles(x86)}\dotnet\dotnet.exe"
    )
    foreach ($c in $candidates) {
        if (Test-Path $c) { return $c }
    }
    return $null
}

Write-Host "Installing Microsoft 30-min WinUI + winapp CLI prerequisites..." -ForegroundColor Cyan

winget install Microsoft.VisualStudioCode -e --accept-package-agreements --accept-source-agreements
winget install Microsoft.DotNet.SDK.10 -e --accept-package-agreements --accept-source-agreements
winget install Microsoft.winappcli --source winget -e --accept-package-agreements --accept-source-agreements
winget install GitHub.cli -e --accept-package-agreements --accept-source-agreements
winget install Git.Git -e --accept-package-agreements --accept-source-agreements

Refresh-SessionPath

Write-Host "`nInstalling WinUI templates..." -ForegroundColor Yellow
$dotnet = Resolve-Dotnet
if (-not $dotnet) {
    Write-Host "dotnet is installed but this shell cannot see it yet." -ForegroundColor Red
    Write-Host "Close this window, open a NEW Admin PowerShell, then run:" -ForegroundColor Yellow
    Write-Host "  dotnet new install Microsoft.WindowsAppSDK.WinUI.CSharp.Templates" -ForegroundColor White
    Write-Host "  .\tools\setup.ps1" -ForegroundColor White
} else {
    Write-Host "Using $dotnet" -ForegroundColor DarkGray
    & $dotnet new install Microsoft.WindowsAppSDK.WinUI.CSharp.Templates
    & $dotnet --list-sdks
}

Write-Host "`nInstalling VS Code WinApp extension..." -ForegroundColor Yellow
Refresh-SessionPath
$code = Get-Command code -ErrorAction SilentlyContinue
if ($code) {
    & code --install-extension microsoft-winappcli.winapp --force
} else {
    Write-Host "VS Code 'code' CLI not on PATH yet. After reopen run:" -ForegroundColor Yellow
    Write-Host "  code --install-extension microsoft-winappcli.winapp --force" -ForegroundColor White
}

Write-Host "`n=== NEXT (new terminal required for gh / winapp PATH) ===" -ForegroundColor Green
Write-Host @"
1. Close this terminal completely and open a NEW Admin PowerShell
2. cd C:\Dev\VetTV-WebUI-DX12
3. gh auth login
4. gh extension install github/gh-copilot
5. gh copilot plugin install winui@awesome-copilot
6. winapp --version
7. dotnet --version

If dotnet is still missing after reopen:
  winget install Microsoft.DotNet.SDK.10 -e --accept-package-agreements --accept-source-agreements
  # then reopen again

Official quickstart: https://learn.microsoft.com/en-us/windows/apps/develop/ai-assisted/quickstart
"@
