import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  const Responsive({super.key, required this.mobile, required this.desktop});

  final Widget mobile;
  final Widget desktop;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 900;

  static bool isTablet(BuildContext context) =>
    MediaQuery.of(context).size.width >= 650 &&
    MediaQuery.of(context).size.width < 900;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 900) {
          return desktop;
        } else {
          return mobile;
        }
      },
    );
  }
}

double getResponsiveHorizontalPadding(BuildContext context){
  final width = MediaQuery.of(context).size.width;

  if(width >= 1200) return 80;
  if(width >= 900) return 24;
  return 16;
}

double getResponsiveImageHeight(BuildContext context){
  if(Responsive.isDesktop(context)) return 120;
  if(Responsive.isTablet(context)) return 100;
  return 80;
}

double getRsponsiveImageWidth(BuildContext context){
  if(Responsive.isDesktop(context)) return 180;
  if(Responsive.isTablet(context)) return 160;
  return 140;
}