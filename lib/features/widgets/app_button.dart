import 'package:yatrify/utils/color.schemes.g.dart';
import 'package:yatrify/utils/extensions.dart';
import 'package:flutter/material.dart';

enum AppButtonType { filled, oulined }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
     this.onPressed,
    this.type = AppButtonType.filled,
    this.color,
    this.borderRadius = 8,
    this.textstyle,
    this.padding,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final Color? color;
  final double borderRadius;
  final TextStyle? textstyle;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final textColor = type == AppButtonType.filled ? whiteColor : primaryColor;
    final bgColor =
        type == AppButtonType.filled ? primaryColor : Colors.transparent;
    final side = type == AppButtonType.oulined
        ? BorderSide(color: color ?? primaryColor)
        : BorderSide.none;

    return FilledButton(
      style: FilledButton.styleFrom(
          padding: padding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          foregroundColor: textColor,
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: side,
          ),),
      onPressed: onPressed,
      child: 
      Text(
          label,
          style: 
              context.style.titleMedium!
                  .copyWith(color: textColor, fontWeight: FontWeight.bold),
        ),
      // FittedBox(
      //   fit: BoxFit.scaleDown,
      //   child: Text(
      //     label,
      //     style: textstyle ??
      //         context.style.labelMedium!
      //             .copyWith(color: textColor, fontWeight: FontWeight.bold),
      //   ),
      // ),
    );
  }
}
