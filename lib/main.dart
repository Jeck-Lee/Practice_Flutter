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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

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
      initialUrlRequest: URLRequest(url: WebUri("https://naver.com"),),
      initialSettings: InAppWebViewSettings(
        // URL 로딩 제어
        useShouldOverrideUrlLoading: true,
        // 미디어 자동 재생
        mediaPlaybackRequiresUserGesture: false,
        javaScriptEnabled: true,
        // 팝업 여부
        javaScriptCanOpenWindowsAutomatically: true,
        // 하이브리드 사용을 위한 안드로이드 웹뷰 최적화
        useHybridComposition: true,
        // 멀티 윈도우 허용
        supportMultipleWindows: true,
        // 웹뷰 내 미디어 재생 허용
        allowsInlineMediaPlayback: true,
        transparentBackground: true,
        // iOS option
        disallowOverScroll: true,
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
        title: Text(widget.title),
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
