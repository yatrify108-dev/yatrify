import 'package:bookstay/utils/extensions.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final label = context.labels;
    return Scaffold(
      appBar: AppBar(
        title: Text(label.notification),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("No notifications yet", style: context.style.titleMedium,))
        ],
      ),
    );
  }
}