import 'package:yatrify/core/models/temple.dart';
import 'package:yatrify/core/services/locale_service.dart';
import 'package:yatrify/features/firebase_manager/firebase_manager.dart';
import 'package:yatrify/utils/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utils/color.schemes.g.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
    required this.services,
    required this.calender,
    required this.webLogo,
  });

  final Services services;
  final Map<String, List<String>>? calender;
  final String webLogo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          '/service-details',
          extra: {
            'service': services,
            'calendar': calender,
            'webLogo': webLogo,
          },
        );
        FirebaseManager().logEvent(
          FirebaseEvent.buttonClick,
          parameters: {'button_name': '${services.name}_service'},
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
                offset: const Offset(0, 0),
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              // height: 40,
              // width: 40,
              decoration:
                  const BoxDecoration(shape: BoxShape.circle, color: bgColor),
              child: services.icon.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: services.icon,
                      height: 20,
                      width: 20,
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error,
                        size: 18,
                        color: primaryColor,
                      ),
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/icon/service_icon.png',
                      height: 18,
                      width: 18,
                    ),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: Text(
                LocaleService.getLocalized(services.name),
                style: context.style.titleSmall!.copyWith(
                  color: fontcolor,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 3,
              ),
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
