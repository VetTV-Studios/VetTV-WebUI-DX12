// WinUI 3 C# Bridge for WebView2 <-> DX12
// Merge into the generated WinUI project's MainWindow.xaml.cs

using Microsoft.UI.Xaml;
using Microsoft.Web.WebView2.Core;
using System;
using System.Runtime.InteropServices;

namespace VetTVGame
{
    public sealed partial class MainWindow : Window
    {
        [DllImport("VetTV_DX12.dll")]
        static extern void VetTV_InitDX12();

        private async void InitWebUI2Bridge()
        {
            await webView.EnsureCoreWebView2Async();
            webView.CoreWebView2.WebMessageReceived += (s, e) =>
            {
                var msg = System.Text.Json.JsonDocument.Parse(e.WebMessageAsJson).RootElement;
                var action = msg.GetProperty("action").GetString();
                if (action == "buyLemons") {
                    var count = msg.GetProperty("count").GetInt32();
                    VetTV_InitDX12();
                } else if (action == "setWeather") {
                    var intensity = msg.GetProperty("intensity").GetSingle();
                }
            };
            webView.CoreWebView2.NavigateToString(System.IO.File.ReadAllText("src/webui/index.html"));
        }
    }
}
