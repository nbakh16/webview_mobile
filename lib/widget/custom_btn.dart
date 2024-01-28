import 'package:flutter/material.dart';

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
          backgroundColor: btnColor ?? Colors.purple,
          foregroundColor: textColor ?? Colors.white,
          padding: padding ??
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
          ),
          side: BorderSide(
            color: color ?? Colors.purple,
            width: borderWidth ?? 0,
          ),
        ),
        child: FittedBox(child: Text(text)),
      ),
    );
  }
}
