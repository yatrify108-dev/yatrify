import 'package:bookstay/core/models/base_banner.dart';
import 'package:bookstay/utils/color.schemes.g.dart';
import 'package:bookstay/utils/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../screens/responsive.dart';

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key, required this.banners, this.screenHeightValue, this.autoPlay});

  final List<BaseBanner> banners;
  final double? screenHeightValue;
  final bool? autoPlay;

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  @override
  void dispose() {
    _currentIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    final validBanner = widget.banners
        .where((banner) => banner.bannerImage!.isNotEmpty)
        .toList();

    final double sliderHeight = widget.screenHeightValue ?? (Responsive.isDesktop(context)
        ? 300
        : Responsive.isMobile(context)
            ?screenHeight * 0.5
            : 200);

    // Future<void> _launchUrl(String? url) async {
    //   if (url == null || url.isEmpty) return;

    //   final Uri uri = Uri.parse(url);
    //   if (await canLaunchUrl(uri)) {
    //     await launchUrl(
    //       uri,
    //       mode: LaunchMode.platformDefault,
    //     );
    //   } else {
    //     debugPrint("could not lunch $url");
    //   }
    // }

    return CarouselSlider(
      options: CarouselOptions(
        height: sliderHeight,
        autoPlay: widget.autoPlay ?? false,
        enlargeCenterPage: true,
        viewportFraction: 1,
        autoPlayInterval: const Duration(seconds: 3),
        onPageChanged: (index, reason) {
          _currentIndex.value = index;
        },
        enableInfiniteScroll: validBanner.length > 1,
        scrollPhysics: validBanner.length > 1
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(),

        // aspectRatio: 16/9,
      ),
      items: validBanner.map(
        (banner) {
          return Builder(
            builder: (BuildContext content) {
              return GestureDetector(
                onTap: () {
                  // _launchUrl(banner.link);
                  banner.link!.launch();
                },
                child: Stack(
                  children: [
                    ClipRRect(
                      // borderRadius: BorderRadius.circular(12),
                      child: banner.bannerImage != null &&
                              banner.bannerImage!.startsWith('http')
                          ? CachedNetworkImage(
                              imageUrl: banner.bannerImage ?? '',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: sliderHeight,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            )
                          : Image.asset(
                              banner.bannerImage ?? '',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: sliderHeight,
                              // alignment: Alignment.topCenter,
                            ),
                    ),
                    if (validBanner.length > 1)
                      Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: ValueListenableBuilder<int>(
                          valueListenable: _currentIndex,
                          builder: (context, current, _) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: List.generate(
                                validBanner.length,
                                (i) => Container(
                                  width: 6,
                                  height: 6,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: i == current
                                        ? primaryColor
                                        : whiteColor,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              );
            },
          );
        },
      ).toList(),
    );
  }
}
