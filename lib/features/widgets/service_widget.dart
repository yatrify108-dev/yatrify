import 'package:bookstay/core/models/temple.dart';
import 'package:bookstay/features/providers/router_provider.dart';
import 'package:bookstay/features/widgets/custom_conatiner.dart';
import 'package:bookstay/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utils/color.schemes.g.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
    required this.services,
    required this.calender,
  });

  final Services services;
  final Map<String, List<String>>? calender;

  @override
  Widget build(BuildContext context) {
    final label = context.labels;
    return GestureDetector(
      onTap: () {
        context.push(
          '/service-details',
          extra: {
            'service': services,
            'calendar': calender,
          },
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(16),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              // height: 40,
              // width: 40,
              decoration:
                  const BoxDecoration(shape: BoxShape.circle, color: bgColor),
              child: Image.asset(
                'assets/icon/service_icon.png',
                height: 18,
                width: 18,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              services.name,
              style: context.style.titleSmall!.copyWith(
                  color: fontcolor, fontWeight: FontWeight.bold,),
              maxLines: 2,
            ),
            // Expanded(
            //   child: Text(
            //     label.forBlessings,
            //     style: context.style.bodyMedium!
            //         .copyWith(color: fontcolor, fontSize: 14),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
