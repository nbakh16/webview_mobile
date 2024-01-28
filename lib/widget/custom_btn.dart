import 'package:flutter/material.dart';
import 'package:webview_mobile/config/color.dart';

class PrimaryBtn extends StatelessWidget {
  final Color? color;
  final Color? textColor;
  final Color? btnColor;
  final String text;
  final VoidCallback? onPressed;
  final double? borderRadius;
  final double? height;
  final double? width;
  final double? borderWidth;
  final double? elevation;
  final TextStyle? style;
  final EdgeInsetsGeometry? padding;

  const PrimaryBtn(
    this.text, {
    Key? key,
    this.color,
    this.textColor,
    this.btnColor,
    this.onPressed,
    this.borderRadius,
    this.style,
    this.height,
    this.width,
    this.borderWidth,
    this.elevation,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      // decoration: BoxDecoration(boxShadow: [kbtnShadow]),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: elevation ?? 2,
          textStyle: style ??
              Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white),
          disabledBackgroundColor: Colors.grey,
          disabledForegroundColor: Colors.white,
          backgroundColor: btnColor ?? kPrimaryColor,
          foregroundColor: textColor ?? Colors.white,
          padding: padding ??
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
          ),
          side: BorderSide(
            color: color ?? kPrimaryColor,
            width: borderWidth ?? 0,
          ),
        ),
        child: FittedBox(child: Text(text)),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    this.onTap,
    required this.icon,
  });

  final void Function()? onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        icon,
        color: Colors.white,
        size: 28,
      ),
    );
  }
}
