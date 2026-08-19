import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:yatrify/utils/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SmallBannerCard extends StatelessWidget {
  const SmallBannerCard({
    super.key,
    required this.image,
    required this.url,
    this.details,
  });

  final String image;
  final String url;
  final String? details;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (url.isNotEmpty) {
            url.launch();
            // context.push(
            //   '/redirect-page',
            //   extra: {
            //     'url': url,
            //   },
            // );
          }
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              Positioned.fill(
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                ),
              ),
              if (details != null && details!.isNotEmpty)
                Positioned(
                  left: 8,
                  right: 8,
                  top: 8,
                  bottom: 8,
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: HtmlWidget(
                      details!,
                      enableCaching: true,
                    ),
                  ),
                ),
            ],
          ),
        ));
  }
}
