import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../widget/custom_alert_dialog.dart';

class WebNavigator {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  static void goBack(BuildContext context, WebViewController webViewController,
      {bool canPop = false}) async {
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    if (await webViewController.canGoBack()) {
      await webViewController.goBack();
    } else {
      if (canPop) {
        customConfirmationDialog(
            context: context,
            title: 'Exit',
            subtitle: 'Are you sure to Exit?',
            noBtnText: 'No',
            okBtnText: 'Exit',
            onPressed: () {
              SystemNavigator.pop();
            });
      } else {
        messenger.showSnackBar(
          customSnackBar("Can't go back"),
        );
      }
      return;
    }
  }

  static void goForward(
      BuildContext context, WebViewController webViewController) async {
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    if (await webViewController.canGoForward()) {
      await webViewController.goForward();
    } else {
      messenger.showSnackBar(
        customSnackBar("Can't go forward"),
      );
      return;
    }
  }

  static SnackBar customSnackBar(String msg) {
    return SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 2),
    );
  }
}
