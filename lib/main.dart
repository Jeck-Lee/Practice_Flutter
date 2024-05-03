import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router_provider.dart';

void main() {
  /// Webview 위젯 바인딩 초기화 - 웹뷰와 플러터 엔진과의 상호작용을 위함
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
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

  final String testListString = """
  <!-- TradingView Widget BEGIN -->
<div class="tradingview-widget-container">
  <div class="tradingview-widget-container__widget"></div>
  <div class="tradingview-widget-copyright"><a href="https://kr.tradingview.com/" rel="noopener nofollow" target="_blank"><span class="blue-text">트레이딩뷰에서 모든 시장 추적</span></a></div>
  <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-screener.js" async>
  {
  "width": "100%",
  "height": "100%",
  "defaultColumn": "overview",
  "screener_type": "crypto_mkt",
  "displayCurrency": "USD",
  "colorTheme": "light",
  "locale": "kr"
}
  </script>
</div>
<!-- TradingView Widget END -->
  """;

  final String watchListString = """
  <!-- TradingView Widget BEGIN -->
<div class="tradingview-widget-container">
  <div class="tradingview-widget-container__widget"></div>
  <div class="tradingview-widget-copyright"><a href="https://kr.tradingview.com/" rel="noopener nofollow" target="_blank"><span class="blue-text">트레이딩뷰에서 모든 시장 추적</span></a></div>
  <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-market-overview.js" async>
  {
  "colorTheme": "light",
  "dateRange": "12M",
  "showChart": false,
  "locale": "kr",
  "width": "100%",
  "height": "100%",
  "largeChartUrl": "",
  "isTransparent": false,
  "showSymbolLogo": true,
  "showFloatingTooltip": false,
  "tabs": [
    {
      "title": "Indices",
      "symbols": [
        {
          "s": "KRX:005930",
          "d": "삼성전자"
        },
        {
          "s": "KRX:352820",
          "d": "HYBE"
        },
        {
          "s": "KRX:005380",
          "d": "HYNDAI MTR"
        },
        {
          "s": "KRX:293490",
          "d": "KAKAO GAMES"
        },
        {
          "s": "KRX:000660",
          "d": "SK HYNIX"
        },
        {
          "s": "KRX:035420",
          "d": "NAVER"
        },
        {
          "s": "KRX:035720",
          "d": "KAKAO"
        },
        {
          "s": "KRX:006400",
          "d": "SAMSUNG SDI CO.,LTD."
        },
        {
          "s": "KRX:267260",
          "d": "HD HYUNDAI ELECTRIC"
        }
      ],
      "originalTitle": "Indices"
    },
    {
      "title": "Crypto",
      "symbols": [
        {
          "s": "UPBIT:BTCKRW",
          "d": " BITCOIN / KRW"
        },
        {
          "s": "UPBIT:ETHKRW",
          "d": "ETHEREUM / KRW"
        },
        {
          "s": "UPBIT:BSVKRW",
          "d": " BITCOIN SV / KRW"
        }
      ]
    }
  ]
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
            widget.watchListString,
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
