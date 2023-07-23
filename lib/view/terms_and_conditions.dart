import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TandC extends StatefulWidget {
  const TandC({super.key});

  @override
  State<TandC> createState() => _TandCState();
}

class _TandCState extends State<TandC> {
  late WebViewController _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://findkolkata.com/termsAndConditions.php'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: WebViewWidget(
        controller: _controller,
      ),
    ));
  }
}
