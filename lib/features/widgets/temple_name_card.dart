import 'package:bookstay/features/constant/const_string.dart';
import 'package:bookstay/features/screens/temple_upload_screen.dart';
import 'package:bookstay/utils/color.schemes.g.dart';
import 'package:bookstay/utils/extensions.dart';
import 'package:flutter/material.dart';

class TempleNameCard extends StatelessWidget {
  const TempleNameCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
           BoxShadow(
            color: Colors.black.withOpacity(0.09),
            blurRadius: 4,
            spreadRadius: 1,
            offset: const Offset(0, 0)
          )
        ]
      ),
      child: Column(
        children: [
          Text(
            ConstString.templeName,
            textAlign: TextAlign.center,
            style: context.style.titleLarge!.copyWith(
                color: fontcolor, fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            ConstString.address,
            textAlign: TextAlign.center,
            style: context.style.titleMedium!.copyWith(color: fontcolor),
          ),
        ],
      ),
    );
  }
}
