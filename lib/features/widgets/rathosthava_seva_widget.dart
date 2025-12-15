import 'package:yatrify/core/models/temple.dart';
import 'package:yatrify/utils/color.schemes.g.dart';
import 'package:yatrify/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';

class RathosthavaSevaWidget extends StatelessWidget {
  const RathosthavaSevaWidget({
    super.key,
    required this.rathotsavaSevaList,
    this.note,
    this.contactDetails,
  });

  final List<RathotsavaSevaList> rathotsavaSevaList;
  final String? note;
  final String? contactDetails;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: rathotsavaSevaList.length,
            separatorBuilder: (context, index) => Divider(
              thickness: 1,
              color: primaryColor.withOpacity(0.4),
              height: 32,
            ),
            itemBuilder: (context, index) {
              final r = rathotsavaSevaList[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          r.name,
                          style: context.style.titleMedium!.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      if (r.price?.isNotEmpty ?? false)
                        Text(
                          r.price!,
                          style: context.style.titleMedium!.copyWith(
                              fontWeight: FontWeight.bold, color: primaryColor),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  HtmlWidget(
                    r.description,
                    textStyle: context.style.bodyMedium!.copyWith(fontSize: 16),
                  //  textStyle: context.style.titleMedium,
                    enableCaching: true,
                  ),
                ],
              );
            },
          ),
          if (note!.isNotEmpty) ...[
            const SizedBox(height: 40),
            HtmlWidget(
              note!,
              textStyle: context.style.bodyMedium!.copyWith(fontSize: 16),
            //  textStyle: context.style.titleMedium,
              enableCaching: true,
            ),
          ],
          if (contactDetails!.isNotEmpty) ...[
            const SizedBox(height: 40),
            HtmlWidget(
              contactDetails!,
              textStyle: context.style.bodyMedium!.copyWith(fontSize: 16),
              onTapUrl: (url) async {
                final uri = Uri.parse(url);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(
                    uri,
                    mode: LaunchMode.platformDefault,
                  );
                  return true;
                } else {
                  debugPrint('Could not launch $url');
                  return false;
                }
              },
            ),
          ],
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
