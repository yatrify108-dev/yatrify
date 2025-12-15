import 'package:yatrify/utils/color.schemes.g.dart';
import 'package:yatrify/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class ServiceDetailCard extends StatelessWidget {
  const ServiceDetailCard({
    super.key,
    required this.title,
    required this.details,
    required this.icon,
  });

  final String title;
  final String details;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: context.scheme.outlineVariant.withOpacity(0.4),
                blurRadius: 6,
                offset: const Offset(0, 4))
          ]),
      child: 
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 26,
          ),
          const SizedBox(
            width: 14,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: context.style.titleLarge!
                        .copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 8,
                ),
                // ReadMoreText(
                //   details,
                //   trimLines: 4,
                //   trimMode: TrimMode.Line,
                //   trimCollapsedText: ' Read More',
                //   trimExpandedText: ' Read Less',
                //   moreStyle: context.style.bodyMedium!.copyWith(
                //     fontSize: 14,
                //     color: primaryColor,
                //     fontWeight: FontWeight.bold,
                //   ), // style for "Read more/less"
                //   lessStyle: context.style.bodyMedium!.copyWith(
                //     fontSize: 14,
                //     color: primaryColor,
                //     fontWeight: FontWeight.bold,
                //   ),
                //   style: context.style.bodyMedium!.copyWith(
                //     fontSize: 16,
                    
                //   ),
                // ),
                HtmlWidget(
                  details,
                  textStyle: context.style.bodyMedium!.copyWith(fontSize: 16),
                  enableCaching: true,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
