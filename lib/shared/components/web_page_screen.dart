import 'package:flutter/material.dart';
import 'package:thara_coffee/shared/components/size_manager.dart';
import 'package:thara_coffee/shared/router/http%20utils/http_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPageScreen extends StatefulWidget {
  const WebPageScreen(
      {super.key,
      this.url,
      required this.webLoginType,
      this.restrictOtherRedirections = false});
  final String? url;
  final WebLoginType webLoginType;
  final bool restrictOtherRedirections;

  @override
  State<WebPageScreen> createState() => _WebPageScreenState();
}

class _WebPageScreenState extends State<WebPageScreen> {
  late WebViewController controller;
  bool isLoading = true;
  bool isWebRedirectionTokenFetching = false;
  late final WebViewCookieManager cookieManager = WebViewCookieManager();
  void clearCookies() async {
    await cookieManager.clearCookies();
  }

  @override
  void dispose() {
    // controller.dispose();  // Dispose the controller properly
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    clearCookies();
    controller = WebViewController()
      ..clearLocalStorage()
      ..clearCache()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (mounted) {
              setState(() {
                // You can also log progress to see if it's working correctly
                print('Loading progress: $progress%');
                if (progress == 100) {
                  isLoading = false;
                }
              });
            }
          },
          onPageStarted: (String url) {
            if (mounted) {
              setState(() {
                isLoading = true;
              });
            }
          },

          onPageFinished: (String url) {
            if (mounted) {
              setState(() {
                isLoading = false;
              });
            }
          },
          onWebResourceError: (WebResourceError error) {
            print('Error loading web resource: $error');
          },
          // onNavigationRequest: (NavigationRequest request) {
          //   if (widget.restrictOtherRedirections && request.url != widget.url) {
          //     _showNavigationPreventedDialog(context);
          //     return NavigationDecision.prevent;
          //   }
          //   return NavigationDecision.navigate;
          // },
          // onNavigationRequest: (NavigationRequest request) {
          //   // if (!request.url.startsWith('https://easify.app')) {
          //   //   return NavigationDecision.prevent;
          //   // }
          //   // return NavigationDecision.navigate;
          // },
        ),
      );
    if (widget.webLoginType == WebLoginType.non) {
      controller.loadRequest(Uri.parse(widget.url ?? ''));
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(KPadding.h12),
            child: WebViewWidget(controller: controller),
          ),
          if (isLoading || isWebRedirectionTokenFetching)
            const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
        ],
      ),
    );
  }

  void _showNavigationPreventedDialog(BuildContext parentContext) {
    HttpHelper.handleMessage(
      'You are trying to navigate to a restricted URL.',
      context,
      useParentContext: true,
    );
  }
}

enum WebLoginType {
  dashboard,
  payment,
  non,
}
