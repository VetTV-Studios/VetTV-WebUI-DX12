# Store Submission Checklist - VetTV Universal Base v2 (winapp CLI)

## Microsoft Store (30-min winapp CLI path)
- Time: ~30 min per Microsoft doc
- Command: `winapp store publish ./*.msix --appId 9MZJ8R55XLW2`
- Requirements:
  - AppxManifest.xml compliant 10.5.1 / 10.6 (privacy, no extra caps)
  - Privacy URL: https://vet-tv.github.io/vettv-privacy/ (must stay live)
  - Split-screen unchecked, no personalization claims
  - Partner Center reserve name first if new title
  - Cert: local test uses `--generate-cert --install-cert`; Store uses Partner Center cert

## Steam
- Accepts any Win32 EXE from dist/
- Steps:
  1. Steamworks SDK wrapper in src/platform/steam/
  2. Upload via SteamPipe: VetTV_Steam.exe
  3. Same privacy policy link
  4. Achievements optional via Steamworks API

## Epic Games Store
- Accepts Win32 EXE
- Steps:
  1. EOS SDK wrapper in src/platform/epic/
  2. Upload VetTV_Epic.exe via Epic Dev Portal
  3. Same privacy policy

## Google Play
- Need AAB, not EXE
- Steps:
  cd android
  npm install
  mkdir www -Force; Copy-Item ../src/webui/* www -Recurse -Force
  npx cap add android
  npx cap open android -> Build AAB
  - Replace DX12 calls with WebGL/WebGPU in app.js for Android
  - Data Safety: no collection, local saves only
  - Package: com.vetgamingtv.lemonadetycoon

## AI Agent Prompts (winui-dev)
- Add WebView2 to MainWindow that loads src/webui/index.html and bridges postMessage to C#
- Generate UI tests for NavigationView dark mode toggle using winapp ui screenshot
