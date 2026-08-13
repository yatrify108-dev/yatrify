import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yatrify/core/models/temple.dart';
import 'package:yatrify/core/services/locale_service.dart';
import 'package:yatrify/utils/color.schemes.g.dart';
import 'package:yatrify/utils/extensions.dart';

class SevaInfoPage extends StatelessWidget {
  const SevaInfoPage({
    super.key,
    required this.services,
    required this.calender,
    required this.webLogo,
    this.showSevaInfoNote,
    this.sevaInfoNoteText,
  });

  final List<Services> services;
  final Map<String, List<String>>? calender;
  final String webLogo;
  final bool? showSevaInfoNote;
  final Map<String, String>? sevaInfoNoteText;

  @override
  Widget build(BuildContext context) {
    final label = context.labels;
    final localizedNoteText = LocaleService.getLocalized(sevaInfoNoteText);
    final sevaServices = services.where((s) => s.showService ?? false).toList();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text(
          label.sevaInfo,
          style: context.style.titleLarge!
              .copyWith(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.temple_hindu_sharp, color: Colors.amber.shade700),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if ((showSevaInfoNote ?? false) &&
                  localizedNoteText.isNotEmpty) ...[
                // Text(
                //           localizedNoteText,
                //           style: context.style.titleSmall,
                //           textAlign: TextAlign.center,
                //         ),
                Container(
                  padding: const EdgeInsets.all(12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: bgColor.withOpacity(0.5),
                    //border: Border.all(color: const Color(0xFFFDE68A)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        color: Colors.amber.shade800,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          localizedNoteText,
                          style: const TextStyle(
                            fontSize: 12.5,
                            color: fontcolor,
                            height: 1.35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
              Row(
                children: [
                  const Expanded(child: Divider(thickness: 1, endIndent: 10)),
                  Icon(Icons.star_rate_rounded,
                      size: 14, color: Colors.brown.shade400),
                  const SizedBox(width: 6),
                  Text(
                    label.availableSevas,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: fontcolor,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(Icons.star_rate_rounded,
                      size: 14, color: Colors.brown.shade400),
                  const Expanded(child: Divider(thickness: 1, indent: 10)),
                ],
              ),
              const SizedBox(height: 16),
              ListView.separated(
                itemCount: sevaServices.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final service = sevaServices[index];

                  final title = LocaleService.getLocalized(service.name);
                  final subTitle = service.purpose != null
                      ? LocaleService.getLocalized(service.subTitle)
                      : null;

                  return _buildSevaTile(
                    title: title,
                    subTitle: subTitle,
                    icon: service.icon,
                    onTap: () {
                      context.push(
                        '/service-details',
                        extra: {
                          'service': service,
                          'calendar': calender,
                          'webLogo': webLogo,
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildSevaTile({
  required String title,
  String? subTitle,
  required String icon,
  VoidCallback? onTap,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.grey.shade200),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.03),
          blurRadius: 5,
          offset: const Offset(0, 2),
        ),
      ],

      // BoxShadow(
      //         color: Colors.black.withOpacity(0.08),
      //         blurRadius: 4,
      //         spreadRadius: 1,
      //         offset: const Offset(0, 0),
      //       ),
    ),
    child: ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(shape: BoxShape.circle, color: bgColor),
        child: icon.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: icon,
                height: 22,
                width: 22,
                errorWidget: (context, url, error) => const Icon(
                  Icons.local_fire_department_outlined,
                  size: 20,
                  color: fontcolor,
                ),
                fit: BoxFit.contain,
              )
            : Image.asset(
                'assets/icon/service_icon.png',
                height: 20,
                width: 20,
              ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: fontcolor,
        ),
      ),
      subtitle: (subTitle != null && subTitle.isNotEmpty)
          ? Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                subTitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  height: 1.25,
                ),
              ),
            )
          : null,
      trailing: const Icon(
        Icons.chevron_right_rounded,
        size: 28,
      ),
    ),
  );
}
