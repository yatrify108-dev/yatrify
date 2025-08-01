import 'package:flutter/material.dart';

class BottomCurveClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    final path = Path();
    
    
    // Start from top-left
    path.lineTo(0, 0); // Top edge
    path.lineTo(0, size.height); // Left side

    // Flat start
    path.lineTo(size.width * 0.4, size.height);

    // Slight curve upward
    path.quadraticBezierTo(
      size.width * 0.45,
      size.height - 30,
      size.width * 0.5,
      size.height - 30,
    );

    // Continue straight at raised level
    path.lineTo(size.width, size.height - 30);

    // Close to top-right
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
  
}