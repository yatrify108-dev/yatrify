import 'package:flutter/material.dart';

class RatingCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Start from left-bottom
    path.moveTo(0, size.height);
    path.lineTo(size.width * 0.45, size.height);

    // Curve up
    path.quadraticBezierTo(
      size.width * 0.5, 0, // control point (top of curve)
      size.width * 0.55, size.height,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
