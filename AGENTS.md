# Agent instructions — VetTV WinUI 3

Use the `winui-dev` agent and Microsoft Learn MCP for live WinUI 3 APIs.

## Constraints

- Scaffold with `dotnet new winui-navview` from package `Microsoft.WindowsAppSDK.WinUI.CSharp.Templates`.
- Build / run / pack with winapp CLI and `dotnet run` / `dotnet publish`. Do not require Visual Studio.
- All UI controls: `Microsoft.UI.Xaml.*` — never `Windows.UI.Xaml.*` or WPF/UWP leftovers.
- Host game HUD in WebView2 from `src/webui/index.html`. Bridge via `window.chrome.webview.postMessage`.
- Native DX12 lives in `src/core` and is called from `src/platform/microsoft/Bridge.cs` (`VetTV_DX12.dll`).
- Privacy policy link on Settings and footer: https://vet-tv.github.io/vettv-privacy/
- Appx capabilities: `internetClient` only. No location, microphone, camera.
- Publisher identity: VetTV / Vet GamingTV. Contact: vettv@outlook.com

## Preferred first prompts

1. Settings page + dark mode + privacy hyperlink
2. WebView2 overlay + buyLemons / setWeather / checkRaytracing messages
3. DX12 Agility SDK init + SetWeather + DXR capability flag
