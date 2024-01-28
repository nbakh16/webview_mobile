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

  Future<String> getAppBarTitle() async {
    final title = await webViewController.getTitle();
    setState(() {});
    return title ?? 'Loading..';
  }

  void goBack() async {
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    if (await webViewController.canGoBack()) {
      await webViewController.goBack();
    } else {
      messenger.showSnackBar(
        const SnackBar(
          content: Text("Can't go back"),
        ),
      );
      return;
    }
  }

  void goForward() async {
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    if (await webViewController.canGoForward()) {
      await webViewController.goForward();
    } else {
      messenger.showSnackBar(
        const SnackBar(
          content: Text("Can't go forward"),
        ),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    FutureBuilder<String> appbarText() {
      return FutureBuilder<String>(
        future: getAppBarTitle(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(
              snapshot.data!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall,
            );
          } else if (snapshot.hasError) {
            return const Icon(
              Icons.warning,
              color: Colors.redAccent,
              size: 32,
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      );
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (popped) => goBack(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56.0), //appbar height
          child: AppBar(
            title: appbarText(),
            actions: [
              Row(
                children: [
                  IconButton(
                    onPressed: goBack,
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  IconButton(
                    onPressed: goForward,
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
        ),
        body: MyWebView(controller: webViewController),
      ),
    );
  }
}
