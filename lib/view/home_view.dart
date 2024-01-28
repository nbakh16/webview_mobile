import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_mobile/view/my_webview.dart';
import '../config/web_navigator.dart';
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
      onPopInvoked: (_) => WebNavigator.goBack(
        context,
        webViewController,
        canPop: true,
      ),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56.0), //appbar height
          child: AppBar(
            title: appbarText(),
            actions: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => WebNavigator.goBack(
                      context,
                      webViewController,
                    ),
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  IconButton(
                    onPressed: () => WebNavigator.goForward(
                      context,
                      webViewController,
                    ),
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
