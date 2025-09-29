import 'package:bookstay/utils/extensions.dart';
import 'package:flutter/material.dart';

class CustomConatiner extends StatelessWidget {
  const CustomConatiner({super.key, required this.child, this.color, this.padding, this.borderRadius});

  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  padding ?? const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        border: Border.all(color: color ?? context.scheme.outlineVariant.withOpacity(0.5)),
      ),
      child: child,
    );
  }
}