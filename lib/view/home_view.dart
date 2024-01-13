import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_mobile/view/my_webview.dart';
import '../web_url.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final WebViewController webViewController;

  @override
  void initState() {
    super.initState();
    webViewController = WebViewController()
      ..loadRequest(
        Uri.parse(webUrl),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Webview'),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  final ScaffoldMessengerState messenger =
                      ScaffoldMessenger.of(context);
                  if (await webViewController.canGoBack()) {
                    await webViewController.goBack();
                  } else {
                    messenger.showSnackBar(
                      const SnackBar(
                        content: Text('Cant go back'),
                      ),
                    );
                    return;
                  }
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              IconButton(
                onPressed: () async {
                  final ScaffoldMessengerState messenger =
                      ScaffoldMessenger.of(context);
                  if (await webViewController.canGoForward()) {
                    await webViewController.goForward();
                  } else {
                    messenger.showSnackBar(
                      const SnackBar(
                        content: Text('Cant go forward'),
                      ),
                    );
                    return;
                  }
                },
                icon: const Icon(Icons.arrow_forward_ios),
              ),
              IconButton(
                onPressed: () {
                  webViewController.reload();
                },
                icon: const Icon(Icons.replay),
              ),
            ],
          )
        ],
      ),
      body: MyWebView(controller: webViewController),
    );
  }
}
