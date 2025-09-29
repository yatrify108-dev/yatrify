import 'package:bookstay/core/models/base_banner.dart';
import 'package:bookstay/core/models/temple.dart';
import 'package:bookstay/features/widgets/app_button.dart';
import 'package:bookstay/features/widgets/banner_carousel.dart';
import 'package:bookstay/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class NearbyPlacesView extends StatelessWidget {
  const NearbyPlacesView({super.key, required this.nearByPlaces});

  final NearByPlaces nearByPlaces;

  @override
  Widget build(BuildContext context) {
    final label = context.labels;
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
       bottomNavigationBar:
          (nearByPlaces.bookNowButton && nearByPlaces.weblink.isNotNullOrEmpty)
              ? Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewPadding.bottom + 16,
                    left: 16,
                    right: 16,
                    top: 16,
                  ),
                  child: AppButton(
                    label: label.bookNow,
                    onPressed: () {
                      nearByPlaces.weblink.launch();
                    },
                  ),
                )
              : const SizedBox.shrink(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BannerCarousel(
              screenHeightValue: MediaQuery.of(context).size.height * 0.35,
              autoPlay: true,
              banners: nearByPlaces.images!
                  .map((url) => BaseBanner(bannerImage: url, link: null))
                  .toList(),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: HtmlWidget(
                nearByPlaces.description,
                textStyle: context.style.bodyMedium!.copyWith(fontSize: 16),
                enableCaching: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
