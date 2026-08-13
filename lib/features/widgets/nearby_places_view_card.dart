import 'package:yatrify/core/models/base_banner.dart';
import 'package:yatrify/core/models/temple.dart';
import 'package:yatrify/core/services/locale_service.dart';
import 'package:yatrify/features/firebase_manager/firebase_manager.dart';
import 'package:yatrify/features/widgets/app_button.dart';
import 'package:yatrify/features/widgets/banner_carousel.dart';
import 'package:yatrify/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:go_router/go_router.dart';

class NearByPlacesViewCard extends StatelessWidget {
  const NearByPlacesViewCard({
    super.key,
    required this.nearByPlaces,
  });

  final NearByPlaces nearByPlaces;

  @override
  Widget build(BuildContext context) {
    final label = context.labels;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.65,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16)
                .copyWith(bottom: 80),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BannerCarousel(
                    borderRadius: 12,
                    screenHeightValue: 240,
                    banners: nearByPlaces.images!
                        .map((url) => BaseBanner(bannerImage: url, link: null))
                        .toList(),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  HtmlWidget(
                    LocaleService.getLocalized(nearByPlaces.description),
                    textStyle: context.style.bodyMedium!.copyWith(fontSize: 16),
                    enableCaching: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 12,
            right: 16,
            left: 16,
            child: AppButton(
              label: label.direction,
              onPressed: () {
                try {
                  context.pop();
                  nearByPlaces.weblink.launch();
                  FirebaseManager().logEvent(FirebaseEvent.buttonClick,
                      parameters: {'button_name': 'direction'});
                } catch (e, stackTrace) {
                  FirebaseManager().reportError(
                    e,
                    stackTrace,
                  );
                }

                // context.push('/redirect-page',
                //     extra: {
                //           'url': nearByPlaces.weblink,
                //         },);
              },
            ),
          ),
        ],
      ),
    );
  }
}
