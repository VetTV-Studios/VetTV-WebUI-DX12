# VetTV-WebUI-DX12

Hybrid **WinUI 3 + WebView2 + DX12** base for Vet GamingTV.
One codebase → Microsoft Store (MSIX) + Steam EXE + Epic EXE + Google Play AAB.

Built around Microsoft's official quickstart:
[Build and publish a Windows app with AI](https://learn.microsoft.com/en-us/windows/apps/develop/ai-assisted/quickstart)
(~30 minutes, empty folder → Store, no Visual Studio required).

Repo: https://github.com/Vet-TV/VetTV-WebUI-DX12  
Privacy: https://vet-tv.github.io/vettv-privacy/

## Architecture

| Layer | Path | Role |
| --- | --- | --- |
| WinUI 3 shell | `dotnet new winui-navview` | NavigationView + MSIX packaging |
| WebUI 2.0 | `src/webui/` | HUD, shop, partnerships |
| C# bridge | `src/platform/microsoft/Bridge.cs` | WebView2 ↔ native |
| DX12 core | `src/core/` | Frame loop, weather, DXR detect |
| Store manifest | `src/platform/microsoft/AppxManifest.xml` | 10.5.1-friendly caps |

## New machine — GitHub + Microsoft toolchain

Run PowerShell **as Administrator**:

```powershell
git clone https://github.com/Vet-TV/VetTV-WebUI-DX12.git
cd VetTV-WebUI-DX12
.\tools\setup.ps1
```

Then close/reopen the terminal:

```powershell
gh auth login
gh extension install github/gh-copilot
gh copilot plugin install winui@awesome-copilot
winapp --version
```

What `setup.ps1` installs (all free):

1. VS Code  
2. .NET SDK 10+  
3. winapp CLI (`Microsoft.winappcli`)  
4. WinUI `dotnet new` templates  
5. GitHub CLI  
6. WinApp VS Code extension  

Optional: connect Copilot to the **Microsoft Learn MCP** server so the agent reads current WinUI 3 docs instead of training data.

## Scaffold the WinUI 3 app (official Step 1–2)

From a sibling folder (keep this repo as the hybrid overlay):

```powershell
mkdir VetTVGame
cd VetTVGame
dotnet new winui-navview -n VetTVGame
cd VetTVGame
dotnet run    # first run creates the exe — do not press F5 yet
code .
```

Copy overlay sources from this repo:

```powershell
Copy-Item ..\VetTV-WebUI-DX12\src . -Recurse -Force
Copy-Item ..\VetTV-WebUI-DX12\docs . -Recurse -Force
```

## Add features with the winui-dev agent (official Step 3)

VS Code → Copilot Chat (`Ctrl+Alt+I`) → **Agent mode** → agent **winui-dev**.

Prompts that match this codebase:

```
Add a settings page to my WinUI NavigationView app with a toggle for dark mode and a hyperlink to https://vet-tv.github.io/vettv-privacy/
```

```
Add WebView2 to MainWindow that loads src/webui/index.html and bridges postMessage {action,count} to C# OnBuyLemons. Use Microsoft.UI.Xaml only — never Windows.UI.Xaml.
```

```
Add a DX12 Agility SDK renderer reference and expose SetWeather(float intensity, float wind) plus raytracing capability detect to JS via WebView2.
```

CLI form:

```powershell
gh copilot -p "@winui-dev Add WebView2 overlay that loads src/webui/index.html and bridges JS buyLemons() to C#"
```

Then `dotnet run` again.

## Package and publish (official Step 4–5)

Admin terminal:

```powershell
dotnet publish -o ./publish
winapp pack ./publish --generate-cert --install-cert
```

Store submit (Partner Center account + reserved name):

```powershell
winapp store publish ./*.msix --appId 9MZJ8R55XLW2
```

Replace the AppId if Partner Center issued a different one.

## Other stores

See [docs/STORE_SUBMISSION.md](docs/STORE_SUBMISSION.md).

- Steam / Epic: standalone EXE from `src/main.cpp` (`VETTV_STEAM` / `VETTV_EPIC`)
- Google Play: Capacitor wrapper in `android/` over the same `src/webui`

## Copilot guardrails

See [AGENTS.md](AGENTS.md). Short version:

- Use `Microsoft.UI.Xaml` only — never `Windows.UI.Xaml`
- Scaffold with `dotnet new winui-navview` + winapp CLI, not Visual Studio F5 on first run
- Privacy URL must stay public: https://vet-tv.github.io/vettv-privacy/
- No location / microphone / camera capabilities
