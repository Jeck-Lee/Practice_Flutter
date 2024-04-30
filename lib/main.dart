import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() {
  /// Webview 위젯 바인딩 초기화 - 웹뷰와 플러터 엔진과의 상호작용을 위함
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  final String testCode = """
  <!-- TradingView Widget BEGIN -->
<div class="tradingview-widget-container" style="height:100%;width:100%">
  <div class="tradingview-widget-container__widget" style="height:calc(100% - 32px);width:100%"></div>
  <div class="tradingview-widget-copyright"><a href="https://www.tradingview.com/" rel="noopener nofollow" target="_blank"><span class="blue-text">Track all markets on TradingView</span></a></div>
  <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-advanced-chart.js" async>
  {
  "autosize": true,
  "symbol": "NASDAQ:AAPL",
  "interval": "D",
  "timezone": "Etc/UTC",
  "theme": "light",
  "style": "1",
  "locale": "en",
  "enable_publishing": false,
  "allow_symbol_change": true,
  "calendar": false,
  "support_host": "https://www.tradingview.com"
}
  </script>
</div>
<!-- TradingView Widget END -->
  """;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late InAppWebViewController webView;
  bool status = false;

  _changeUrl() {
    webView.loadUrl(
      urlRequest: URLRequest(
        url: WebUri("https://flutter.dev/"),
      ),
    );
  }

  Widget myPlayer(String url) {
    debugPrint('----------WebView con: $url');
    return InAppWebView(
      key: GlobalKey(),
      initialUrlRequest: URLRequest(
        // url: WebUri("https://naver.com"),
        url: WebUri.uri(
          Uri.dataFromString(
            widget.testCode,
            mimeType: 'text/html',
            encoding: Encoding.getByName('utf-8'),
          ),
        ),
      ),
      initialSettings: InAppWebViewSettings(
        javaScriptEnabled: true,
        // 하이브리드 사용을 위한 안드로이드 웹뷰 최적화
        useHybridComposition: true,
      ),
      onWebViewCreated: (InAppWebViewController controller) {
        webView = controller;
      },
      onLoadStart: (controller, url) {
        status = false;
      },
      onLoadStop: (controller, url) {
        status = true;
      },
      onWindowFocus: (controller) => {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TEST!"),
      ),
      body: myPlayer("https://pub.dev/"),
      floatingActionButton: FloatingActionButton(
        onPressed: _changeUrl,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
