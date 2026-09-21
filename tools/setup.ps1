# VetTV Setup - Microsoft 30-min Official Prerequisites
# Run as Administrator

Write-Host "Installing Microsoft 30-min WinUI + winapp CLI prerequisites..." -ForegroundColor Cyan

winget install Microsoft.VisualStudioCode -e --accept-package-agreements --accept-source-agreements
winget install Microsoft.DotNet.SDK.10 -e --accept-package-agreements --accept-source-agreements
winget install Microsoft.winappcli --source winget -e --accept-package-agreements --accept-source-agreements
winget install GitHub.cli -e --accept-package-agreements --accept-source-agreements
winget install Git.Git -e --accept-package-agreements --accept-source-agreements

Write-Host "`nInstalling WinUI templates..." -ForegroundColor Yellow
dotnet new install Microsoft.WindowsAppSDK.WinUI.CSharp.Templates

Write-Host "`nInstalling VS Code WinApp extension..." -ForegroundColor Yellow
code --install-extension microsoft-winappcli.winapp --force

Write-Host "`n=== MANUAL STEPS AFTER REOPENING TERMINAL ===" -ForegroundColor Green
Write-Host @"
1. Close and reopen terminal
2. gh auth login
3. gh extension install github/gh-copilot
4. gh copilot plugin install winui@awesome-copilot
5. winapp --version   (verify)
6. git clone https://github.com/Vet-TV/VetTV-WebUI-DX12.git   (if you are not already in the repo)

Learn MCP (optional for best AI results): connect the agent to the Microsoft Learn MCP server for live WinUI docs.
Official quickstart: https://learn.microsoft.com/en-us/windows/apps/develop/ai-assisted/quickstart
"@

Write-Host "`nSetup script complete. Reopen terminal!" -ForegroundColor Cyan
