import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Expanded(
            child: ListTile(
              title: Text('My Location'),
            ),
          )
        ],
      );
  }
}