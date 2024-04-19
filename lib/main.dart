import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

void main() {
  HttpOverrides.global = NoCheckCertificateHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WebViewExample(),
    );
  }
}

class WebViewExample extends StatefulWidget {
  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class NoCheckCertificateHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class _WebViewExampleState extends State<WebViewExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: 'http://ceprj.gachon.ac.kr:60007/', // 여기에 원하는 URL을 입력하세요.
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest request) {
          // 여기에서 request.url을 검사하여 특정 조건에 따라 페이지 로딩을 허용하거나 방지할 수 있습니다.
          // 예를 들어, 특정 도메인만 허용하려면 아래와 같이 조건을 추가합니다.
          if (request.url.startsWith('https://ceprj.gachon.ac.kr')) {
            return NavigationDecision.navigate; // 허용
          }
          return NavigationDecision.prevent; // 방지
        },
      ),
    );
  }
}
