import 'package:flutter/material.dart';

import 'custom_btn.dart';

void customConfirmationDialog({
  required BuildContext context,
  required String title,
  subtitle,
  okBtnText,
  noBtnText,
  required void Function()? onPressed,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, anim1, anim2) {
      return const SizedBox();
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return ScaleTransition(
        scale: Tween<double>(begin: 0.5, end: 1).animate(anim1),
        child: FadeTransition(
          opacity: Tween<double>(begin: 0.5, end: 1).animate(anim1),
          child: AlertDialog(
            backgroundColor: Colors.white,
            titlePadding:
                const EdgeInsets.only(left: 0, top: 32, right: 0, bottom: 16),
            contentPadding:
                const EdgeInsets.only(left: 16, top: 0, right: 16, bottom: 32),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                // IconButton(
                //   onPressed: () {
                //     Get.back();
                //   },
                //   icon: const Icon(
                //     Icons.cancel_outlined,
                //     color: kRed,
                //   ),
                // ),
              ],
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryBtn(
                        noBtnText,
                        height: 46,
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 12),
                        btnColor: Colors.white,
                        textColor: Colors.purple,
                        borderWidth: 1.25,
                        elevation: 0,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: PrimaryBtn(
                        okBtnText,
                        height: 46,
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 12),
                        onPressed: onPressed,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide.none),
          ),
        ),
      );
    },
  );
}
